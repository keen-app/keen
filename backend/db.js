import pg from 'pg'

const pool = new pg.Pool({
    user: 'postgres',
    host: 'database-keen.c7w6sywio5mf.ap-southeast-2.rds.amazonaws.com',
    database: 'postgres',
    password: 'alanfeketeiskeen',
    port: 5432, 
    ssl: {
        rejectUnauthorized: false
    }
});

const client = await pool.connect();
console.log('Connected to PostgreSQL database');
client.release()
await pool.end()