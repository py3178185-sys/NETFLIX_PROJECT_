   drop table if exists netflix_

	CREATE TABLE netflix_ (
				show_id	varchar(8),
				typee	varchar(15),
				title	varchar(150),
				director varchar(208),	
				casts	varchar(1000),
				country	 varchar(150),
				date_added	varchar(50),
				release_year int,	
				rating	varchar(8),
				duration varchar(50),
				listed_in	varchar(100),
				description varchar(250)
);			




 select * from netflix_;

--FIND THE TOTAL NUMBERS OF MOVIES VS TV SHOW

 select typee,count(*) as total_typee from netflix_
 group by typee


-- find the director who just make movie 

  select director,typee from netflix_
  where typee = 'Movie'

-- find the director who just make movie 

 select director,typee from netflix_
  where typee = 'TV Show'


  select * from netflix_

---List all countries where Netflix movies are available.
  select UNNEST(STRING_TO_ARRAY(country,',')) from netflix_ 
  where typee ='Movie'
 
--FIND THE MOST COMMON RATING FOR MOVIES AND TV SHOWS
  SELECT typee,rating
   FROM
       (
       SELECT typee,rating,COUNT(*), 
        RANK() OVER(PARTITION BY typee ORDER BY COUNT(*) DESC) AS ranking
         FROM netflix_
          GROUP BY 1,2) AS T1
           WHERE ranking =1
   
  -- LIST ALL MOVIES RELEASED IN A SPECIFIC YEAR (e.g 2020)

		select * from netflix_
		where typee ='Movie' AND release_year = 2020

--find the top 5 countries with the most content on netflix
  

  select * from netflix_


SELECT
    UNNEST(STRING_TO_ARRAY(country, ', ')) AS TOP_COUNTRY,COUNT(show_id) AS total_content
FROM netflix_
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 5

--Find all directors whose name starts with "S".
  SELECT typee,director FROM netflix_
  WHERE director LIKE 'S%'
--identify the longest movie


select * from netflix_
 where typee ='Movie' 
      and  duration=(
                  select max(duration) from netflix_
				 
				  
);

---find content added in thelast five years
    select *,TO_date(date_added,'Month DD, YYYY') from netflix_
   where TO_date(date_added,'Month DD, YYYY') >= current_date - INTERVAL '5 years'


--find all the movies /tv shows by director  'Rajiv Chilaka'
   select * from netflix_
   where director like 'Rajiv Chilaka'
 


   select title,TO_char(to_date(date_added,'Month DD, YYYY'),'DD-MM-YYYY') FROM netflix_


--LIST ALL TV SHOWS WITH MORE THAN 5 SEASONS
   SELECT * FROM netflix_
    WHERE typee = 'TV Show' and SPLIT_PART(duration,' ',1)::numeric > 5

--count the number of content items in each genre 
   select UNNEST(STRING_TO_ARRAY(listed_in,',')) as each_genre,count(show_id) as total_count from netflix_
   GROUP BY 1

 --find all cotent without director
  SELECT show_id,director FROM netflix_
  WHERE director is null

  --find how many movies actor 'salaman khan' appered in last 10 years
  SELECT * FROM netflix_
  WHERE casts ILIKE '%Salman Khan%'
   AND  release_year > EXTRACT(YEAR FROM  CURRENT_DATE) -10


--FIND THE TOP 10 ACTOR WHO HAVE APPEARED IN THE HIGHEST NUMBER OF MOVIES PRODUCED IN INDIA
   SELECT UNNEST(STRING_TO_ARRAY(casts,',')) AS ALL_Casts,COUNT(*) AS total_movies FROM netflix_
    WHERE country ILIKE '%India%'
    GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10

SELECT * FROM netflix_
 -- Find the percentage of Movies vs TV Shows
  SELECT
    typee,
    COUNT(*) AS total_titles,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM netflix_),
        2
    ) AS percentage
FROM netflix_
GROUP BY typee;

--Find countries where only Movies are available (no TV Shows).

  SELECT DISTINCT TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country
			FROM netflix_
			WHERE typee = 'Movie'
	
	EXCEPT

			SELECT DISTINCT TRIM(UNNEST(STRING_TO_ARRAY(country, ',')))
			FROM netflix_
			WHERE typee = 'TV Show';

---Find titles where the director is also listed in the cast.

  SELECT title, director
FROM netflix_ n
WHERE director IN (
    SELECT TRIM(UNNEST(STRING_TO_ARRAY(n.casts, ',')))
);
    --2 METHOD--
	
SELECT title, director, casts
FROM netflix_
WHERE casts ILIKE '%' || director || '%';




