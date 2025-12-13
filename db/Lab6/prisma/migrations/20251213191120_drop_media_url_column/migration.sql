-- CreateEnum
CREATE TYPE "friendship_status" AS ENUM ('pending', 'accepted', 'rejected');

-- CreateEnum
CREATE TYPE "user_status" AS ENUM ('online', 'offline');

-- CreateTable
CREATE TABLE "comment" (
    "id" SERIAL NOT NULL,
    "creator_id" INTEGER,
    "post_id" INTEGER,
    "text" VARCHAR(512),
    "views" INTEGER,
    "likes" INTEGER,
    "dislikes" INTEGER,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "community" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(32),
    "bio" VARCHAR(512),
    "avatar_url" VARCHAR(128),
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "community_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "communitypost" (
    "community_id" INTEGER NOT NULL,
    "post_id" INTEGER NOT NULL,

    CONSTRAINT "communitypost_pkey" PRIMARY KEY ("community_id","post_id")
);

-- CreateTable
CREATE TABLE "communitysubscription" (
    "community_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "communitysubscription_pkey" PRIMARY KEY ("community_id","user_id")
);

-- CreateTable
CREATE TABLE "friendship" (
    "user_id" INTEGER NOT NULL,
    "friended_id" INTEGER NOT NULL,
    "status" "friendship_status" NOT NULL,

    CONSTRAINT "friendship_pkey" PRIMARY KEY ("user_id","friended_id")
);

-- CreateTable
CREATE TABLE "member" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR(32) NOT NULL,
    "password_hash" VARCHAR NOT NULL,
    "email" VARCHAR NOT NULL,
    "status" "user_status" DEFAULT 'online',
    "bio" VARCHAR(256),
    "avatar_url" VARCHAR(256),
    "join_date" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "member_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "post" (
    "id" SERIAL NOT NULL,
    "creator_id" INTEGER,
    "title" VARCHAR(64),
    "text" VARCHAR(1024),
    "likes" INTEGER DEFAULT 0,
    "dislikes" INTEGER DEFAULT 0,
    "views" INTEGER DEFAULT 0,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "posttag" (
    "tag_id" INTEGER,
    "post_id" INTEGER
);

-- CreateTable
CREATE TABLE "tag" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(32),

    CONSTRAINT "tag_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "community_name_key" ON "community"("name");

-- CreateIndex
CREATE UNIQUE INDEX "member_username_key" ON "member"("username");

-- CreateIndex
CREATE UNIQUE INDEX "member_email_key" ON "member"("email");

-- CreateIndex
CREATE UNIQUE INDEX "tag_name_key" ON "tag"("name");

-- AddForeignKey
ALTER TABLE "comment" ADD CONSTRAINT "comment_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "member"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "comment" ADD CONSTRAINT "comment_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "post"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "communitypost" ADD CONSTRAINT "communitypost_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "community"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "communitypost" ADD CONSTRAINT "communitypost_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "post"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "communitysubscription" ADD CONSTRAINT "communitysubscription_community_id_fkey" FOREIGN KEY ("community_id") REFERENCES "community"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "communitysubscription" ADD CONSTRAINT "communitysubscription_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "member"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "friendship" ADD CONSTRAINT "friendship_friended_id_fkey" FOREIGN KEY ("friended_id") REFERENCES "member"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "friendship" ADD CONSTRAINT "friendship_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "member"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "post" ADD CONSTRAINT "post_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "member"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "posttag" ADD CONSTRAINT "posttag_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "post"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "posttag" ADD CONSTRAINT "posttag_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tag"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
