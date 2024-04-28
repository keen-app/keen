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

app.get('/', (req, res) => {
    res.status(200).send("Welcome to Keen's API server!");
});

// GET http://localhost:8080/user
// The callback function is run when the route is requested i.e. it is the "handler"
// `req` is the incoming data, `res` is the data we want to send back to the client
// No incoming data in this API call, so we ignore `req`
app.get('/users', async (req, res) => {
    try {
        const query = await db.getUsers();
        if (query === db.QUERY_ERROR) throw "Error querying users from database";
        res.status(200).send(query);
    } catch (e) {
        res.status(500).send({error: e});
    }
});

// POST http://localhost:8080/user/
// Add a new user to the database.
app.post('/user/', async (req, res) => {
    try {
        const valid_user = await schema.userSchema.validateAsync(req.body);
        const query = await db.createUser(
            valid_user.first_name,
            valid_user.last_name,
            valid_user.age,
            valid_user.email
        );

        if (query === db.QUERY_ERROR) throw "Error inserting user into database";
        
        // Status 201 = Created
        res.status(201).send({message: "User created successfully"});
    } catch (e) {
        res.status(400).send({error: e});
    }
});