# DATA ANALYSIS OF NETFLIX Movies and TV Shows using SQL 
![Netflix Logo]()
## 🎯 Objective
* Analyze the distribution of Movies and TV Shows.
* Identify the top countries producing Netflix content.
* Explore content release trends over the years.
* Analyze ratings, genres, directors, and cast members.

## 📂 Dataset
The data for this project is sourced from kaggle,s datasets
• Dataset Link : ‪
C:\Users\HP\Downloads\archive.zip
### Dataset Features
* Title
* Type (Movie / TV Show)
* Director
* Cast
* Country
* Date Added
* Release Year
* Rating
* Duration
* Genre (`listed_in`)
* Description

This dataset is used to perform data exploration and answer business-related questions using SQL.

## Schema
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

## Business problems and solutions
select * from netflix_;

## 1--FIND THE TOTAL NUMBERS OF MOVIES VS TV SHOW

 select typee,count(*) as total_typee 
 from netflix_
 group by typee


## 2. find the director who just make movie 

  select director,typee 
  from netflix_
  where typee = 'Movie'

## 3. find the director who just make movie 
```sql
 select director,typee 
 from netflix_
 where typee = 'TV Show';
```

  select * from netflix_

## 4-List all countries where Netflix movies are available.
```sql
  select UNNEST(STRING_TO_ARRAY(country,',')) 
  from netflix_ 
  where typee ='Movie'
 ```
## 5-FIND THE MOST COMMON RATING FOR MOVIES AND TV SHOWS
```sql
  SELECT typee,rating
   FROM
       (
       SELECT typee,rating,COUNT(*), 
        RANK() OVER(PARTITION BY typee ORDER BY COUNT(*) DESC) AS ranking
         FROM netflix_
          GROUP BY 1,2) AS T1
           WHERE ranking =1
   ```
  ## 6- LIST ALL MOVIES RELEASED IN A SPECIFIC YEAR (e.g 2020)
    ```sql
		select * from netflix_
		where typee ='Movie' AND release_year = 2020
    ```
## 7-find the top 5 countries with the most content on netflix_
```sql
SELECT
    UNNEST(STRING_TO_ARRAY(country, ', ')) AS TOP_COUNTRY,COUNT(show_id) AS total_content
FROM netflix_
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 5
```
## 8--Find all directors whose name starts with "S".
 ```sql
  SELECT typee,director FROM netflix_
  WHERE director LIKE 'S%'
  ```
## 9-identify the longest movie
```sql
select * from netflix_
 where typee ='Movie' 
      and  duration=(
                  select max(duration) from netflix_
				 );
```
## 10-find content added in thelast five years
  ```sql
	select *,TO_date(date_added,'Month DD, YYYY') 
	from netflix_
   where TO_date(date_added,'Month DD, YYYY') >= current_date - INTERVAL '5 years'
```

## 11.find all the movies /tv shows by director  'Rajiv Chilaka'
 ```sql 
   SELECT * FROM netflix_
 WHERE director ILIKE 'Rajiv Chilaka'
```
## 13 LIST ALL TV SHOWS WITH MORE THAN 5 SEASONS
   ```sql 
   SELECT * FROM netflix_
    WHERE typee = 'TV Show' and SPLIT_PART(duration,' ',1)::numeric > 5
```
## 14-count the number of content items in each genre 
 ```sql 
  SELECT UNNEST(STRING_TO_ARRAY(listed_in,',')) as each_genre,
  COUNT(show_id) as total_count
  FROM netflix_
  GROUP BY 1
```
## 15-find all cotent without director
 ```sql 
  SELECT show_id,director 
  FROM netflix_
  WHERE director is null
```
## 16 find how many movies actor 'salaman khan' appered in last 10 years
 ```sql 
  SELECT * FROM netflix_
  WHERE casts ILIKE '%Salman Khan%'
   AND  release_year > EXTRACT(YEAR FROM  CURRENT_DATE) -10
```
## 17. FIND THE TOP 10 ACTOR WHO HAVE APPEARED IN THE HIGHEST NUMBER OF MOVIES PRODUCED IN INDIA
 ```sql 
   SELECT UNNEST(STRING_TO_ARRAY(casts,',')) AS ALL_Casts,
   COUNT(*) AS total_movies FROM netflix_
    WHERE country ILIKE '%India%'
    GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10
```
 ## 18. Find the percentage of Movies vs TV Shows
  ```sql 
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
```
## 19 -Find countries where only Movies are available (no TV Shows).
 ```sql 
  SELECT DISTINCT TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country
			FROM netflix_
			WHERE typee = 'Movie'
	
	EXCEPT

			SELECT DISTINCT TRIM(UNNEST(STRING_TO_ARRAY(country, ',')))
			FROM netflix_
			WHERE typee = 'TV Show';
```
## 20-Find titles where the director is also listed in the cast.
 ```sql 
  SELECT title, director
FROM netflix_ n
WHERE director IN (
    SELECT TRIM(UNNEST(STRING_TO_ARRAY(n.casts, ',')))
);
    -2 METHOD--
	
SELECT title, director, casts
FROM netflix_
WHERE casts ILIKE '%' || director || '%';
```









