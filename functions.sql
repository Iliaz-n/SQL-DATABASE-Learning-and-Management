USE universityranking;
# Functions are of 2 types 
# Standard type and Aggregate type 
# The former can be used both in the SELECT statement and WHERE clause
# While the later can only be used on the WHERE clause

SELECT CEIL(AVG(num_students)) AS avg_num
FROM university_year
WHERE `year` = 2016;


SELECT *
FROM university AS u 
JOIN university_year AS uy
ON   u.id = uy.university_id
WHERE num_students > (SELECT AVG(num_students)
	FROM university_year) and `year` = 2016;
    
SELECT COUNT(CASE WHEN pct_international_students > 50 THEN 1 ELSE NULL END) AS sum
FROM university_year;


SELECT SUM(CASE WHEN `year`=2013 THEN 1 ELSE 0 END)/(COUNT(`year`) * 100) AS percentage
FROM university_year;


SELECT u.university_name, AVG(num_students)
FROM university_year AS uy
JOIN university AS u
ON	 uy.university_id = u.id
GROUP BY university_name;

SELECT *
FROM university AS u
JOIN university_ranking_year AS ury
ON	 u.id = ury.university_id
JOIN ranking_system AS rs
ON   ury.ranking_criteria_id = rs.id
WHERE `year` = 2016 
ORDER BY u.id LIMIT 5;

# CREATING arithemetic, geometic and harmonic mean 
CREATE TABLE trip(
	speed INT);

INSERT INTO trip VALUES
	(20), (27), (30), (10), (45), (50), (17), (11), (56), (40);

SELECT AVG(speed) AS a_mean,
	   POW(EXP(SUM(LOG(speed))), 1/COUNT(speed)) AS g_mean,
	   COUNT(*)/(SUM(1/speed)) AS h_mean
FROM trip;