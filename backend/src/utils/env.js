import { config } from "dotenv";
config();

const ENV = {
  OWNER_EMAIL: process.env.OWNER_EMAIL,
  OWNER_PASSWORD: process.env.OWNER_PASSWORD,
  PORT: process.env.PORT || 5000,
};

export default ENV;
