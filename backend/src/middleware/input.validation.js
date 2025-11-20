const validateInput = (req, res, next) => {
  const {
    reg_number,
    phone,
    name,
    email,
    password,
    role,
    program,
    study_year,
  } = req.body;

  if (
    !reg_number ||
    !phone ||
    !name ||
    !email ||
    !password ||
    !role ||
    !program ||
    !study_year
  ) {
    return res
      .status(400)
      .json({ success: false, message: "All fields are required" });
  }
  req.validatedInputData = {
    reg_number,
    phone,
    name,
    email,
    password,
    role,
    program,
    study_year,
  };
  next();
};

export default validateInput;
