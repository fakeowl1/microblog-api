-- Get all users
SELECT * FROM Member;

-- User registration
SELECT * FROM Member WHERE username = 'Mr.X';

INSERT INTO Member (username, password_hash, email, bio)
VALUES ('Mr.X', 'd45a4510d9cd468676470a27488471e581c5e427ad734faf04c0509669a790e4', "x@gmail.com", "Hello, my name is X");

-- User authentication
SELECT EXISTS(SELECT 1 FROM Member WHERE password_hash = 'd45a4510d9cd468676470a27488471e581c5e427ad734faf04c0509669a790e4' AND id = 1);

-- Update User bio
UPDATE Member SET bio='New bio for user' WHERE id = 1;

-- Update User status
UPDATE Member SET status='online' WHERE id = 1;

-- Delete user
DELETE FROM Member WHERE id = 1; 
