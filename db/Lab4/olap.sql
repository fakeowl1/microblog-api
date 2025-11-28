SELECT COUNT(*) AS number_of_members FROM Member;


SELECT ROUND(AVG(p.likes)) as avg_likes
FROM Post
WHERE creator_id = 1;


SELECT m.id, m.username, COUNT(p.id) as number_of_posts
FROM Member m
LEFT JOIN Post p ON p.creator_id = m.id
GROUP BY m.id
ORDER BY m.id ASC;


SELECT COUNT(DISTINC p.id) as number_of_posts
FROM Post p
INNER JOIN Tag t ON t.post_id = p.id;


