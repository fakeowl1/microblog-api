CREATE TABLE IF NOT EXISTS Community (
    id SERIAL PRIMARY KEY,
    name VARCHAR(32) UNIQUE,
    bio VARCHAR(512),
    avatar_url VARCHAR(128),
    created_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Tag (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Post (id),
    name VARCHAR(32)
);

CREATE TABLE IF NOT EXISTS PostMedia (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Post (id),
    media_url VARCHAR(128)
);

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

CREATE TYPE MESSAGE_STATUS AS ENUM('readed', 'unreaded');

CREATE TABLE IF NOT EXISTS PrivateMessage (
    id SERIAL PRIMARY KEY,
    sender_id INTEGER references Member (id),
    receiver_id INTEGER references Member (id),
    text VARCHAR(512),
    status MESSAGE_STATUS NOT NULL,
    media_url VARCHAR(128),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TYPE FRIENDSHIP_STATUS AS ENUM('pending', 'accepted', 'rejected');

CREATE TABLE IF NOT EXISTS Friendship (
    user_id INTEGER references Member (id),
    friended_id INTEGER references Member (id),
    status FRIENDSHIP_STATUS NOT NULL,
    PRIMARY KEY (user_id, friended_id)
);

CREATE TABLE IF NOT EXISTS CommunitySubscription (
    id SERIAL PRIMARY KEY,
    community_id INT REFERENCES Community (id),
    user_id INT REFERENCES Member (id)
);
