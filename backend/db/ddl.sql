SET SCHEMA 'keen';
CREATE EXTENSION IF NOT EXISTS postgis;

DROP TABLE IF EXISTS "User";
DROP TABLE IF EXISTS "Event";
DROP TABLE IF EXISTS "Collection";
DROP TABLE IF EXISTS "Contains";
DROP TABLE IF EXISTS "Keened";
DROP TABLE IF EXISTS "Stores";


CREATE TABLE "User" (
    "email" VARCHAR(255) PRIMARY KEY,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "username" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "User" ADD CONSTRAINT "user_username_unique" UNIQUE("username");


CREATE TYPE PRIVACY_SETTING AS ENUM ('public', 'private');
CREATE TABLE "Event" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "visibility" PRIVACY_SETTING NOT NULL,
    "start" TIMESTAMPTZ,
    "end" TIMESTAMPTZ,
    "emoji" VARCHAR(20),
    "location" VARCHAR(255), -- geography(GEOMETRY, 4326),
    "url" TEXT,
    "description" TEXT
);


CREATE TABLE "Collection" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "description" TEXT,
    "user_email" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Collection" ADD CONSTRAINT "collection_user_email_foreign" FOREIGN KEY("user_email") REFERENCES "User"("email") 
    ON DELETE CASCADE; -- If a user is deleted, delete all their collections as well.


CREATE TABLE "Contains" (
    "event_id" INT,
    "collection_id" INT,
    "datetime_added" TIMESTAMPTZ DEFAULT NOW() 
);
ALTER TABLE
    "Contains" ADD PRIMARY KEY("event_id", "collection_id");
ALTER TABLE
    "Contains" ADD CONSTRAINT "contains_collection_foreign" FOREIGN KEY("collection_id") REFERENCES "Collection"("id")
    ON DELETE CASCADE; -- If a collection is deleted, delete all the references to events inside it as well.
ALTER TABLE
    "Contains" ADD CONSTRAINT "contains_event_id_foreign" FOREIGN KEY("event_id") REFERENCES "Event"("id")
    ON DELETE CASCADE; -- If an event is deleted, remove it from all collections it was in.


CREATE TABLE "Keened"(
    "user_email" VARCHAR(255),
    "event_id" INT 
);
ALTER TABLE
    "Keened" ADD PRIMARY KEY("user_email", "event_id");
ALTER TABLE
    "Keened" ADD CONSTRAINT "keened_user_email_foreign" FOREIGN KEY("user_email") REFERENCES "User"("email")
    ON DELETE CASCADE; -- If a user is deleted, they no longer have any events they are keen for.
ALTER TABLE
    "Keened" ADD CONSTRAINT "keened_event_id_foreign" FOREIGN KEY("event_id") REFERENCES "Event"("id")
    ON DELETE CASCADE; -- If an event is deleted, the user can no longer be keen for it.