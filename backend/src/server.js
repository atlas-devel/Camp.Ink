import express from "express";
import StudentRouter from "./routes/student.routes.js";

const app = express();

// middlewares
app.use(express.json());
app.use("/api/students", StudentRouter);

const PORT = process.env.PORT || 4000;

app.listen(PORT, () =>
  console.log("server has started on http://localhost:" + PORT)
);
