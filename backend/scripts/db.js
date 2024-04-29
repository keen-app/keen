const pg = require('pg')
require("dotenv").config(); // Loads in environment variables from .env file

const QUERY_ERROR = -1;
const QUERY_SUCCESS = 1;

const pool = new pg.Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT || 3000,
    ssl: {
        rejectUnauthorized: false
    }
});

async function getUsers() {
    const client = await pool.connect();
    try {
        const res = await client.query('SELECT * FROM keen."User"');
        client.release();
        return res.rows;
    } catch (err) {
        console.error(err);
        return QUERY_ERROR;
    }
}

async function createUser(first_name, last_name, age, email) {
    const client = await pool.connect();
    try {
        const query = {
            text: 'INSERT INTO "User"(first_name, last_name, age, email) VALUES($1, $2, $3, $4)',
            values: [first_name, last_name, age, email],
        }
        await client.query(query);
        client.release();
        return QUERY_SUCCESS;
    } catch (err) {
        console.log(err);
        return QUERY_ERROR;
    }
}

module.exports = { QUERY_ERROR, QUERY_SUCCESS, getUsers, createUser };
