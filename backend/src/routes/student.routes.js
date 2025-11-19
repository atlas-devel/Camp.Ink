import express from "express";
import validateInput from "../middleware/input.validation.js";
import { studentRegister } from "../controllers/student.login.js";

const StudentRouter = express.Router();

StudentRouter.post("/register", validateInput, studentRegister);

export default StudentRouter;
