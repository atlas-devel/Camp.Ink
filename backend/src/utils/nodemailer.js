import nodemailer from "nodemailer";
import ENV from "./env.js";

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: ENV.OWNER_EMAIL,
    pass: ENV.OWNER_PASSWORD,
  },
});

export default transporter;
