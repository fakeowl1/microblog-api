-- Create a PostMedia table
CREATE TABLE IF NOT EXISTS PostMedia (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Post (id),
    media_url VARCHAR(128)
);
