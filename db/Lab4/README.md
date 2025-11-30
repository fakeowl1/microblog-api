# OALTP запити

## 1. Порахувати кількість користувачів соціальної мережі

```sql
SELECT COUNT(*) AS number_of_members FROM Member;
```

Використовуємо функцію аггрегації COUNT для підрахунку кількості користувачів у соціальній мережі.

## 2. Порахувати середню кількість лайків під постом для користувача 

```sql
SELECT ROUND(AVG(p.likes)) as avg_likes
FROM Post
WHERE creator_id = 1;
``` 

## 3. Порахувати кількість постів надісланих кожним користувачем

```sql
SELECT m.id, m.username, COUNT(p.id) as number_of_posts
FROM Member m
LEFT JOIN Post p ON p.creator_id = m.id
GROUP BY m.id
ORDER BY m.id ASC;
```

## 4. Порахувати кількість постів у яких кількість тегів більше чим 0

```sql
SELECT COUNT(DISTINC p.id) as number_of_posts
FROM Post p
INNER JOIN Tag t ON t.post_id = p.id;
```

## 5. Порахувати кількість постів у кожній спільноті

```sql
SELECT c.name AS community_name, COUNT(cp.post_id) AS posts_count
FROM CommunityPost cp
INNER JOIN Community c ON cp.community_id = c.id
GROUP BY c.name;
```

## 6. Показати всі спільноти та всіх їхніх підписників

```sql
SELECT c.name AS community, m.username AS subscriber
FROM Community c
FULL JOIN CommunitySubscription cs ON cs.community_id = c.id
FULL JOIN Member m ON m.id = cs.user_id;
```

## 7. Вивести список постів, навіть якщо постів немає

```sql
SELECT m.username, p.id AS post_id, p.title
FROM Post p
RIGHT JOIN Member m ON p.creator_id = m.id
ORDER BY m.username;
```