-- This scripts creates a table called 'movies'
CREATE TABLE movies(
  movie_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    release_year INTEGER NOT NULL,
    genre TEXT NOT NULL,
    director TEXT NOT NULL
);

-- This script creates a table called 'customers'
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone_number TEXT NOT NULL
);

-- This script creates a table called 'rentals'
CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    movie_id INTEGER REFERENCES movies(movie_id),
    rental_date DATE NOT NULL,
    return_date DATE
);