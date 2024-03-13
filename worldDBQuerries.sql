USE world;

# EX1: Create one observations into any table of the world database
INSERT INTO country VALUES
	("UOA", "United States of Africa", "Africa", "North Africa", RAND() * (70000000 + 1), 2002, 
     RAND() * (2000000 + 1), RAND() * (100 + 1), RAND() * (10000000 + 1), RAND() * (10000000 + 1), 
	 "African Nations", "Federal Republic", "Muhammad Gadaffi", 4657, "UA");

DELETE FROM country
WHERE `Code` = "UOA";

UPDATE countrylanguage
SET `Language` = "Yoruba"
WHERE INSTR(`Language`, "oruba") > 0;

#EX2 Alter the table and add a unique key
ALTER TABLE country ADD UNIQUE KEY(Region, Capital);

#EX3 Select all countries that are in North America
SELECT *#`Name` 
FROM country
WHERE Continent = "North America";

#EX4 Select all cities with Population between 8Million and 10Million
SELECT * 
FROM city 
WHERE Population BETWEEN 8000000 AND 10500000
ORDER BY Population DESC;


#EX5 Select all citites with population greater than 5Million and country is China
SELECT *
FROM city 
WHERE CountryCode = "CHN" AND Population > 5000000
ORDER BY Population DESC;

#EX6 Make a list of unique district in the city table
SELECT DISTINCT(District)
FROM city
LIMIT 10;

#EX7 Join the city table on country table 
SELECT *
FROM country AS C1
JOIN city AS C2
ON C1.`Code` = C2.CountryCode
WHERE C1.`Code` = "AFG";


/*EX8 Join the tables City and Country to show a result where each city population is
shown next to the country’s population, for the country where the city is. */
SELECT c1.`Name`, c1.Population AS CountyPop, c2.`Name`, c2.Population AS CityPop
FROM country AS c1
JOIN city AS c2 ON c1.`Code` = c2.CountryCode;

/*EX9 Join the city table on the country table showing districts
with less than 0.5% populations of the country*/
SELECT District, SUM(C2.Population) AS DistrictPop
FROM country AS C1
JOIN city AS C2
ON C1.`Code` = C2.CountryCode
WHERE C2.Population < C1.Population * 0.005
GROUP BY District;

/*EX10 Join the tables CountryLanguage and Country to show a result
where each country name is shown next to the country’s languages.*/
SELECT c1.`Name`, c1.Population AS CountyPop, c2.`Language`, c2.Percentage, IsOfficial
FROM country AS c1
JOIN countrylanguage AS c2 ON c1.`Code` = c2.CountryCode;

/* EX11 Calculate the number of years that a country
has been independent*/
SELECT `Name`, IndepYear,  (YEAR(NOW()) - IndepYear) AS Years_of_Indep
FROM country
ORDER BY Years_of_Indep DESC;

#EX12 Count the total data points in the table
SELECT COUNT(*) AS size, COUNT(DISTINCT(`Name`)) AS unique_size
FROM country;

/*EX13 Give the name of countries with a GNP
greater than the average GNP (for all countries).*/
SELECT `Name`, GNP
FROM country, (
				SELECT AVG(GNP) avg_gnp
                FROM country
                ) AS t1
WHERE GNP > avg_gnp
ORDER BY GNP DESC;


/*EX14 Calculate the average GNP when the the GNP is < average GNP 
and the average GNP when the GNP is > than the average GNP (for all countries).*/
SELECT 
	AVG(CASE WHEN GNP > avg_gnp THEN GNP ELSE NULL END) AS avg_max_gnp,
	AVG(CASE WHEN GNP < avg_gnp THEN GNP ELSE NULL END) AS avg_min_gnp
FROM country, (
				SELECT AVG(GNP) AS avg_gnp
                FROM country
				) AS T3;
                

#EX15 Calculate the percentage of countries with GNP > the average gnp
SELECT ROUND((SUM(CASE WHEN GNP > avg_gnp THEN 1 ELSE 0 END) * 100)
		/ (COUNT(GNP) * 1.0), 2) AS percentage
FROM country, (
				SELECT AVG(GNP) AS avg_gnp 
                FROM country) AS t1;


/*EX16 Count how many countries speaks 'English'. Then show how many countries speaks
'English' as a percentage of all languages. */
SELECT ROUND(AVG(total), 2) AS engl_count, 
	CONCAT_WS('%', ROUND((AVG(total)/COUNT(*) * 100), 2), '') AS perc_eng_count
FROM countrylanguage, 
	(SELECT  COUNT(*) AS total
    FROM countrylanguage
    WHERE `Language` = "English") AS t1;


/*EX17 Count how many how many countries speak each languages.*/
SELECT `Language`, COUNT(CountryCode) AS numb_of_count
FROM countrylanguage
GROUP BY `Language`
ORDER BY numb_of_count DESC;


/*EX18 Count the number of languages spoken in each country. 
Identify the country by its code (no join needed). Repeat identifying
each country by name (join needed).*/
SELECT CountryCode, COUNT(`Language`) AS numb_of_language
FROM countrylanguage
GROUP BY CountryCode;

SELECT `Name`, COUNT(`Language`) AS numb_of_language
FROM countrylanguage AS t1
LEFT JOIN country AS t2 ON t1.CountryCode = t2.`Code`
GROUP BY CountryCode;

/*EX19 Count the number of countries with percentage English speaker less than 5%, 
less than 10% but greater than 5% and greater than 10%*/

SELECT `Language`,
	SUM(CASE WHEN Percentage < 5 THEN 1 ELSE 0 END) AS not_common,
    SUM(CASE WHEN Percentage BETWEEN 5 AND 10 THEN 1 ELSE 0 END) mildly_spoken,
    SUM(CASE WHEN Percentage > 10 THEN 1 ELSE 0 END) widely_spoken,
    COUNT(*) AS total
FROM countrylanguage
GROUP BY `Language`;


/*EX20 Show the number of cities with more than 100,000 inhabitants for each country
but show only countries with at least 5 such cities.*/
SELECT t1.`Name`, COUNT(t1.`Name`) AS densly_pop_cities
FROM country AS t1
LEFT JOIN city AS t2 ON t1.`Code` = t2.CountryCode
WHERE t2.Population > 100000
GROUP BY t1.`Name`
HAVING COUNT(t1.`Name`) >=  5
ORDER BY `Name`;


/*EX21 Show the number of languages per country but show only countries 
where more than 2 languages are spoken.*/
SELECT t1.`Name`, COUNT(t2.`Language`) AS num_of_lang
FROM country AS t1
LEFT JOIN countrylanguage AS t2 ON t1.`Code` = t2.CountryCode
GROUP BY t1.`Name`
HAVING COUNT(t2.`Language`) >=  2
ORDER BY `Name`;


/*EX22 Show (for each country) the number of languages spoken by at least 10% of 
the population of that country but show only countries with more than 2 such languages.*/
SELECT t1.`Name`, COUNT(t1.`Name`) AS num_lang
FROM country AS t1
LEFT JOIN countrylanguage AS t2 ON t1.`Code` = t2.CountryCode
WHERE t2.Percentage >= 10
GROUP BY t1.`Name`
HAVING COUNT(t1.`Name`) >=  2
ORDER BY `Name`;


/*EX23 Sort the countries by number of languages spoken (most languages first).*/
SELECT t1.`Name`, COUNT(t1.`Name`) AS num_lang
FROM country AS t1
LEFT JOIN countrylanguage AS t2 ON t1.`Code` = t2.CountryCode
GROUP BY t1.`Name`
ORDER BY `num_lang` DESC;


/*EX23 Let the linguistic diversity of a country be defined as the number of
languages spoken in the country divided by the country’s population expressed in
millions. Find the country(ies) with the largest linguistic diversity.*/
SELECT t1.`Name`, COUNT(t1.`Name`) AS num_lang,
	SUM(t1.Population)/1000000 AS pop_in_millions,
	COUNT(t1.`Name`)/(SUM(t1.Population)/1000000) AS ling_diver
FROM country AS t1
LEFT JOIN countrylanguage AS t2 ON t1.`Code` = t2.CountryCode
GROUP BY t1.`Name`
ORDER BY `ling_diver` DESC;


#EX Calculate the Measure of Central Tendency for the distribution
/*EX25 Compute the arithmetic, geometric, and harmonic mean of this attribute.*/
# Arithmetic Mean
SELECT
	ROUND(AVG(LifeExpectancy), 4) AS Amean_lExpec,
    ROUND(EXP(AVG(LOG(LifeExpectancy))), 4) AS Gmean_lExpec,
	ROUND((COUNT(LifeExpectancy) / SUM(1/LifeExpectancy)), 4) AS Hmean_lExpec
FROM country;


#EX26 Calculate the Mode of the distribution
With freq_table AS (
	SELECT LifeExpectancy, COUNT(LifeExpectancy) AS freq
	FROM country
	GROUP BY LifeExpectancy)
SELECT LifeExpectancy, freq
FROM freq_table, (SELECT MAX(freq) AS most FROM freq_table) AS t1
WHERE freq = most;

#EX26 Calculate Median
With freq_table AS (
	SELECT LifeExpectancy, ROW_NUMBER() OVER(ORDER BY LifeExpectancy) AS row_num
	FROM country)
SELECT LifeExpectancy
FROM freq_table, (SELECT (FLOOR(COUNT(LifeExpectancy)/2) + 1) AS middle FROM freq_table) AS t1
WHERE middle = row_num;

#EX Calculate the Measure of Central Tendency for the distribution
#EX27 Calculate the standard deviation and variance
SELECT STD(LifeExpectancy)
FROM country;

SELECT SQRT(SUM(POWER((LifeExpectancy - mean), 2)) /
	(COUNT(LifeExpectancy) - 1))AS `STD`,
    SUM(POWER((LifeExpectancy - mean), 2)) /
	(COUNT(LifeExpectancy) - 1) AS `VAR`
FROM country, (
	SELECT AVG(LifeExpectancy) AS mean
    FROM country) AS t1;


/*EX Consider the Name attribute in table city of database world.*/
#EX28 Some values in this attribute include a second name in parenthesis. Display Name without such second names.
WITH new_table AS (
	SELECT `NAME`, POSITION('(' in `Name`) AS par_pos
    FROM city)
SELECT (CASE WHEN par_pos > 1 THEN LEFT(`Name`, (par_pos - 1)) ELSE `Name` END) AS new_name
FROM new_table;




DESCRIBE country;