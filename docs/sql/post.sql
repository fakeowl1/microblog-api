-- Create Post table
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

-- User creates the post
INSERT INTO Post(creator_id, title, text)
VALUES (1, 'Google make Android delevelopment private', 'Google is planning a major change to the way it develops new versions of the Android operating system. Since the beginning, large swaths of the software have been developed in public-facing channels, but that will no longer be the case. This does not mean Android is shedding its open source roots, but the process won’t be as transparent.

Google has confirmed to Android Authority that all Android development work going forward will take place in Google’s internal branch. This is a shift from the way Google has worked on Android in the past, which featured frequent updates to the public AOSP branch. Anyone can access AOSP, but the internal branches are only available to Google and companies with a Google Mobile Services (GMS) license, like Samsung, Motorola, and others.');

-- User delete the post
DELETE FROM Post WHERE id = 1;

-- User edit the post
