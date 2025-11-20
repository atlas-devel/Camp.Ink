import express from "express";
import validateInput from "../middleware/input.validation.js";
import { studentRegister, verifyOTP } from "../controllers/student.js";

const StudentRouter = express.Router();

StudentRouter.post("/register", validateInput, studentRegister).post(
  "/verify-otp/:student_id",
  verifyOTP
);

export default StudentRouter;
