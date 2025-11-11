-- Create PrivateMessage table
CREATE TYPE MESSAGE_STATUS AS ENUM('readed', 'unreaded');

CREATE TABLE IF NOT EXISTS PrivateMessage (
    id SERIAL PRIMARY KEY,
    sender_id INTEGER REFERENCES Member (id),
    receiver_id INTEGER REFERENCES Member (id),
    text VARCHAR(512),
    status MESSAGE_STATUS NOT NULL,
    media_url VARCHAR(128),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

-- User sends a private message
INSERT INTO PrivateMessage (sender_id, receiver_id, text, status)
VALUES (1, 2, 'Привіт! Як справи?', 'unreaded');

-- User edits message
UPDATE PrivateMessage SET text = 'Привіт! Як твої справи?' WHERE id = 1;

-- User mark a message as read
UPDATE PrivateMessage SET status = 'readed'
WHERE id = 1 AND receiver_id = 2;

-- User view messages from a user
SELECT 
    pm.id,
    sender.username AS from_user,
    pm.text,
    pm.status,
    pm.media_url,
    pm.created_at
FROM PrivateMessage AS pm
JOIN Member sender ON pm.sender_id = sender.id
WHERE pm.receiver_id = 2
ORDER BY pm.created_at DESC;

-- User deletes a message
DELETE FROM PrivateMessage WHERE id = 1;
