# Work In Progress

## Сутності

### 1. User
- Реєстрація
- Аунтефікація
- Редагування
- Видалення
- Підписатися


| Поле          | Тип                   | Обмеження                            |
|---------------|-----------------------|--------------------------------------|
| username      | UNIQUE VARCHAR(15)    | Унікальний, без спеціальних символів |
| password_hash | VARCHAR               | Хеш паролю                           |
| email         | VARCHAR               | Унікальний, у форматі пошти          |
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
| title         | VARCHAR(64)                 | До 64                |
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
| name          | UNIQUE VARCHAR(15)                 | Унікальний, без спеціальних символів |
| bio           | VARCHAR(256)                       | Не більше 256 символів               |
| avatar_url    | VARCHAR(128)                       | Посилання на зображення              |
| created_at    | DATETIME                           |                                      |


### 4. Tag
- Додати до посту

| Поле          | Тип               | Обмеження             | 
|---------------|-------------------|-----------------------|
| post_id       | INT (Foreign Key) |                       |
| name          | VARCHAR(32)       | Не більше 32 символів |


### 5. PrivateMessage
- Надіслати користовачу
- Редагувати
- Видалити


| Поле          | Тип                    | Обмеження                    | 
|---------------|------------------------|------------------------------|
| sender_id     | INT (Foreign Key)      |                              |
| receiver_id   | INT (Foreign Key)      |                              |
| text          | VARCHAR(256)           | Не більше 256 символів       |
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
| text          | VARCHAR(512)                 | Не більше 512 символів |
| media_url     | VARCHAR(128)                 | Посилання 128 символів |
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
| followed_id   | INT (Foreign Key)                  |                                          |
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

| Поле          | Тип                                | Обмеження              |
|---------------|------------------------------------|------------------------|
| media_url     | VARCHAR(128)                       | Посилання 128 символів |
| post_id       | INT (Foreign Key)                  |                        |



## ER-діаграма
<p align="center">
    <img src='diagrams/diagram.jpg'/>
</p>
