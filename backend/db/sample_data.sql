SET SCHEMA 'keen';

-- Insert Users
INSERT INTO "User" (email, first_name, last_name, username)
VALUES
    ('alice@example.com', 'Alice', 'Johnson', 'alicej'),
    ('bob@example.com', 'Bob', 'Smith', 'bobsmith'),
    ('carol@example.com', 'Carol', 'White', 'carolw'),
    ('dave@example.com', 'Dave', 'Brown', 'davebrown'),
    ('eve@example.com', 'Eve', 'Davis', 'eved'),
    ('frank@example.com', 'Frank', 'Miller', 'frankm'),
    ('grace@example.com', 'Grace', 'Williams', 'gracew'),
    ('hannah@example.com', 'Hannah', 'Jones', 'hannahj'),
    ('ian@example.com', 'Ian', 'Taylor', 'iant'),
    ('julia@example.com', 'Julia', 'Martinez', 'juliam');

-- Insert Events
INSERT INTO "Event" (name, visibility, "start", "end", emoji, location, url, description)
VALUES
    ('Tech Conference', 'public', '2024-07-20 09:00:00+00', '2024-07-20 18:00:00+00', '💻', 'Tech Center, Silicon Valley', 'http://techconference.com', 'A technology-focused conference with speakers and workshops.'),
    ('Music Festival', 'public', '2024-08-15 10:00:00+00', '2024-08-17 23:59:59+00', '🎵', 'Central Park, New York', 'http://musicfestival.com', 'An annual music festival featuring various artists.'),
    ('Art Exhibition', 'private', '2024-09-05 10:00:00+00', '2024-09-05 18:00:00+00', '🎨', 'Art Gallery, Paris', 'http://artexhibition.com', 'A private art exhibition showcasing contemporary artists.'),
    ('Book Fair', 'public', '2024-10-10 10:00:00+00', '2024-10-11 18:00:00+00', '📚', 'Convention Center, London', 'http://bookfair.com', 'A fair for book lovers and authors.'),
    ('Food Festival', 'public', '2024-11-20 10:00:00+00', '2024-11-21 18:00:00+00', '🍽️', 'Market Square, Paris', 'http://foodfestival.com', 'A food festival with international cuisine.'),
    ('Science Expo', 'private', '2024-12-01 09:00:00+00', '2024-12-01 17:00:00+00', '🔬', 'Science Museum, Chicago', 'http://scienceexpo.com', 'An expo showcasing scientific innovations.'),
    ('Gaming Convention', 'public', '2024-12-15 10:00:00+00', '2024-12-17 20:00:00+00', '🎮', 'Gaming Center, Tokyo', 'http://gamingconvention.com', 'A convention for gaming enthusiasts.'),
    ('Film Festival', 'public', '2025-01-05 10:00:00+00', '2025-01-10 23:59:59+00', '🎬', 'Film Center, Los Angeles', 'http://filmfestival.com', 'An international film festival featuring various genres.'),
    ('Dance Competition', 'private', '2025-02-14 10:00:00+00', '2025-02-14 18:00:00+00', '💃', 'Dance Studio, New York', 'http://dancecompetition.com', 'A private dance competition for professional dancers.'),
    ('Fashion Show', 'public', '2025-03-01 19:00:00+00', '2025-03-01 23:00:00+00', '👗', 'Fashion Center, Paris', 'http://fashionshow.com', 'A high-end fashion show featuring top designers.');

-- Insert Collections
INSERT INTO "Collection" (name, description, user_email)
VALUES
    ('Tech Events', 'Collection of technology-related events.', 'alice@example.com'),
    ('Music & Art', 'Events involving music and art.', 'carol@example.com'),
    ('Book & Science', 'Events related to books and science.', 'bob@example.com'),
    ('Food & Drinks', 'Events involving food and drinks.', 'eve@example.com'),
    ('Gaming & Film', 'Events related to gaming and films.', 'frank@example.com');

-- Insert Contains (relationships between collections and events)
INSERT INTO "Contains" (event_id, collection_id, datetime_added)
VALUES
    (1, 1, '2024-04-10 10:00:00+00'),  -- Tech Conference in Tech Events
    (2, 2, '2024-04-11 10:00:00+00'),  -- Music Festival in Music & Art
    (3, 2, '2024-04-12 10:00:00+00'),  -- Art Exhibition in Music & Art
    (4, 3, '2024-04-13 10:00:00+00'),  -- Book Fair in Book & Science
    (5, 4, '2024-04-14 10:00:00+00'),  -- Food Festival in Food & Drinks
    (6, 3, '2024-04-15 10:00:00+00'),  -- Science Expo in Book & Science
    (7, 5, '2024-04-16 10:00:00+00'),  -- Gaming Convention in Gaming & Film
    (8, 5, '2024-04-17 10:00:00+00'),  -- Film Festival in Gaming & Film
    (9, 2, '2024-04-18 10:00:00+00'),  -- Dance Competition in Music & Art
    (10, 4, '2024-04-19 10:00:00+00');  -- Fashion Show in Food & Drinks

-- Insert Keeneds (relationships between users and events they are keen for)
INSERT INTO "Keened" (user_email, event_id)
VALUES
    ('bob@example.com', 1),  -- Bob is keen for Tech Conference
    ('dave@example.com', 2),  -- Dave is keen for Music Festival
    ('alice@example.com', 3),  -- Alice is keen for Art Exhibition
    ('eve@example.com', 4),  -- Eve is keen for Book Fair
    ('frank@example.com', 5),  -- Frank is keen for Food Festival
    ('grace@example.com', 6),  -- Grace is keen for Science Expo
    ('hannah@example.com', 7),  -- Hannah is keen for Gaming Convention
    ('ian@example.com', 8),  -- Ian is keen for Film Festival
    ('julia@example.com', 9),  -- Julia is keen for Dance Competition
    ('alice@example.com', 10);  -- Alice is keen for Fashion Show

