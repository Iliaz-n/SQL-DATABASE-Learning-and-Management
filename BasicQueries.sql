# To show the available databases on the current server
SHOW DATABASES;

# The USE command is used to select which of the databases to use
USE universityranking;
SHOW TABLES;

# Basic SQL Queries 
# THE SELECT Query

# SELECT result-to-show
# FROM table-name(database-name.table-name)
# WHERE condition [optional]

SELECT country_name
FROM country
WHERE id = 73; # United States of America

# A query inside another query 
# Known as a subquery
SELECT u_names.university_name
FROM (SELECT id, university_name
FROM university
WHERE country_id = 73 # This is possible becasue country_id is represented as INT type
) AS u_names 
WHERE university_name LIKE "%Technology"; # Wildcard(%)


# JOIN query

SELECT u.*, ury.year, ury.score
FROM university AS u
JOIN university_ranking_year AS ury 
ON u.id = ury.university_id
WHERE `year` = 2016;

SELECT t1.id, country_id, university_name, country_name, `year`, score
FROM (SELECT u.*, ury.year, ury.score
FROM university AS u
JOIN university_ranking_year AS ury 
ON u.id = ury.university_id
WHERE `year` = 2016) AS t1
JOIN country AS t2 
ON t1.country_id = t2.id
