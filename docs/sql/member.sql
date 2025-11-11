-- Create a Member table
CREATE TYPE USER_STATUS AS ENUM('online', 'offline');

CREATE TABLE IF NOT EXISTS Member (
    id SERIAL PRIMARY KEY,
    username VARCHAR(32) NOT NULL UNIQUE,
    password_hash VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    status USER_STATUS DEFAULT 'online',
    bio VARCHAR(256),
    avatar_url VARCHAR(256),
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a Friendship table
CREATE TYPE FRIENDSHIP_STATUS AS ENUM ('pending', 'accepted', 'rejected');

CREATE TABLE IF NOT EXISTS Friendship (
    user_id INTEGER references Member (id),
    friended_id INTEGER references Member (id),
    status FRIENDSHIP_STATUS NOT NULL,
    PRIMARY KEY (user_id, friended_id)
);

-- Get all users
SELECT * FROM Member;

-- User registration
INSERT INTO Member (username, password_hash, email, bio)
VALUES ('Mr.X', 'd45a4510d9cd468676470a27488471e581c5e427ad734faf04c0509669a790e4', 'x@gmail.com', 'Hello, my name is X');

-- User authentication
SELECT EXISTS(SELECT 1 FROM Member WHERE password_hash = 'd45a4510d9cd468676470a27488471e581c5e427ad734faf04c0509669a790e4' AND id = 1);

-- Get information about the user
SELECT * FROM Member WHERE username = 'Mr.X';

-- Update User bio
UPDATE Member SET bio = 'New bio for user' WHERE id = 1;

-- Update User status
UPDATE Member SET status = 'offline' WHERE id = 1;

-- Send friendship request
INSERT INTO Friendship (user_id, friended_id, status)
VALUES (1, 2, 'pending');

-- Verify request sent
SELECT
    sender.username AS "from",
    receiver.username AS "to",
    f.status
FROM Friendship AS f
JOIN Member AS sender ON f.user_id = sender.id
JOIN Member AS receiver ON f.friended_id = receiver.id
WHERE f.user_id = 1 AND f.friended_id = 2;

-- Accept friendship request
UPDATE Friendship SET status = 'accepted' WHERE user_id = 2 AND friended_id = 1;

-- Verify accepted
SELECT
    sender.username AS "from",
    receiver.username AS "to",
    f.status
    FROM Friendship AS f
JOIN Member AS sender  ON f.user_id = sender.id
JOIN Member AS receiver ON f.friended_id = receiver.id
WHERE (f.user_id = 1 AND f.friended_id = 2)
   OR (f.user_id = 2 AND f.friended_id = 1);

-- Reject friendship request
UPDATE Friendship SET status = 'rejected' WHERE user_id = 2 AND friended_id = 1;

-- Verify rejected
SELECT status FROM Friendship
WHERE user_id = 2 AND friended_id = 1;

-- View pending incoming requests
SELECT m.username FROM Friendship f
JOIN Member m ON f.user_id = m.id
WHERE f.friended_id = 1 AND f.status = 'pending';

-- View accepted friends
SELECT m.username, m.status FROM Friendship f
JOIN Member m ON f.friended_id = m.id
WHERE f.user_id = 1 AND f.status = 'accepted';

-- Remove friend
DELETE FROM Friendship
WHERE (user_id = 1 AND friended_id = 2) OR (user_id = 2 AND friended_id = 1);

-- Verify removal
SELECT COUNT(*) AS remaining
FROM Friendship
WHERE (user_id = 1 AND friended_id = 2)
   OR (user_id = 2 AND friended_id = 1);

-- Delete user
DELETE FROM Member WHERE id = 1;