-- CREATE TABLE Queries

CREATE TABLE "User" (
  "email" varchar(50) PRIMARY KEY,
  "first_name" varchar(20),
  "last_name" varchar(20),
  "username" varchar(20) UNIQUE
);

CREATE TABLE "Visibility" (
  "id" int PRIMARY KEY,
  "type" varchar(10)
);

CREATE TABLE "Event" (
  "id" int PRIMARY KEY,
  "name" varchar(50),
  "location" varchar(50),
  "url" varchar(255),
  "emoji" varchar(20),
  "description" varchar(255),
  "visibility" int,
  "start" datetime,
  "end" datetime,
  FOREIGN KEY "visibility" REFERENCES Visibility.id
);

CREATE TABLE "Collection" (
  "id" int PRIMARY KEY,
  "name" varchar(50),
  "description" text,
  "u_email" varchar(50)
  FOREIGN KEY "u_email" REFERENCES User.email ON DELETE CASCADE
);

CREATE TABLE "EventCollected" (
  "event_id" int,
  "collection_id" int,
  "date_added" datetime,
  PRIMARY KEY ("event_id", "collection_id"),
  FOREIGN KEY "event_id" REFERENCES Event.id ON DELETE CASCADE,
  FOREIGN KEY "collection_id" REFERENCES Collection.id ON DELETE CASCADE
);

CREATE TABLE "Keened" (
  "u_email" varchar(50),
  "event_id" int,
  PRIMARY KEY ("u_email", "event_id"),
  FOREIGN KEY "u_email" REFERENCES User.email ON DELETE CASCADE,
  FOREIGN KEY "event_id" REFERENCES Event.id ON DELETE CASCADE
);