const { Pool } = require("pg");

// PostgreSQL connection
const pool = new Pool({
  user: "postgres", //This _should_ be your username, as it's the default one Postgres uses
  host: "localhost",
  database: "postgres", //This should be changed to reflect your actual database
  password: "Ayaz2502", //This should be changed to reflect the password you used when setting up Postgres
  port: 5432,
});

// Tests the database connection
async function testDatabaseConnection() {
  const client = await pool.connect();
  try {
    const result = await client.query("SELECT NOW()");
    console.log(
      "Database connected successfully. Current time:",
      result.rows[0].now
    );
  } catch (err) {
    console.error("Error connecting to the database:", err);
  } finally {
    client.release();
  }
}
/**
 * Creates the database tables, if they do not already exist.
 */
async function createTable() {
  const client = await pool.connect();
  try {
    await client.query(`
      CREATE TABLE IF NOT EXISTS movies (
        movie_id SERIAL PRIMARY KEY,
        title TEXT NOT NULL,
        release_year INTEGER NOT NULL,
        genre TEXT NOT NULL,
        director TEXT NOT NULL
      );
    `);

    await client.query(`
      CREATE TABLE IF NOT EXISTS customers (
        customer_id SERIAL PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone_number TEXT NOT NULL
      );
    `);

    await client.query(`
      CREATE TABLE IF NOT EXISTS rentals (
        rental_id SERIAL PRIMARY KEY,
        customer_id INTEGER REFERENCES customers(customer_id),
        movie_id INTEGER REFERENCES movies(movie_id),
        rental_date DATE NOT NULL,
        return_date DATE
      );
    `);

    console.log("Tables created successfully.");
  } catch (err) {
    console.error("Error creating tables:", err);
  } finally {
    client.release();
  }
}

/**
 * Inserts a new movie into the Movies table.
 *
 * @param {string} title Title of the movie
 * @param {number} year Year the movie was released
 * @param {string} genre Genre of the movie
 * @param {string} director Director of the movie
 */
async function insertMovie(title, year, genre, director) {
  // TODO: Add code to insert a new movie into the Movies table
}

/**
 * Prints all movies in the database to the console
 */
async function displayMovies() {
  const client = await pool.connect();
  try {
    const result = await client.query("SELECT * FROM Movies;");
    const movies = result.rows;

    if (movies.length === 0) {
      console.log("No movies found.");
    } else {
      console.log("Movies in the database:");
      movies.forEach((movie) => {
        console.log(
          `ID: ${movie.movie_id}, Title: ${movie.title}, Year: ${movie.release_year}, Genre: ${movie.genre}, Director: ${movie.director}`
        );
      });
    }
  } catch (err) {
    console.error("Error retrieving movies:", err);
  } finally {
    client.release();
  }
}

/**
 * Updates a customer's email address.
 *
 * @param {number} customerId ID of the customer
 * @param {string} newEmail New email address of the customer
 */
async function updateCustomerEmail(customerId, newEmail) {
  // TODO: Add code to update a customer's email address
}

/**
 * Removes a customer from the database along with their rental history.
 *
 * @param {number} customerId ID of the customer to remove
 */
async function removeCustomer(customerId) {
  // TODO: Add code to remove a customer and their rental history
}

/**
 * Prints a help message to the console
 */
function printHelp() {
  console.log("Usage:");
  console.log(
    "  insert <title> <year> <genre> <director> - Insert a movie"
  );
  console.log("  show - Show all movies");
  console.log(
    "  update <customer_id> <new_email> - Update a customer's email"
  );
  console.log(
    "  remove <customer_id> - Remove a customer from the database"
  );
}

/**
 * Runs our CLI app to manage the movie rentals database
 */
async function runCLI() {
  await testDatabaseConnection();
  await createTable();

  const args = process.argv.slice(2);
  switch (args[0]) {
    case "insert":
      if (args.length !== 5) {
        printHelp();
        return;
      }
      await insertMovie(args[1], parseInt(args[2]), args[3], args[4]);
      break;
    case "show":
      await displayMovies();
      break;
    case "update":
      if (args.length !== 3) {
        printHelp();
        return;
      }
      await updateCustomerEmail(parseInt(args[1]), args[2]);
      break;
    case "remove":
      if (args.length !== 2) {
        printHelp();
        return;
      }
      await removeCustomer(parseInt(args[1]));
      break;
    default:
      printHelp();
      break;
  }
}

runCLI();
