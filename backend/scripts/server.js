/* NODE.JS WITH EXPRESS */
const express = require("express");
const app = express();
const PORT = 8080;

/* OTHER PACKAGES */
const db = require("./db");
const schema = require("./schema");

// We need "middleware" to tell Express to parse incoming API requests as JSON
app.use(express.json())

app.listen(
    PORT,
    () => console.log(`Server started on http://localhost:${PORT}`)
);

/**============================================
 *               GET REQUESTS
 *=============================================**/

app.get('/', (req, res) => {
    res.status(200).send("Welcome to Keen's API server!");
});

// Get information of all users
app.get('/users', async (req, res) => {
    try {
        const query = await db.getAllUsers();
        if (query === db.QUERY_ERROR) throw "Error querying users from database";
        res.status(200).send(query);
    } catch (e) {
        res.status(500).send({error: e});
    }
});

// Get info of a specific user
app.get('/user/:username', async function(req, res) {
    const username = req.params.username;
    try {
        const query = await db.getUser(username);
        if (query === db.QUERY_ERROR) throw "Error querying user information from database";
        res.status(200).send(query);
    } catch (e) {
        res.status(500).send({error: e});
    }
});

// Get all events keened by a specific user
app.get('/events/:username', async function (req, res) {
    const username = req.params.username;
    try {
        const query = await db.getUsersKeenedEvents(username);
        if (query === db.USER_DOES_NOT_EXIST) throw "Username does not exist in the database";
        if (query === db.QUERY_ERROR) throw "Error retrieving user's saved events";
        res.status(200).send(query);
    } catch (e) {
        res.status(500).send({error: e});
    }
});

/**============================================
 *               POST REQUESTS
 *=============================================**/

// Add a new user to the database.
app.post('/user/', async (req, res) => {
    try {
        const valid_user = await schema.userSchema.validateAsync(req.body);
        const query = await db.createUser(
            valid_user.email,
            valid_user.first_name,
            valid_user.last_name,
            valid_user.username
        );

        if (query === db.QUERY_ERROR) throw "Error inserting user into database";
        
        // Status 201 = Created
        res.status(201).send({message: "User created successfully"});
    } catch (e) {
        res.status(400).send({error: e});
    }
});
