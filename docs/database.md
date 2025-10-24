## Сутності

### 1. User
- Реєстрація
- Аунтефікація
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
| join_date     | DATETIME              |                                      |


### 2. Post
- Створення
- Видалення
- Редагування


| Поле          | Тип                         | Обмеження            |
|---------------|-----------------------------|----------------------|
| creator_id    | INT (Foreign Key)           |                      |
| title         | VARCHAR(32)                 | До 32                |
| text          | VARCHAR(1024)               |                      |
| likes         | INT CHECK (likes >= 0)      | ≥ 0                  |
| dislikes      | INT CHECK (dislikes >= 0)   | ≥ 0                  |
| views         | INT CHECK (views >= 0)      | ≥ 0                  |
| created_at    | DATETIME                    |                      |


### 3. Community
- Підписатися
- Редагувати bio

| Поле          | Тип                                | Обмеження                            |
|---------------|------------------------------------|--------------------------------------|
| name          | UNIQUE VARCHAR(32)                 | Унікальний, без спеціальних символів |
| bio           | VARCHAR(256)                       | Не більше 256 символів               |
| avatar_url    | VARCHAR(128)                       | Посилання на зображення              |
| created_at    | DATETIME                           |                                      |


### 4. Tag
- Додати до посту

| Поле          | Тип               | Обмеження         | 
|---------------|-------------------|-------------------|
| post_id       | INT (Foreign Key) |                   |
| name          | VARCHAR(32)       | До 32 символів    |


### 5. PrivateMessage
- Надіслати користовачу
- Редагувати
- Видалити


| Поле          | Тип                    | Обмеження                    | 
|---------------|------------------------|------------------------------|
| sender_id     | INT (Foreign Key)      |                              |
| receiver_id   | INT (Foreign Key)      |                              |
| text          | VARCHAR(256)           | До 256                       |
| status        | ENUM(readed, unreaded) | Лише 'readed' чи 'unreaded'  |
| media_url     | VARCHAR(128)           |                              |
| created_at    | DATETIME               |                              |


### 4. Comment
- Додати під публікацією
- Змінити
- Видалити

| Поле          | Тип                          | Обмеження              |
|---------------|------------------------------|------------------------|
| creator_id    | INT (Foreign Key)            |                        |
| text          | VARCHAR(512)                 | До 512 символів        |
| media_url     | VARCHAR(128)                 | До 128 символів        |
| views         | INT CHECK (views >= 0)       | ≥ 0                    |
| likes         | INT CHECK (likes >= 0)       | ≥ 0                    |
| dislikes      | INT CHECK (dislikes >= 0)    | ≥ 0                    |
| created_at    | DATETIME                     |                        |


### 5. Friendship
- Надіслати запит
- Прийняти запит 
- Відхилити запит

| Поле          | Тип                                | Обмеження                                | 
|---------------|------------------------------------|------------------------------------------|
| user_id       | INT (Foreign Key)                  |                                          |
| friended_id   | INT (Foreign Key)                  |                                          |
| status        | ENUM(pending, accepted, rejected)  | Лише 'pending' чи 'accepted', 'rejected' |


### 6. CommunitySubscription
- Підписатися
- Відписатися

| Поле          | Тип                                | Обмеження              |
|---------------|------------------------------------|------------------------|
| community_id  | INT (Foreign Key)                  |                        |
| user_id       | INT (Foreign Key)                  |                        |


### 7. PostMedia
- Додати медіа до публікації
- Видалити медіа

| Поле          | Тип                                | Обмеження           |
|---------------|------------------------------------|---------------------|
| media_url     | VARCHAR(128)                       | До 128 символів     |
| post_id       | INT (Foreign Key)                  |                     |



## ER-діаграма
<p align="center">
    <img src='diagrams/diagram.jpg'/>
</p>

## DDL (Work-In-Progress)

```sql
CREATE TYPE USER_STATUS AS ENUM('online', 'offline');

CREATE Table IF NOT EXISTS "User" (
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
CREATE TABLE IF NOT EXISTS Comment (
    id SERIAL PRIMARY KEY,
    creator_id INTEGER references "User" (id),
    post_id INTEGER references "Post" (id),
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
    sender_id INTEGER references "User" (id),
    reciever_id INTEGER references "User" (id),
    text VARCHAR(256),
    status MESSAGE_STATUS NOT NULL,
    media_url VARCHAR(128),
    created_at TIMESTAMP NOT NULL
);
```

```sql
CREATE TYPE FRIENDSHIP_STATUS AS ENUM('pending', 'accepted' 'rejected');

CREATE TABLE IF NOT EXISTS Friendship (
    user_id INTEGER references "User" (id),
    friended_id INTEGER references "User" (id),
    status FRIENDSHIP_STATUS NOT NULL,
    PRIMARY KEY (user_id, followed_id)
);
```
