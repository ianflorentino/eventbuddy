# API documentation

## Table of content

- [Authentication](#authentication)
    - [Create an access token with login and password](#create-an-access-token-with-login-and-password)
    - [Refresh a token](#refresh-a-token)

## Authentication
Authentications are based on the Oauth2 Protocol in which the Rails application act as a provider.
The header of an authenticated api call must contain an authentication token.
The token expires in 4 months. This is the only request that will be in JSON and not messagepack

**Header parameter:**

**Authorization:** bearer _< token >_

####Errors
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

