const generateOTP = () => {
  const alphabets = "a1b2c3d4e5f6g7h8i9j0k1l2m3k4o5pq7r8s9t0u1v2w3x4y5z";
  let gen_otp = "";
  for (let i = 0; i < 6; i++) {
    gen_otp += alphabets.charAt(Math.floor(Math.random() * alphabets.length));
  }
  return gen_otp.toUpperCase();
};
export default generateOTP;
