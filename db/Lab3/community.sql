-- Create Community table
CREATE TABLE IF NOT EXISTS Community (
    id SERIAL PRIMARY KEY,
    name VARCHAR(32) UNIQUE,
    bio VARCHAR(512),
    avatar_url VARCHAR(128),
    created_at TIMESTAMP DEFAULT current_timestamp
);

-- Create a new community
INSERT INTO Community (name, bio)
VALUES ('Raspberry Pi', 'The Raspberry Pi community');

-- Create a table for community posts
CREATE TABLE IF NOT EXISTS CommunityPost (
  id SERIAL PRIMARY KEY,
  community_id INT REFERENCES Community (id) ON DELETE CASCADE,
  post_id INT REFERENCES Post (id)
);

-- User creates a post in a community
INSERT INTO Post(creator_id, title, text) 
VALUES (1, 'Getting start with Raspberry', 'SOME TEXT');

INSERT INTO CommunityPost(community_id, post_id)
VALUES (1, 1);

-- View a post for community
SELECT 
  p.id as post_id,
  c.name as community_name,
  p.title, p.text
FROM CommunityPost cp
JOIN Post p ON p.id = cp.post_id
JOIN Community c ON c.id = cp.community_id
WHERE cp.community_id = 1;

-- Update information about community
UPDATE Community SET name = 'Orange Pi', bio = 'The Orange Pi community' WHERE id = 1;

-- Create table for CommunitySubscriptions
CREATE TABLE IF NOT EXISTS CommunitySubscription (
    id SERIAL PRIMARY KEY,
    community_id INT REFERENCES Community (id) ON DELETE CASCADE,
    user_id INT REFERENCES Member (id) ON DELETE CASCADE
);

-- User subscribes to the community
INSERT INTO CommunitySubscription(community_id, user_id)
VALUES (1, 1);

-- User unsubscribes from the community
DELETE FROM CommunitySubscription WHERE user_id = 1 AND community_id = 1;

-- View user subscriptions
SELECT 
  m.username as user,
  c.name as community
FROM CommunitySubscription cs
JOIN Member m ON m.id = cs.user_id
JOIN Community c ON c.id = cs.community_id
WHERE cs.user_id = 1;

-- Delete a community
DELETE FROM Community WHERE id = 1;
