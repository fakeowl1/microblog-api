INSERT INTO Member (username, password_hash, email, status, bio, avatar_url, join_date)
VALUES ('Phoenix', '345587b2c6a6e9bf4c399fffaf007aca06fc3f02775d06e552db9d7cd5fe6225', 'phoenix@example.com', 'offline', 'student of KPI', 'https://c331bff0b.jpg', '2025-05-11'),
('Bettie', '5335f44e899c9179626fad9e11e5c42ea245e680a644787ded59efa3', 'bettie@example.com', 'online', 'Цікавлюсь наукою', 'https://c335956883.jpg', '2025-03-10'),
('Joker', '55fb7ff091de8790195132ccf08cc90eab52bfab3c9d85c17583800011a33c55', 'joker@example.com', 'online', 'Adventurer, explorer, daydreamer', 'https://d33595683.jpg', '2025-10-10');

INSERT INTO Post (creator_id, title, text, likes, dislikes, views)
VALUES 
(1, 'Мій перший пост', 'Всім привіт! Нарешті створив свій перший мікроблог.', 12, 1, 140),
(2, 'SMM стратегії для початківців', 'Ділюсь досвідом створення першої SMM кампанії', 67, 3, 450),
(3, 'Мій перший внесок у Open Source', 'Як я почав робити свій перший внесок у відкритий код', 120, 2, 680);

INSERT INTO Community (name, bio, avatar_url)
VALUES
('microbloggers', 'Спільнота людей, які діляться думками кожного дня.', 'https://example.com/avatar2.png'),
('smm_learners', 'Для тих, хто вивчає SMM та хоче просувати бренди.', 'https://example.com/avatar1.jpg'),
('opensource', 'спільна ентузіастів вільного програмного забезпечення', 'https://example.com/avatar3.jpg');

INSERT INTO CommunityPost (community_id, post_id)
VALUES 
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Tag (post_id, name)
VALUES
(1, 'знайомство'),
(2, 'бренди'),
(3, 'досвід');

INSERT INTO PostMedia (post_id, media_url)
VALUES
(1, 'https://example.com/media/bla.jpg'),
(2, 'https://example.com/media/blabla.png'),
(3, 'https://example.com/media/blabla2.jpg');

INSERT INTO PrivateMessage (sender_id, receiver_id, text, status, media_url)
VALUES
(1, 2, 'Мені здається, ми спеціальності', 'readed', NULL),
(1, 2, 'сплутали', 'readed', NULL),
(2, 3, 'треба було йти на філософію', 'unreaded', NULL);

INSERT INTO Comment (creator_id, post_id, text, views, likes, dislikes)
VALUES
(2, 1, 'Классно!', 10, 4, 0),
(3, 2, 'Дуже інформативно, дякую!', 3, 3, 0),
(1, 3, 'Вау, вітаю', 8, 6, 0);

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
(3, 1),
(3, 2);
