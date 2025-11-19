-- CreateEnum
CREATE TYPE "Role" AS ENUM ('Student', 'Printer');

-- CreateEnum
CREATE TYPE "Program" AS ENUM ('IT', 'CS', 'MTM');

-- CreateEnum
CREATE TYPE "Study_year" AS ENUM ('y1', 'y2', 'y3');

-- CreateEnum
CREATE TYPE "Paper_type" AS ENUM ('BW', 'Color');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('Pending', 'Printing', 'Delivered');

-- CreateEnum
CREATE TYPE "Payment_methods" AS ENUM ('Cash', 'Mobile');

-- CreateEnum
CREATE TYPE "Payment_status" AS ENUM ('Pending', 'Paid', 'Failed');

-- CreateTable
CREATE TABLE "Student" (
    "reg_number" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "program" "Program" NOT NULL,
    "study_year" "Study_year" NOT NULL,
    "class_number" TEXT,
    "otp" TEXT NOT NULL,
    "otp_expiry" INTEGER NOT NULL,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Student_pkey" PRIMARY KEY ("reg_number")
);

-- CreateTable
CREATE TABLE "Print_stuff" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Print_stuff_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Settings" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "discount_enabled" BOOLEAN NOT NULL DEFAULT false,
    "discount_price" INTEGER NOT NULL DEFAULT 0,
    "print_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Orders" (
    "id" SERIAL NOT NULL,
    "student_id" TEXT NOT NULL,
    "print_id" INTEGER NOT NULL,
    "paper_type" "Paper_type" NOT NULL DEFAULT 'BW',
    "prince" INTEGER NOT NULL,
    "copies" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Class_orders" (
    "id" SERIAL NOT NULL,
    "print_id" INTEGER NOT NULL,
    "file" TEXT NOT NULL,
    "paper_type" "Paper_type" NOT NULL DEFAULT 'BW',
    "copies" INTEGER NOT NULL DEFAULT 1,
    "status" "Status" NOT NULL DEFAULT 'Pending',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Class_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payments" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,
    "method" "Payment_methods" NOT NULL,
    "class_order_id" INTEGER,
    "amount" INTEGER NOT NULL,
    "status" "Payment_status" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Payments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Student_email_key" ON "Student"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Student_phone_key" ON "Student"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "Print_stuff_phone_key" ON "Print_stuff"("phone");

-- AddForeignKey
ALTER TABLE "Settings" ADD CONSTRAINT "Settings_print_id_fkey" FOREIGN KEY ("print_id") REFERENCES "Print_stuff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "Student"("reg_number") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_print_id_fkey" FOREIGN KEY ("print_id") REFERENCES "Print_stuff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Class_orders" ADD CONSTRAINT "Class_orders_print_id_fkey" FOREIGN KEY ("print_id") REFERENCES "Print_stuff"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payments" ADD CONSTRAINT "Payments_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "Orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payments" ADD CONSTRAINT "Payments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Student"("reg_number") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payments" ADD CONSTRAINT "Payments_class_order_id_fkey" FOREIGN KEY ("class_order_id") REFERENCES "Class_orders"("id") ON DELETE SET NULL ON UPDATE CASCADE;
