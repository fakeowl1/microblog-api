-- Create PrivateMessage table
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