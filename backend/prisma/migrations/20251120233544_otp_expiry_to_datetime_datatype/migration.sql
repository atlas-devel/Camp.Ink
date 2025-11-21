/*
  Warnings:

  - Changed the type of `otp_expiry` on the `Student` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Student" DROP COLUMN "otp_expiry",
ADD COLUMN     "otp_expiry" TIMESTAMP(3) NOT NULL;
