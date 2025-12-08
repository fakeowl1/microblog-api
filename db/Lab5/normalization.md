# Ненормалізована форма

![ER діаграма](./unnormalized-diagram.jpg)

# Функціональні залежності

## Member

```
id -> username
id -> password_hash
id -> email
id -> status
id -> bio
id -> avatar_url
id -> join_date
```

## Friendship

```
(user_id, firended_id) -> status
```

## Post 

```
id -> title
id -> text
id -> likes
id -> dislikes
id -> views
id -> created_at
```

## Tag 

```
id -> name 
id -> post_id
```

## Community 

```
id -> name
id -> bio
id -> avatar_url
id -> created_at
```

## CommunitySubscription

```
id -> community_id
id -> user_id
```

## CommunityPost 

```
id -> community_id
id -> post_id
```

## Comment

```
id -> creator_id
id -> post_id
id -> text
id -> media_url
id -> views
id -> likes 
id -> dislikes
id -> created_at
```
