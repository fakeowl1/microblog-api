CREATE TYPE USER_STATUS AS ENUM('online', 'offline');

CREATE Table IF NOT EXISTS Member (
    id SERIAL PRIMARY KEY,
    username VARCHAR(32) NOT NULL UNIQUE,
    password_hash VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    status USER_STATUS NOT NULL,
    bio VARCHAR(128),
    avatar_url VARCHAR(128),
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Post (
    id SERIAL PRIMARY KEY,
    creator_id INT REFERENCES Member (id),
    title VARCHAR(32),
    text VARCHAR(1024),
    likes INT DEFAULT 0 CHECK (likes >= 0),
    dislikes INT DEFAULT 0 CHECK (dislikes >= 0),
    views INT DEFAULT 0 CHECK (views >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Tag (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Post (id),
    name VARCHAR(32)
);

CREATE TABLE IF NOT EXISTS PostMedia (
    id SERIAL PRIMARY KEY,
    media_url VARCHAR(128),
    post_id INT REFERENCES Post (id)
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
