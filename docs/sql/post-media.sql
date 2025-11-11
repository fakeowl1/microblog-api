-- Create a PostMedia table
CREATE TABLE IF NOT EXISTS PostMedia (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Post (id),
    media_url VARCHAR(128)
);

-- Get media for a post
SELECT id, media_url FROM PostMedia WHERE post_id = 1;

-- Add media to post
INSERT INTO PostMedia (post_id, media_url)
VALUES (1, 'https://example.com/media/first_post.jpg');

-- Remove media from post
DELETE FROM PostMedia WHERE id = 1;

-- Update media URL
UPDATE PostMedia SET media_url = 'https://example.com/media/updated_post.jpg' WHERE id = 1;