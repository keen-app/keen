const pg = require('pg')
require("dotenv").config(); // Loads in environment variables from .env file

const QUERY_SUCCESS = 1;
const QUERY_ERROR = -1;
const USER_DOES_NOT_EXIST = -2;

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

// Functions are ordered in CRUD fashion:
// Create 
// Read 
// Update 
// Delete 

/**============================================
 *               CREATE QUERIES
 *=============================================**/

async function createUser(email, first_name, last_name, username) {
    const client = await pool.connect();
    try {
        const query = {
            text: 'INSERT INTO "User"(email, first_name, last_name, username) VALUES($1, $2, $3, $4)',
            values: [email, first_name, last_name, username],
        }
        await client.query(query);
        client.release();
        return QUERY_SUCCESS;
    } catch (err) {
        console.log(err);

        client.release();
        return QUERY_ERROR;
    }
}



/**============================================
 *               READ QUERIES
 *=============================================**/

async function getAllUsers() {
    const client = await pool.connect();
    try {
        const res = await client.query('SELECT * FROM "User"');
        client.release();
        return res.rows;
    } catch (err) {
        console.error(err);

        client.release();
        return QUERY_ERROR;
    }
}

async function getUser(username) {
    const client = await pool.connect()
    try {
        const query = {
            text: 'SELECT * FROM "User" WHERE username = $1',
            values: [username]
        }
        const res = await client.query(query);

        if (res.rows.length === 0) {
            return USER_DOES_NOT_EXIST;
        }

        client.release();
        return res.rows;
    } catch (err) {
        console.error(err);

        client.release();
        return QUERY_ERROR;
    }
}

async function getUsersKeenedEvents(username) {

    // Check if username is valid
    user = await getUser(username);
    if (user === USER_DOES_NOT_EXIST) {
        return USER_DOES_NOT_EXIST
    }

    const client = await pool.connect()
    try {
        const sql = `
        SELECT "Event".name, "Event".visibility, "Event".start, "Event".end, "Event".emoji, "Event".location, "Event".url, "Event".description
        FROM "User" INNER JOIN "Keened" ON "User".email = "Keened".user_email
                    INNER JOIN "Event" ON "Keened".event_id = "Event".id
        WHERE "User".username = $1;
        `
        const query = {
            text: sql,
            values: [username]
        }
        const res = await client.query(query);
        client.release();
        return res.rows;
    } catch (err) {
        console.error(err);

        client.release();
        return QUERY_ERROR;
    }
}



/**============================================
 *            EXPORT ALL FUNCTIONS
 *=============================================**/

module.exports = { 
    QUERY_ERROR, 
    USER_DOES_NOT_EXIST,
    QUERY_SUCCESS, 
    getAllUsers, 
    getUser,
    getUsersKeenedEvents, 
    createUser 
};
