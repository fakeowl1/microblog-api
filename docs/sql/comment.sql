-- Create Comment table
CREATE TABLE IF NOT EXISTS Comment (
    id SERIAL PRIMARY KEY,
    creator_id INTEGER references Member (id),
    post_id INTEGER references Post (id),
    text VARCHAR(512),
    media_url VARCHAR(128),
    views INTEGER CHECK (views >= 0) DEFAULT 0,
    likes INTEGER CHECK (likes >= 0) DEFAULT 0,
    dislikes INTEGER CHECK (dislikes >= 0) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add a comment to a post
INSERT INTO Comment (creator_id, post_id, text)
VALUES (1, 1, 'Цікавий пост! Дякую за інформацію');

-- Edit a comment
UPDATE Comment
SET text = 'Дуже цікавий пост! Дякую за інформацію'
WHERE id = 1;

-- Like a comment
UPDATE Comment
SET likes = likes + 1
WHERE id = 1;

-- Dislike comment
UPDATE Comment
SET dislikes = dislikes + 1
WHERE id = 1;

-- View comments for a post
SELECT
    m.username AS author,
    c.text,
    c.likes, c.dislikes, c.views,
    c.created_at
FROM Comment c 
JOIN Member m ON c.creator_id = m.id
WHERE c.post_id = 1;

-- Delete a comment
DELETE FROM Comment WHERE id = 1;
