# 1
# List titles of movies released in 2008.
# Outputs single column for title of each movie.
SELECT title FROM movies WHERE year = 2008;


# 2
# Determine birth year of Emma Stone.
# Outputs single column and single row containing Emma Stone’s birth year.
# Assumes only one person in database with name 'Emma Stone'.
SELECT birth FROM people WHERE name = "Emma Stone";


# 3
# List titles of movies released in 2018 or later, in alphabetical order.
# Outputs single column for title of each movie.
SELECT title FROM movies WHERE year >= 2018 ORDER BY title;


# 4
# Determine number of movies with IMDb rating of 10.0.
# Outputs a single column and a single row containing the number of movies with a 10.0 rating.
SELECT COUNT(movie_id) FROM ratings WHERE rating = 10.0;


# 5
# List titles and release years of all Harry Potter movies, in chronological order.
# Outputs two columns, one for title of each movie and one for release year.
# Assumes titles of all Harry Potter movies begin with “Harry Potter".
# Assumes movie titles beginning with “Harry Potter”, are in fact a Harry Potter movies.
SELECT title, year FROM movies WHERE title LIKE "Harry Potter%" ORDER BY year;


# 6
# Determine average rating of all movies released in 2012.
# Outputs a single column and a single row containing average rating.
SELECT AVG(rating) FROM ratings
WHERE movie_id IN (SELECT id FROM movies WHERE year  = 2012);


# 7
# List movies released in 2010 and their ratings, in descending order by rating.
# For movies with the same rating, ouput is ordereded alphabetically by title.
# Outputs two columns, one for title of each movie and one for rating.
# Movies that do not have ratings are not included in the result.
SELECT title, rating FROM ratings
JOIN movies on ratings.movie_id = movies.id
WHERE year = 2010 ORDER BY rating DESC, title;


# 8
# List names of people who starred in Toy Story.
# Outputs a single column of names.
# Assumes only one movie in database with title Toy Story.
SELECT name FROM people
JOIN stars ON people.id = stars.person_id
JOIN movies ON stars.movie_id = movies.id
WHERE title = "Toy Story";


# 9
# List names people who starred in a movie released in 2004, ordered by birth year.
# Outputs a single column of names.
# People with same birth year not listed in any particular order.
# People appearing in multiple movies in 2004 only appear once in results.
SELECT DISTINCT name FROM people
JOIN stars ON people.id = stars.person_id
JOIN movies ON stars.movie_id = movies.id
WHERE year = 2004 ORDER BY birth;


# 10
# List names of people who have directed a movie with rating of at least 9.0.
# Outputs a single column of names.
SELECT name FROM people
JOIN directors ON people.id = directors.person_id
JOIN movies ON directors.movie_id = movies.id
JOIN ratings ON movies.id = ratings.movie_id
WHERE rating >= 9.0;


# 11
# List titles of five highest rated movies (in descending order) that Chadwick Boseman starred in.
# Outputs a single column of movie titles.
# Assumes only one person in database with name Chadwick Boseman.
SELECT title FROM ratings
JOIN movies ON ratings.movie_id = movies.id
JOIN stars ON movies.id = stars.movie_id
JOIN people ON stars.person_id = people.id
WHERE name = "Chadwick Boseman" ORDER BY rating DESC LIMIT 5;


# 12
# List movie titles in which both Johnny Depp and Helena Bonham Carter starred.
# Outputs a single column of movie titles.
# Assumes only one person in database with name Johnny Depp.
# Assumes only one person in database with name Helena Bonham Carter.
SELECT title FROM movies
JOIN stars ON movies.id = stars.movie_id
JOIN people ON stars.person_id = people.id
WHERE name = 'Johnny Depp'
INTERSECT
SELECT title FROM movies
JOIN stars ON movies.id = stars.movie_id
JOIN people ON stars.person_id = people.id
WHERE name = 'Helena Bonham Carter';


#13
# List names of people who starred in a movie in which Kevin Bacon also starred.
# Outputs a single column of names.
# Only selects the 'Kevin Bacon' born in 1958.
# Kevin Bacon himself is excluded from the resulting list.
SELECT * FROM
(SELECT name FROM people
JOIN stars ON people.id = stars.person_id
WHERE movie_id
IN
(SELECT movie_id FROM stars
JOIN people ON stars.person_id = people.id
WHERE name = 'Kevin Bacon' AND birth = 1958))
WHERE NOT name = 'Kevin Bacon';
