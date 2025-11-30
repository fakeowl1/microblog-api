SELECT COUNT(*) AS number_of_members FROM Member;


SELECT ROUND(AVG(p.likes)) as avg_likes
FROM Post p
WHERE creator_id = 1;


SELECT m.id, m.username, COUNT(p.id) as number_of_posts
FROM Member m
LEFT JOIN Post p ON p.creator_id = m.id
GROUP BY m.id
ORDER BY m.id ASC;


SELECT COUNT(DISTINCT p.id) as number_of_posts
FROM Post p
INNER JOIN Tag t ON t.post_id = p.id;


SELECT c.name AS community_name, COUNT(cp.post_id) AS posts_count
FROM CommunityPost cp
INNER JOIN Community c ON cp.community_id = c.id
GROUP BY c.name;


SELECT c.name AS community, m.username AS subscriber
FROM Community c
INNER JOIN CommunitySubscription cs ON cs.community_id = c.id
INNER JOIN Member m ON m.id = cs.user_id
ORDER BY c.name;


SELECT m.username, p.id AS post_id, p.title
FROM Post p
RIGHT JOIN Member m ON p.creator_id = m.id
ORDER BY m.username;


SELECT m.username,
(SELECT COUNT(*)
FROM Friendship f
WHERE (f.user_id = m.id OR f.friended_id = m.id)
AND f.status = 'accepted') AS friends_count
FROM Member m
ORDER BY friends_count DESC;


SELECT username
FROM Member
WHERE id IN 
(SELECT creator_id 
FROM Comment
WHERE LENGTH(text) > 100);


SELECT m.username, ROUND(AVG(p.likes), 1) AS avg_likes
FROM Member m
JOIN Post p ON p.creator_id = m.id
GROUP BY m.username
HAVING AVG(p.likes) > 10;
