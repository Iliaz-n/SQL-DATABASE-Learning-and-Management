USE universityranking;


SELECT MAX(score) AS maximum, MIN(score) AS minimum,
	   (MAX(score) - MIN(score)) AS `range`,
       COUNT(score) AS score_count, 
       COUNT(DISTINCT score) AS n_unique
FROM university_ranking_year
WHERE score <= 100;


# MEAN
# Use in built in AVG function
SELECT AVG(score) AS mean 
FROM university_ranking_year
WHERE score <= 100;

# Manually
SELECT SUM(score)/COUNT(score) AS mean
FROM university_ranking_year
WHERE score <= 100 AND score IS NOT NULL;

# Using frequency
WITH freq_table AS (
	SELECT score, COUNT(score) AS freq
    FROM university_ranking_year
    GROUP BY score) 
SELECT SUM(score * freq)/SUM(freq) AS mean
FROM freq_table
WHERE score <= 100 and score IS NOT NULL;


# MODE
# Using frequency
WITH freq_table AS (
	SELECT score, COUNT(score) AS freq
    FROM university_ranking_year
    GROUP BY score
    ) 
SELECT score, freq
FROM freq_table
WHERE score <= 100
ORDER BY freq DESC
LIMIT 1;


# MEDIAN 





SELECT *
FROM university_ranking_year, (SELECT COUNT(*) AS size
	FROM university_ranking_year) AS t1, (SELECT (COUNT(score)/2) AS midd
		FROM university_ranking_year WHERE score IS NOT NULL) AS midd
ORDER BY score;


WITH ranked_data AS (
	SELECT ROW_NUMBER() OVER(ORDER BY score) AS row_num,
		score, COUNT(score) AS size
	FROM university_ranking_year
    GROUP BY score)
SELECT score
FROM ranked_data
WHERE


	SELECT ROW_NUMBER() OVER(ORDER BY score) AS row_num,
		score, COUNT(score) AS size
	FROM university_ranking_year
    GROUP BY score
