## Сутності

### 1. Member
- Реєстрація
- Автентифікація
- Редагування
- Видалення
- Підписатися


| Поле          | Тип                   | Обмеження                            |
|---------------|-----------------------|--------------------------------------|
| username      | UNIQUE VARCHAR(32)    | Унікальний, без спеціальних символів |
| password_hash | VARCHAR               | Хеш паролю                           |
| email         | UNIQUE VARCHAR        | Унікальний, у форматі пошти          |
| status        | ENUM(online, offline) | Лише 'online' чи 'offline'           |
| bio           | VARCHAR(128)          | Не більше 128 символів               |
| avatar_url    | VARCHAR(128)          | Посилання на зображення              |
| join_date     | TIMESTAMP             |                                      |


### 2. Post
- Створення
- Видалення
- Редагування
- Перегляд


| Поле          | Тип                         | Обмеження            |
|---------------|-----------------------------|----------------------|
| creator_id    | INT (Foreign Key)           |                      |
| title         | VARCHAR(32)                 | До 32                |
| text          | VARCHAR(1024)               |                      |
| likes         | INT CHECK (likes >= 0)      | ≥ 0                  |
| dislikes      | INT CHECK (dislikes >= 0)   | ≥ 0                  |
| views         | INT CHECK (views >= 0)      | ≥ 0                  |
| created_at    | TIMESTAMP                   |                      |


### 3. Community
- Створення
- Видалення
- Підписка
- Редагування bio


| Поле          | Тип                                | Обмеження                            |
|---------------|------------------------------------|--------------------------------------|
| name          | UNIQUE VARCHAR(32)                 | Унікальний, без спеціальних символів |
| bio           | VARCHAR(512)                       | Не більше 512 символів               |
| avatar_url    | VARCHAR(128)                       | Посилання на зображення              |
| created_at    | TIMESTAMP                          |                                      |


### 4. Tag
- Додання до посту
- Видалення з посту


| Поле          | Тип               | Обмеження         | 
|---------------|-------------------|-------------------|
| post_id       | INT (Foreign Key) |                   |
| name          | VARCHAR(32)       | До 32 символів    |


### 5. PostMedia
- Додати медіа до посту
- Видалення
- Редагування


| Поле          | Тип                         | Обмеження            |
|---------------|-----------------------------|----------------------|
| post_id       | INT (Foreign Key)           |                      |
| media_url     | VARCHAR(128)                | До 128               |


### 6. PrivateMessage
- Надіслати користувачу
- Редагувати
- Переглянути
- Видалити
- Позначити як прочитане


| Поле          | Тип                    | Обмеження                    | 
|---------------|------------------------|------------------------------|
| sender_id     | INT (Foreign Key)      |                              |
| receiver_id   | INT (Foreign Key)      |                              |
| text          | VARCHAR(512)           | До 512                       |
| status        | ENUM(readed, unreaded) | Лише 'readed' чи 'unreaded'  |
| media_url     | VARCHAR(128)           |                              |
| created_at    | TIMESTAMP              |                              |


### 7. Comment
- Додати під публікацією
- Змінити
- Видалити
- Редагувати
- Оцінити (likes/dislikes)


| Поле          | Тип                          | Обмеження              |
|---------------|------------------------------|------------------------|
| creator_id    | INT (Foreign Key)            |                        |
| post_id       | INT (Foreign Key)            |                        |
| text          | VARCHAR(512)                 | До 512 символів        |
| media_url     | VARCHAR(128)                 | До 128 символів        |
| views         | INT CHECK (views >= 0)       | ≥ 0                    |
| likes         | INT CHECK (likes >= 0)       | ≥ 0                    |
| dislikes      | INT CHECK (dislikes >= 0)    | ≥ 0                    |
| created_at    | TIMESTAMP                    |                        |


### 8. Friendship
- Надіслати запит
- Прийняти запит 
- Відхилити запит
- Видалити з друзів
- Переглядати списки друзів


| Поле          | Тип                                | Обмеження                                | 
|---------------|------------------------------------|------------------------------------------|
| user_id       | INT (Foreign Key)                  |                                          |
| friended_id   | INT (Foreign Key)                  |                                          |
| status        | ENUM(pending, accepted, rejected)  | Лише 'pending' чи 'accepted', 'rejected' |


### 9. CommunitySubscription
- Підписатися
- Відписатися
- Переглянути підписки

| Поле          | Тип                                | Обмеження              |
|---------------|------------------------------------|------------------------|
| community_id  | INT (Foreign Key)                  |                        |
| user_id       | INT (Foreign Key)                  |                        |



## DDL

```sql
CREATE TYPE USER_STATUS AS ENUM('online', 'offline');

CREATE Table IF NOT EXISTS Member (
    id SERIAL PRIMARY KEY,
    username VARCHAR(32) NOT NULL UNIQUE,
    password_hash VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    status USER_STATUS NOT NULL,
    bio VARCHAR(128),
    avatar_url VARCHAR(128),
    join_date TIMESTAMP NOT NULL
);
```

```sql
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
```

```sql
CREATE TABLE IF NOT EXISTS Community (
    id SERIAL PRIMARY KEY,
    name VARCHAR(32) UNIQUE NOT NULL,
    bio VARCHAR(512),
    avatar_url VARCHAR(128),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

```sql
CREATE TABLE IF NOT EXISTS Tag (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES Post (id),
    name VARCHAR(32)
);
```

```sql
CREATE TABLE IF NOT EXISTS PostMedia (
    id SERIAL PRIMARY KEY,
    media_url VARCHAR(128),
    post_id INT REFERENCES Post (id)
);
```

```sql
CREATE TABLE IF NOT EXISTS Comment (
    id SERIAL PRIMARY KEY,
    creator_id INTEGER references Member (id),
    post_id INTEGER references Post (id),
    text VARCHAR(512),
    media_url VARCHAR(128),
    views INTEGER CHECK (views >= 0),
    likes INTEGER CHECK (likes >= 0),
    dislikes INTEGER CHECK (dislikes >= 0),
    created_at TIMESTAMP NOT NULL
);
```

```sql
CREATE TYPE MESSAGE_STATUS AS ENUM('readed', 'unreaded');

CREATE TABLE IF NOT EXISTS PrivateMessage (
    id SERIAL PRIMARY KEY,
    sender_id INTEGER references Member (id),
    receiver_id INTEGER references Member (id),
    text VARCHAR(512),
    status MESSAGE_STATUS NOT NULL,
    media_url VARCHAR(128),
    created_at TIMESTAMP NOT NULL
);
```

```sql
CREATE TYPE FRIENDSHIP_STATUS AS ENUM('pending', 'accepted', 'rejected');

CREATE TABLE IF NOT EXISTS Friendship (
    user_id INTEGER references Member (id),
    friended_id INTEGER references Member (id),
    status FRIENDSHIP_STATUS NOT NULL,
    PRIMARY KEY (user_id, friended_id)
);
```

```sql
CREATE TABLE IF NOT EXISTS CommunitySubscription (
    id SERIAL PRIMARY KEY,
    community_id INT REFERENCES Community (id),
    user_id INT REFERENCES Member (id)
);
```


## Insert Data

```sql
INSERT INTO Member (username, password_hash, email, status, bio, avatar_url, join_date)
VALUES ('Phoenix', '345587b2c6a6e9bf4c399fffaf007aca06fc3f02775d06e552db9d7cd5fe6225', 'phoenix@example.com', 'offline', 'student of KPI', 'https://c331bff0b.jpg', '2025-05-11'),
('Bettie', '5335f44e899c9179626fad9e11e5c42ea245e680a644787ded59efa3', 'bettie@example.com', 'online', 'Цікавлюсь наукою', 'https://c335956883.jpg', '2025-03-10'),
('Joker', '55fb7ff091de8790195132ccf08cc90eab52bfab3c9d85c17583800011a33c55', 'joker@example.com', 'online', 'Adventurer, explorer, daydreamer', 'https://d33595683.jpg', '2025-10-10');
```

```sql
INSERT INTO Post (creator_id, title, text, likes, dislikes, views, created_at)
VALUES 
(1, 'Мій перший пост', 'Всім привіт! Нарешті створив свій перший мікроблог.', 12, 1, 140, '2025-05-12'),
(2, 'День з життя студента', 'Для когось мрія. А для когось реальність ...', 25, 0, 320, '2025-05-14'),
(3, 'Краса навколо нас', 'Всі бігом в Ботсад! Мабуть єдиний сонячний день', 75, 0, 110, '2025-09-15');
```

```sql
INSERT INTO Community (name, bio, avatar_url, created_at)
VALUES
('microbloggers', 'Спільнота людей, які діляться думками кожного дня.', 'https://example.com.png', '2025-03-01'),
('smm_learners', 'Для тих, хто вивчає SMM та хоче просувати бренди.', 'https://example.com.jpg', '2025-03-15');
```

```sql
INSERT INTO Tag (post_id, name)
VALUES
(1, 'вступ'),
(2, 'студентське_життя'),
(3, 'тиша'),
(4, 'nature');
```

```sql
INSERT INTO PostMedia (post_id, media_url)
VALUES
(1, 'https://example.com/media/first_post.jpg'),
(2, 'https://example.com/media/student_day.png'),
(3, 'https://example.com/media/botanic_garden.jpg');
```

```sql
INSERT INTO PrivateMessage (sender_id, receiver_id, text, status, media_url, created_at)
VALUES
(1, 2, 'Мені здається, ми спеціальності', 'readed', NULL, '2025-05-12'),
(1, 2, 'сплутали', 'readed', NULL, '2025-05-12'),
(2, 3, 'треба було йти на філософію', 'unreaded', NULL, '2025-05-13');
```

```sql
INSERT INTO Comment (creator_id, post_id, text, media_url, views, likes, dislikes, created_at)
VALUES
(2, 1, 'Яка краса! Бувала там, дійсно чарівна місцина', 10, 4, 0, '2025-05-12'),
(3, 1, 'Боже як це гарно',3, 3, 0, '2025-05-13'),
(1, 2, 'Вау, яка ж краса...', 8, 6, 0, '2025-05-14');
```

```sql
INSERT INTO Friendship (user_id, friended_id, status)
VALUES
(1, 2, 'accepted'),
(2, 3, 'pending'),
(3, 1, 'accepted');
```

```sql
INSERT INTO CommunitySubscription (community_id, user_id)
VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);
```
