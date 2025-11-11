-- Create Post table
CREATE TABLE IF NOT EXISTS Post (
    id SERIAL PRIMARY KEY,
    creator_id INT REFERENCES Member (id),
    title VARCHAR(64),
    text VARCHAR(1024),
    likes INT DEFAULT 0 CHECK (likes >= 0),
    dislikes INT DEFAULT 0 CHECK (dislikes >= 0),
    views INT DEFAULT 0 CHECK (views >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User creates post
INSERT INTO Post(creator_id, title, text)
VALUES (1, 'Google make Android delevelopment private', 'Google is planning a major change to the way it develops new versions of the Android operating system. Since the beginning, large swaths of the software have been developed in public-facing channels, but that will no longer be the case. This does not mean Android is shedding its open source roots, but the process won’t be as transparent.

Google has confirmed to Android Authority that all Android development work going forward will take place in Google’s internal branch. This is a shift from the way Google has worked on Android in the past, which featured frequent updates to the public AOSP branch. Anyone can access AOSP, but the internal branches are only available to Google and companies with a Google Mobile Services (GMS) license, like Samsung, Motorola, and others.');

-- User edit post
UPDATE Post SET title = 'New title', text = 'New text' WHERE id = 1;

-- User views post
SELECT 
  p.id as post_id,
  m.username as creator, 
  title, text, 
  likes, dislikes, views, 
  created_at
FROM Post p 
JOIN Member m ON m.id = p.creator_id 
WHERE p.id = 1;

-- User deletes a post
DELETE FROM Post WHERE id = 1;

-- User likes a post
UPDATE Post SET likes = likes + 1 WHERE id = 1; 

-- User dislikes a post
UPDATE Post SET dislikes = dislikes + 1 WHERE id = 1; 

-- User opens post
UPDATE Post SET views = views + 1 WHERE id = 1;

-- Create table for tag
CREATE TABLE IF NOT EXISTS Tag (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Post (id) ON DELETE CASCADE,
    name VARCHAR(32)
);

-- User adds tag
INSERT INTO Tag(post_id, name)
VALUES (1, 'Evil Corp');

-- User deletes tag
DELETE FROM Tag WHERE id = 1;

-- User views tags for post
SELECT * FROM Tag WHERE post_id = 1;

-- Create a PostMedia table
CREATE TABLE IF NOT EXISTS PostMedia (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Post (id),
    media_url VARCHAR(128)
);

-- Add media to post
INSERT INTO PostMedia (post_id, media_url)
VALUES (1, 'https://example.com/media/first_post.jpg');

-- Get media for a post
SELECT id, media_url FROM PostMedia WHERE post_id = 1;

-- Remove media from post
DELETE FROM PostMedia WHERE id = 1;

-- Update media URL
UPDATE PostMedia SET media_url = 'https://example.com/media/updated_post.jpg' WHERE id = 1;
