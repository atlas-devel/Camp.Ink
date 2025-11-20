import prisma from "../utils/prisma.js";
import bcrypt from "bcrypt";
import transporter from "../utils/nodemailer.js";
import ENV from "../utils/env.js";
import generateOTP from "../utils/otp.generator.js";

export const studentRegister = async (req, res) => {
  const {
    reg_number,
    phone,
    name,
    email,
    password,
    role,
    program,
    study_year,
  } = req.validatedInputData;

  const hashedpassword = await bcrypt.hash(password, 10);
  const existingStudent = await prisma.student.findUnique({
    where: {
      email: email,
      reg_number: reg_number,
    },
  });
  if (existingStudent) {
    throw new Error(
      "Student with this email or registration number already exists"
    );
  }
  console.log("test____");
  const OTP = generateOTP();
  const otp_expiration_time = BigInt(Date.now() + 60 * 60 * 1000);

  const otp_verification_options = {
    from: ENV.OWNER_EMAIL,
    to: email,
    subject: "Camp.Ink email verification",
    text:
      " Your OTP for email verification is " +
      OTP +
      ". It is valid for 1 hour. ",
  };

  const newStudent = {
    reg_number,
    name,
    phone,
    email,
    otp: OTP,
    otp_expiry: otp_expiration_time,
    password: hashedpassword,
    role,
    program,
    study_year,
  };
  try {
    await transporter.sendMail(otp_verification_options);
    const createStudent = await prisma.student.create({
      data: newStudent,
    });
    res.status(201).json({
      success: true,
      data: createStudent,
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Error sending email or creating student",
      error: error.message,
    });
  }
};

export const verifyOTP = async (req, res) => {
  const { student_id } = req.params;
  const { otp } = req.body;

  if (!otp) {
    return res.status(400).json({ success: false, message: "OTP is required" });
  }

  try {
    const existingStudent = await prisma.student.findUnique({
      where: {
        reg_number: student_id,
      },
    });

    if (!existingStudent) {
      throw new Error("Student not found");
    }
    if (existingStudent.otp !== otp) {
      return res.status(400).json({
        success: false,
        message: "Invalid OTP",
      });
    }
    if (existingStudent.otp_expiry < Date.now()) {
      return res.status(400).json({
        success: false,
        message: "OTP has expired",
      });
    }

    // updating student verification status
    const verifyStudent = await prisma.student.update({
      where: {
        reg_number: student_id,
      },
      data: { ...existingStudent, is_verified: true },
    });
    return res.status(200).json({
      success: true,
      data: verifyStudent,
      message: "Student verified successfully",
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Error verifying student",
      error: error.message,
    });
  }
};
