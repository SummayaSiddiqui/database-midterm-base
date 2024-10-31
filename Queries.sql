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

-- This script inserts Movies in the table called 'movies'
INSERT INTO movies (title, release_year, genre, director) VALUES
('The Shawshank Redemption', 1994, 'Drama', 'Frank Darabont'),
('The Godfather', 1972, 'Crime', 'Francis Ford Coppola'),
('The Dark Knight', 2008, 'Action', 'Christopher Nolan'),
('Pulp Fiction', 1994, 'Crime', 'Quentin Tarantino'),
('Forrest Gump', 1994, 'Drama', 'Robert Zemeckis');

-- This script inserts Customers in the table called 'customers'
INSERT INTO customers (first_name, last_name, email, phone_number) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901'),
('Bob', 'Johnson', 'bob.johnson@example.com', '345-678-9012'),
('Alice', 'Davis', 'alice.davis@example.com', '456-789-0123'),
('Charlie', 'Brown', 'charlie.brown@example.com', '567-890-1234');

-- This script inserts Rentals in the table called 'rentals'
INSERT INTO rentals (customer_id, movie_id, rental_date, return_date) VALUES
(1, 1, '2024-10-01', '2024-10-10'),
(1, 3, '2024-10-02', '2024-10-09'),
(2, 2, '2024-10-03', '2024-10-13'),
(2, 4, '2024-10-04', '2024-10-14'),
(3, 5, '2024-10-05', '2024-10-15'),
(4, 1, '2024-10-06', '2024-10-16'),
(5, 2, '2024-10-07', '2024-10-17'),
(1, 4, '2024-10-08', '2024-10-18'),
(3, 3, '2024-10-09', '2024-10-19'),
(4, 5, '2024-10-10', '2024-10-20');

-- Queries to Solve Requirements
-- Find all movies rented by a specific customer, given their email
SELECT movies.title
FROM movies
JOIN rentals ON movies.movie_id = rentals.movie_id
JOIN customers  ON rentals.customer_id = customers.customer_id 
WHERE customers.email = 'charlie.brown@example.com';

-- Given a movie title, list all customers who have rented the movie
SELECT customers.first_name, customers.last_name
FROM customers
JOIN rentals ON customers.customer_id = rentals.customer_id
JOIN movies ON rentals.movie_id = movies.movie_id 
WHERE movies.title = 'The Shawshank Redemption';

-- Get the rental history for a specific movie title
SELECT customers.first_name, customers.last_name, rentals.rental_date, rentals.return_date 
FROM rentals
JOIN movies ON rentals.movie_id = movies.movie_id
JOIN customers ON rentals.customer_id = customers.customer_id 
WHERE movies.title = 'The Shawshank Redemption';

-- For a specific movie director:
    -- Find the name of the customer, the date of the rental and title of the movie, each time a movie by that director was rented
SELECT customers.first_name, customers.last_name, rentals.rental_date, movies.title 
FROM rentals
JOIN movies ON rentals.movie_id = movies.movie_id 
JOIN customers ON rentals.customer_id = customers.customer_id 
WHERE movies.director = 'Frank Darabont';


