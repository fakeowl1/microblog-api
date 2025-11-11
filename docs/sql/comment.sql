-- Create Comment table
CREATE TABLE IF NOT EXISTS Comment (
    id SERIAL PRIMARY KEY,
    creator_id INTEGER references Member (id),
    post_id INTEGER references Post (id),
    text VARCHAR(512),
    media_url VARCHAR(128),
    views INTEGER CHECK (views >= 0),
    likes INTEGER CHECK (likes >= 0),
    dislikes INTEGER CHECK (dislikes >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add a comment to a post
INSERT INTO Comment (creator_id, post_id, text)
VALUES (1, 1, 'Цікавий пост! Дякую за інформацію');

-- Verify added comment
SELECT id, creator_id, text, likes, dislikes, views FROM Comment
WHERE post_id = 1 AND creator_id = 1;

-- Edit a comment
UPDATE Comment
SET text = 'Дуже цікавий пост! Дякую за інформацію'
WHERE id = 1;

-- Verify edited comment
SELECT text FROM Comment WHERE id = 1;

-- Like a comment
UPDATE Comment
SET likes = likes + 1
WHERE id = 1;

-- Verify liked
SELECT likes FROM Comment WHERE id = 1;

-- Dislike comment
UPDATE Comment
SET dislikes = dislikes + 1
WHERE id = 1;

-- Verify disliked
SELECT dislikes FROM Comment WHERE id = 1;

-- View comments for a post
SELECT
    c.id,
    m.username AS author,
    c.text,
    c.likes,
    c.dislikes,
    c.views,
    c.created_at
FROM Comment c JOIN Member m ON c.creator_id = m.id
WHERE c.post_id = 1
ORDER BY c.created_at DESC;

-- Delete a comment
DELETE FROM Comment WHERE id = 1;

-- Verify deleted
SELECT COUNT(*) AS remaining_comments
FROM Comment
WHERE post_id = 1;