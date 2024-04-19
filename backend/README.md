# Keen's API Server

Source code for Keen's API to communicate with our PostgreSQL database server.

### Built with
![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)
![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

## Getting started 

Currently, we do not have the server deployed live. Thus, all development for now occurs locally, using Postman to test our API. 

### Prerequisites

- node.js
- pgAdmin
- Postman

### Installation

Below are steps you can follow to get the server up and running on your machine.

1. **Clone the repository**
```bash
   git clone 
```

2. **Install dependencies in project directory**
```bash
    cd keen
    npm install
```

3. **Set up environment variables**

- Copy the `env.example` to a new file `.env`
- Fill in the values
```
    DB_USER=your_database_user
    DB_HOST=your_database_host
    DB_NAME=your_database_name
    DB_PASSWORD=your_database_password
    DB_PORT=your_database_port
```

4. Run the server locally

```bash
    npm start
```

### Using Postman to test the API

[Insert instructions here]