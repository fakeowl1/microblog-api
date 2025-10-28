INSERT INTO Member (username, password_hash, email, status, bio, avatar_url, join_date)
VALUES ('Phoenix', '345587b2c6a6e9bf4c399fffaf007aca06fc3f02775d06e552db9d7cd5fe6225', 'phoenix@example.com', 'offline', 'student of KPI', 'https://c331bff0b.jpg', '2025-05-11'),
('Bettie', '5335f44e899c9179626fad9e11e5c42ea245e680a644787ded59efa3', 'bettie@example.com', 'online', 'Цікавлюсь наукою', 'https://c335956883.jpg', '2025-03-10'),
('Joker', '55fb7ff091de8790195132ccf08cc90eab52bfab3c9d85c17583800011a33c55', 'joker@example.com', 'online', 'Adventurer, explorer, daydreamer', 'https://d33595683.jpg', '2025-10-10');

INSERT INTO Post (creator_id, title, text, likes, dislikes, views, created_at)
VALUES 
(1, 'Мій перший пост', 'Всім привіт! Нарешті створив свій перший мікроблог.', 12, 1, 140, '2025-05-12'),
(2, 'День з життя студента', 'Для когось мрія. А для когось реальність ...', 25, 0, 320, '2025-05-14'),
(3, 'Краса навколо нас', 'Всі бігом в Ботсад! Мабуть єдиний сонячний день', 75, 0, 110, '2025-09-15');

INSERT INTO Community (name, bio, avatar_url, created_at)
VALUES
('microbloggers', 'Спільнота людей, які діляться думками кожного дня.', 'https://example.com.png', '2025-03-01'),
('smm_learners', 'Для тих, хто вивчає SMM та хоче просувати бренди.', 'https://example.com.jpg', '2025-03-15');

INSERT INTO Tag (post_id, name)
VALUES
(1, 'вступ'),
(2, 'студентське_життя'),
(3, 'тиша');

INSERT INTO PostMedia (post_id, media_url)
VALUES
(1, 'https://example.com/media/first_post.jpg'),
(2, 'https://example.com/media/student_day.png'),
(3, 'https://example.com/media/botanic_garden.jpg');

INSERT INTO PrivateMessage (sender_id, receiver_id, text, status, media_url, created_at)
VALUES
(1, 2, 'Мені здається, ми спеціальності', 'readed', NULL, '2025-05-12'),
(1, 2, 'сплутали', 'readed', NULL, '2025-05-12'),
(2, 3, 'треба було йти на філософію', 'unreaded', NULL, '2025-05-13');

INSERT INTO Comment (creator_id, post_id, text, views, likes, dislikes, created_at)
VALUES
(2, 1, 'Яка краса! Бувала там, дійсно чарівна місцина', 10, 4, 0, '2025-05-12'),
(3, 1, 'Боже як це гарно',3, 3, 0, '2025-05-13'),
(1, 2, 'Вау, яка ж краса...', 8, 6, 0, '2025-05-14');

INSERT INTO Friendship (user_id, friended_id, status)
VALUES
(1, 2, 'accepted'),
(2, 3, 'pending'),
(3, 1, 'accepted');

INSERT INTO CommunitySubscription (community_id, user_id)
VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);
