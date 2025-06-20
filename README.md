markdown
# ⚡ Ballerina CRUD API

A simple CRUD REST API using **Ballerina** and **MySQL**. Easily insert,search,update and delete user data.

---

## 🔧 Requirements

- **Ballerina** (v2201.12.6+)
- **MySQL**
- MySQL Connector/J (JDBC Driver)

---

## 🗂️ Project Layout

````

ballerina-CRUD/
├── service.bal            → Main REST API
├── types.bal              → User data types
├── Config.toml            → DB config
└── modules/
└── database/
├── client.bal     → DB connection
├── types.bal      → DB types
├── db\_queries.bal → SQL logic
└── db\_functions.bal → DB handlers

````

---

## ⚙️ Setup

1. Create a MySQL database:
   
sql
   CREATE DATABASE UserDB;
````

2. Edit Config.toml:

   
toml
   [ballerina_CRUD_task.database.dbConfig]
   user = "root"
   password = 
   host = "localhost"
   port = 3306
   database = "User_db"
   

---

## 🚀 Run It
bash
bal build
bal run

> Server runs on: http://localhost:8085

---

## 🛠️ API Overview

| Method | URL           | Description      |
| ------ | ------------- | ---------------- |
| GET    | /users                 | List all users   |
| GET    | /users/{id}            | List all users   |
| GET    | /users/search/{name}   | List all users   |
| POST   | /users                 | Add new user     |
| PATCH  | /users/{id}            | Update user info |
| DELETE | /users/{id}            | Remove user      |

---

## 🔍 Examples

**Create a user**
bash
curl -X POST http://localhost:9098/users \
-H "Content-Type: application/json" \
-d '{"name": "Jane", "email": "jane@demo.com"}'

**Get users**
bash
curl http://localhost:9098/users


**Serch users by name**
bash
curl http://localhost:9098/users/search/name

**Update user**
bash
curl -X PATCH http://localhost:9098/users/2 \
-H "Content-Type: application/json" \
-d '{"email": "new@email.com"}'

**Delete user**
bash
curl -X DELETE http://localhost:8085/users/2

---

## Notes

Validate inputs before POST/PATCH.
Basic error handling included.
Extend the db_queries.bal file for custom queries.

---
