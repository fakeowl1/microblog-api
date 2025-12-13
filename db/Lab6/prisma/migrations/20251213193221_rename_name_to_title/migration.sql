/*
  Warnings:

  - You are about to drop the column `name` on the `community` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[title]` on the table `community` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "community_name_key";

-- AlterTable
ALTER TABLE "community" DROP COLUMN "name",
ADD COLUMN     "title" VARCHAR(32);

-- CreateIndex
CREATE UNIQUE INDEX "community_title_key" ON "community"("title");
