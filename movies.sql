select version();

select 4*8;

create table if not exists public.movies(
movie_id int primary key,
movie_name varchar(50),
movie_genre varchar(50),
imdb_rating real
);

select * from movies;
DROP TABLE IF EXISTS students;

-- INSERT INTO movies(movie_id, movie_name, movie_genre, imdb_rating)
-- VALUES (101, 'Avengers', 'Action', 10.0),
-- (102, 'Toy', 'Mystry Sci-Fi', 7.3),
-- (103, 'Me3gan', 'Drama Fiction', 8.9),
-- (104, 'Laborendor', 'Romance', 6.4),
-- (105, 'NameSpaces', 'Nothing', 5.6);

select * from movies;
update movies
set movie_genre = 'Fiction Comedy'
where movie_id = 105;

delete from movies
where movie_id = 105

select * from movies
where imdb_rating > 8.5;

select * from movies
where imdb_rating between 8 and 9;

select * from movies where movie_genre = 'Action';

select movie_name, movie_genre from movies
where imdb_rating < 9.0;

select * from movies where imdb_rating in (7.3, 10);