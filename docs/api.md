# API documentation

## Table of content

- [Authentication](#authentication)
    - [Create an access token with login and password](#create-an-access-token-with-login-and-password)
    - [Refresh a token](#refresh-a-token)

- [Users](#users)
    - [Create a user](#create-a-user)
    - [Update a user](#update-a-user)
    - [Delete a user](#delete-a-user)

- [Events](#events)
    - [Create an event](#create-an-event)
    - [Update an event](#update-an-event)
    - [Delete an event](#delete-an-event)

- [Likes](#likes)
    - [Like a content](#like-a-content)
    - [Unlike a content](#unlike-a-content)

- [Comments](#comments)
    - [Create a comment](#create-a-comment)
    - [View a comment and replies](#view-a-comment-and-replies)
    - [Delete a comment](#delete-a-comment)

## Authentication
Authentications are based on the Oauth2 Protocol in which the Rails application act as a provider.
The header of an authenticated api call must contain an authentication token.
The token expires in 4 months. This is the only request that will be in JSON and not messagepack

**Header parameter:**

**Authorization:** bearer _< token >_

### Errors
###### Token invalid
**Status:** 401

**Response:**
```
{
    "error": "The access token is invalid"
}
```

###### Token expired
**Status:** 401

**Response:**
```
{
    "error": "The access token expired"
}
```
### Create an access token with login and password
##### POST /oauth/token
###### Parameters
- **login** _(String)_: _< the login of the user >_
- **password** _(String)_: _< the password of the user>_
- **grant_type** _(String)_: "password"


###### Response
Status: 200

```
{
    "access_token": "6f3a305cc95de8db21d923f3c51e05a312f6cb822f50f2e3b9aaccdae16a49be",
    "token_type": "bearer",
    "expires_in": 7200,
    "refresh_token": "6f3a305cc95de8db21d923f3c51e05a312f6cb822f598hb74"
    "created_at": 1429709966
}
``` 

###### Errors
Status: 401

```
{
    "error": "invalid_grant",
    "error_message": "The provided authorization grant is invalid, expired, revoked, does not match the redirection URI used in the authorization request, or was issued to another client."
}
```

###### Errors
Status: 401

```
{
    "error": "invalid_grant",
    "error_message": "The provided authorization grant is invalid, expired, revoked, does not match the redirection URI used in the authorization request, or was issued to another client."
}
```
### Refresh a token
##### POST /oauth/token
###### Parameters
- **refresh_token** _(String)_: _< the facebook token of the user>_
- **grant_type** _(String)_: "refresh_token"

###### Response
Status: 200

```
{
    "access_token": "6f3a305cc95de8db21d923f3c51e05a312f6cb822f50f2e3b9aaccdae16a49be",
    "token_type": "bearer",
    "refresh_token": "6f3a305cc95de8db21d923f3c51e05a312f6cb822f598hb74"
    "expires_in": 7200,
    "created_at": 1429709966
}
```

## Users

### Create a user
##### POST /api/v1/users
###### Parameters
- **email** (_String_): _< email of the user >_
- **password** (_String_): _< password chosen by the user (at least 8 caracters) >_
- **password_confirmation** (_String_): _< password chosen by the user (at least 8 caracters) >_
- **username** (_String_): _< username chose by the user >_

###### Response
status: 200
```
{
    "id": 1,
    "email": "bosco.nguyen@gmail.com",
    "username": "bosconguyen",
    "first_name": null,
    "last_name": null
}
```

### Update a user
##### PUT /api/v1/users/:id
###### Parameters
- **first_name** (_String_): _< first name of the user >_
- **last_name** (_String_): _< last name of the user >_
- **email** (_String_): _< email of the user >_
- **password** (_String_): _< password chosen by the user (at least 8 caracters) >_
- **password_confirmation** (_String_): _< password chosen by the user (at least 8 caracters) >_
- **username** (_String_): _< username chose by the user >_

###### Response
status: 200
```
{
    "id": 1,
    "email": "bosco.nguyen@gmail.com",
    "username": "bosconguyen",
    "first_name": "Bosco",
    "last_name": "Nguyen"
}
```
