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


