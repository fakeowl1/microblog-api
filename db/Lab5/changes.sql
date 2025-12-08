-- NF3 & add ON DELETE CASCADE
ALTER TABLE Tag DROP COLUMN post_id;

CREATE TABLE IF NOT EXISTS PostTag (
    tag_id INT REFERENCES Tag (id) ON DELETE CASCADE,
    post_id INT REFERENCES Post (id) ON DELETE CASCADE,
    PRIMARY KEY (tag_id, post_id)
);

-- Delete unnecessary PK

ALTER TABLE CommunitySubscription
    DROP CONSTRAINT communitysubscription_pkey,
    DROP COLUMN id,
    ADD PRIMARY KEY (community_id, user_id);

ALTER TABLE CommunityPost
    DROP CONSTRAINT communitypost_pkey,
    DROP COLUMN id,
    ADD PRIMARY KEY (community_id, post_id);
