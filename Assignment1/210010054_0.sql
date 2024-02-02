--Q1 (Assumption: I am not considering duplicates as actor may be director in some cases)
select act_fname as first_name, act_lname as last_name from actor
UNION
select dir_fname, dir_lname from director;

--Q2
select reviewer.rev_name, movie.mov_title, rating.rev_stars from reviewer, rating, movie
where reviewer.rev_id = rating.rev_id
and rating.rev_stars >= 7
and movie.mov_id = rating.mov_id;

--Q3 (Assumption: Considering only the movies in ratingData.csv)
select movie.mov_title from  movie, rating
where movie.mov_id = rating.mov_id
where rating.rev_stars is null;

--Q4
select movie.mov_title, movie.mov_year, movie.mov_duration, movie.mov_rel_date, movie.mov_rel_country from movie
where movie.mov_rel_country != 'USA';

--Q5 (Assumption: Name of reviewer whose rating is null in ratingdata.csv)
select reviewer.rev_name from reviewer, rating
where reviewer.rev_id = rating.rev_id
and rating.rev_stars is null;

--Q6 (Assumption: Not considering the rows which has rev_name as NULL)
select reviewer.rev_name, movie.mov_title, rating.rev_stars from movie, rating, reviewer
where reviewer.rev_id = rating.rev_id
and rating.mov_id = movie.mov_id
and reviewer.rev_name is not null
and rating.rev_stars is not null;

--Q7
select reviewer.rev_name, movie.mov_title 
from reviewer, movie, rating, rating other
where rating.mov_id=movie.mov_id 
and reviewer.rev_id=rating.rev_ID 
and rating.rev_id = other.rev_id 
group by rev_name, mov_title having count(*) > 1;

--Q8 (Assumption: Considering only the movies in ratingdata.csv)
select movie.mov_title from movie, rating, reviewer
where movie.mov_id = rating.mov_id
and rating.rev_id = reviewer.rev_id
and (reviewer.rev_name != 'Paul Monks' or reviewer.rev_name is null);

--Q9
select rev_name, mov_title, rev_stars from movie, reviewer, rating
where rev_stars = (select min(rev_stars) from rating)
and movie.mov_id = rating.mov_id
and reviewer.rev_id = rating.rev_id;

--Q10
select mov_title from movie, director, movie_direction
where director.dir_fname = 'James' and director.dir_lname = 'Cameron'
and movie_direction.mov_id = movie.mov_id
and director.dir_id = movie_direction.dir_id;

--Q11
select rev_name from reviewer, rating
where rating.rev_stars is null
and rating.rev_id = reviewer.rev_id;

--Q12
select act_fname, act_lname from actor, movie, movie_cast
where movie.mov_year not between 1990 and 2000
and actor.act_id = movie_cast.act_id
and movie_cast.mov_id = movie.mov_id;

--Q13
select dir_fname, dir_lname, gen_title, count(mov_id) from director
natural join movie_direction
natural join movie_genres
natural join genres
group by dir_fname, dir_lname, gen_title
order by dir_fname, dir_lname;

--Q14
select mov_title, mov_year, gen_title, dir_fname, dir_lname from movie
natural join movie_genres
natural join genres
natural join movie_direction
natural join director;

--Q15
select gen_title, avg(mov_duration), count(gen_title) from movie
natural join genres
natural join movie_genres
group by gen_title;

--Q16
select mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role from movie
natural join director
natural join actor
natural join movie_cast
natural join movie_direction
where mov_duration = (select min(mov_duration) from movie);

--Q17 (Assumption: Not considering the rows whose rev_name is null)
select rev_name, mov_title, rev_stars from movie
natural join reviewer
natural join rating
where rev_name is not null
order by rev_name, mov_title, rev_stars

--Q18 (Assumption: I have taken rev_stars as rating)
select movie.mov_title, director.dir_fname, director.dir_lname, rating.rev_stars from movie
natural join movie_direction
natural join director
natural join rating
where rev_stars is not null;

--Q19
select act_fname, act_lname, mov_title, role from movie
natural join movie_cast
natural join actor
natural join movie_direction
natural join director
where director.dir_fname = actor.act_fname and director.dir_lname = actor.act_lname;

--Q20
select act_fname, act_lname from actor
natural join movie_cast
natural join movie
where movie.mov_title = 'Chinatown';

--Q21
select mov_title from movie
natural join movie_cast
natural join actor
where act_fname = 'Harrison' and act_lname = 'Ford';

--Q22
select mov_title, mov_year, rev_stars from movie
natural join rating
natural join movie_genres
natural join genres
where genres.gen_title = 'Mystery' and rating.rev_stars = (select max(rev_stars) from rating
						 natural join movie
						 natural join movie_genres
						 natural join genres
						 where genres.gen_title = 'Mystery');
						 
--Q23
select mov_title, act_fname, act_lname, 
mov_year, role, gen_title, dir_fname, dir_lname, 
mov_rel_date, rev_stars
from movie 
natural join movie_cast
natural join actor
natural join movie_genres
natural join genres
natural join movie_direction
natural join director
natural join rating
WHERE act_gender='F';

--Q24
select act_fname, act_lname from actor
natural join movie_cast
natural join movie
natural join movie_direction
natural join director
where movie.mov_year = (select mov_year from movie
					 natural join movie_direction
					 natural join director
					 where director.dir_fname = 'Stanley' and director.dir_lname = 'Kubrick');
