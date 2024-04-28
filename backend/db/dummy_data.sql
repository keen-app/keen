INSERT INTO "User" ("email", "first_name", "last_name", "username") VALUES
('john.doe@example.com', 'John', 'Doe', 'johndoe'),
('jane.smith@example.com', 'Jane', 'Smith', 'janesmith'),
('alice.jones@example.com', 'Alice', 'Jones', 'alicejones');

INSERT INTO "Visibility" ("id", "type") VALUES
(1, 'public'),
(2, 'private');

INSERT INTO "Event" ("id", "name", "location", "url", "emoji", "description", "visibility", "start", "end") VALUES
(1, 'Tech Conference', 'Convention Center', 'http://techconf.com', '💻', 'Annual tech conference', 1, '2023-10-15 09:00', '2023-10-15 17:00'),
(1, 'Music Festival', 'Downtown', 'http://musicfest.com', '🎶', 'Outdoor music festival', 1, '2023-08-20 12:00', '2023-08-20 23:00'),
(1, 'Book Club', 'Local Library', NULL, '📚', 'Monthly book club meeting', 2, '2023-09-05 18:00', '2023-09-05 20:00');

INSERT INTO "Collection" ("id", "name", "description", "u_email") VALUES
(1, 'Tech Events', 'Collection of technology-related events', 'john.doe@example.com'),
(2, 'Summer Festivals', 'All the summer outdoor festivals', 'jane.smith@example.com'),
(3, 'Reading Nights', 'Sessions for avid readers', 'alice.jones@example.com');

INSERT INTO "EventCollected" ("event_id", "collection_id", "date_added") VALUES
(1, 1, '2023-04-01 12:00'),
(2, 2, '2023-04-02 12:00'),
(3, 3, '2023-04-03 12:00');

INSERT INTO "Keened" ("u_email", "event_id") VALUES
('john.doe@example.com', 1),
('jane.smith@example.com', 2),
('alice.jones@example.com', 3);
