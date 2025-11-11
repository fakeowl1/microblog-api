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
| bio           | VARCHAR(256)          | ≤ 256 символів                       |
| avatar_url    | VARCHAR(256)          | ≤ 256 символів                       |
| join_date     | TIMESTAMP             |                                      |


### 2. Friendship
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


### 3. Post
- Створення
- Видалення
- Редагування
- Перегляд


| Поле          | Тип                         | Обмеження            |
|---------------|-----------------------------|----------------------|
| creator_id    | INT (Foreign Key)           |                      |
| title         | VARCHAR(64)                 | ≤ 64 символів        |
| text          | VARCHAR(1024)               | ≤ 1024 символів      |
| likes         | INT CHECK (likes >= 0)      | ≥ 0                  |
| dislikes      | INT CHECK (dislikes >= 0)   | ≥ 0                  |
| views         | INT CHECK (views >= 0)      | ≥ 0                  |
| created_at    | TIMESTAMP                   |                      |


### 4. Tag
- Додання до посту
- Видалення з посту


| Поле          | Тип               | Обмеження         | 
|---------------|-------------------|-------------------|
| post_id       | INT (Foreign Key) |                   |
| name          | VARCHAR(32)       | ≤ 32 символів     |


### 5. Community
- Створення
- Видалення
- Підписка
- Редагування bio


| Поле          | Тип                                | Обмеження                            |
|---------------|------------------------------------|--------------------------------------|
| name          | UNIQUE VARCHAR(32)                 | Унікальний, ≤ 32 символів           |
| bio           | VARCHAR(512)                       | ≤ 512 символів                       |
| avatar_url    | VARCHAR(128)                       | Посилання на зображення              |
| created_at    | TIMESTAMP                          |                                      |


### 6. CommunitySubscription
- Підписатися
- Відписатися
- Переглянути підписки

| Поле          | Тип                                | Обмеження              |
|---------------|------------------------------------|------------------------|
| community_id  | INT (Foreign Key)                  |                        |
| user_id       | INT (Foreign Key)                  |                        |


### 7. CommunityPost
- Додати пост
- Видалити пост

| Поле          | Тип                                | Обмеження              |
|---------------|------------------------------------|------------------------|
| community_id  | INT (Foreign Key)                  |                        |
| post_id       | INT (Foreign Key)                  |                        |


### 8. PostMedia
- Додати медіа до посту
- Видалення
- Редагування


| Поле          | Тип                         | Обмеження            |
|---------------|-----------------------------|----------------------|
| post_id       | INT (Foreign Key)           |                      |
| media_url     | VARCHAR(128)                | ≤ 128 символів       |


### 9. PrivateMessage
- Надіслати користувачу
- Редагувати
- Переглянути
- Видалити
- Позначити як прочитане


| Поле          | Тип                    | Обмеження                    | 
|---------------|------------------------|------------------------------|
| sender_id     | INT (Foreign Key)      |                              |
| receiver_id   | INT (Foreign Key)      |                              |
| text          | VARCHAR(512)           | ≤ 512 символів               |
| status        | ENUM(readed, unreaded) | Лише 'readed' чи 'unreaded'  |
| media_url     | VARCHAR(128)           |                              |
| created_at    | TIMESTAMP              |                              |


### 10. Comment
- Додати під публікацією
- Змінити
- Видалити
- Редагувати
- Оцінити (likes/dislikes)


| Поле          | Тип                          | Обмеження              |
|---------------|------------------------------|------------------------|
| creator_id    | INT (Foreign Key)            |                        |
| post_id       | INT (Foreign Key)            |                        |
| text          | VARCHAR(512)                 | ≤ 512 символів         |
| media_url     | VARCHAR(128)                 | ≤ 128 символів         |
| views         | INT CHECK (views >= 0)       | ≥ 0                    |
| likes         | INT CHECK (likes >= 0)       | ≥ 0                    |
| dislikes      | INT CHECK (dislikes >= 0)    | ≥ 0                    |
| created_at    | TIMESTAMP                    |                        |

## Тестування

### Member 

![member/1.png](./member/1.png)
![member/2.png](./member/2.png)
![member/3.png](./member/3.png)
![member/4.png](./member/4.png)
![member/5.png](./member/5.png)
![member/6.png](./member/6.png)
![member/7.png](./member/7.png)
![member/8.png](./member/8.png)
![member/9.png](./member/9.png)
![member/10.png](./member/10.png)
![member/11.png](./member/11.png)
![member/12.png](./member/12.png)

### Post

![post/13.png](./post/13.png)
![post/14.png](./post/14.png)
![post/15.png](./post/15.png)
![post/16.png](./post/16.png)
![post/17.png](./post/17.png)
![post/18.png](./post/18.png)
![post/19.png](./post/19.png)
![post/20.png](./post/20.png)
![post/21.png](./post/21.png)
![post/22.png](./post/22.png)
![post/23.png](./post/23.png)
![post/24.png](./post/24.png)
![post/25.png](./post/25.png)
![post/26.png](./post/26.png)
![post/27.png](./post/27.png)
![post/28.png](./post/28.png)
![post/29.png](./post/29.png)
![post/30.png](./post/30.png)
![post/31.png](./post/31.png)
![post/32.png](./post/32.png)
![post/33.png](./post/33.png)
![post/34.png](./post/34.png)
![post/35.png](./post/35.png)
![post/36.png](./post/36.png)
![post/37.png](./post/37.png)
![post/40.png](./post/40.png)
![post/41.png](./post/41.png)

### Community

![community/33.png](./community/33.png)
![community/34.png](./community/34.png)
![community/35.png](./community/35.png)
![community/36.png](./community/36.png)
![community/37.png](./community/37.png)
![community/38.png](./community/38.png)
![community/39.png](./community/39.png)
![community/40.png](./community/40.png)
![community/41.png](./community/41.png)
![community/42.png](./community/42.png)
![community/43.png](./community/43.png)
![community/44.png](./community/44.png)
![community/45.png](./community/45.png)
![community/46.png](./community/46.png)
![community/47.png](./community/47.png)
![community/48.png](./community/48.png)

### PrivateMessage

![private-message/42.png](./private-message/42.png)
![private-message/43.png](./private-message/43.png)
![private-message/44.png](./private-message/44.png)
![private-message/45.png](./private-message/45.png)
![private-message/46.png](./private-message/46.png)
![private-message/47.png](./private-message/47.png)
![private-message/48.png](./private-message/48.png)

### Comment

![comment/49.png](./comment/49.png)
![comment/50.png](./comment/50.png)
![comment/51.png](./comment/51.png)
![comment/52.png](./comment/52.png)
![comment/53.png](./comment/53.png)
![comment/54.png](./comment/54.png)
![comment/55.png](./comment/55.png)
![comment/56.png](./comment/56.png)
![comment/57.png](./comment/57.png)
![comment/58.png](./comment/58.png)
![comment/59.png](./comment/59.png)
![comment/60.png](./comment/60.png)
