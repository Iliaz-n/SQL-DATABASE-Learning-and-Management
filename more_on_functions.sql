CREATE TABLE test_table(
	student_id INT PRIMARY KEY, 
    gpa DECIMAL(3, 2), 
    gre INT, 
    sat INT);

ALTER TABLE test_table 
MODIFY COLUMN student_id INT AUTO_INCREMENT;

INSERT INTO test_table(gpa, gre, sat) VALUES
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),  
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1)),
	(ROUND(RAND() * 3 + 1, 2), ROUND(RAND() * 340 + 1), ROUND(RAND() * 800 + 1));

ALTER TABLE test_table
ADD COLUMN scaled_gpa INT;

UPDATE test_table
SET scaled_gpa = ((gpa - (SELECT mean
						 FROM (SELECT AVG(gpa) AS mean
							   FROM test_table) AS t1)) / 
						 (SELECT deviation
                          FROM (SELECT STDDEV(gpa) AS deviation
								FROM test_table) AS t2));
                                

ALTER TABLE test_table
ADD COLUMN normalized_gpa DECIMAL(3, 2);


UPDATE test_table
SET normalized_gpa = ((gpa - (SELECT minimum
						 FROM (SELECT MIN(gpa) AS minimum
							   FROM test_table) AS t1)) / 
						 (SELECT deviation
                          FROM (SELECT (MAX(gpa) - MIN(gpa)) AS deviation
								FROM test_table) AS t2));

ALTER TABLE test_table
ADD COLUMN normalized_gre DECIMAL(3, 2);


UPDATE test_table
SET normalized_gre = ((gre - (SELECT minimum
						 FROM (SELECT MIN(gre) AS minimum
							   FROM test_table) AS t1)) / 
						 (SELECT deviation
                          FROM (SELECT (MAX(gre) - MIN(gre)) AS deviation
								FROM test_table) AS t2));
    
ALTER TABLE test_table
ADD COLUMN normalized_sat DECIMAL(3, 2);



UPDATE test_table
SET normalized_sat = ((sat - (SELECT minimum
						 FROM (SELECT MIN(sat) AS minimum
							   FROM test_table) AS t1)) / 
						 (SELECT deviation
                          FROM (SELECT (MAX(sat) - MIN(sat)) AS deviation
								FROM test_table) AS t2));


ALTER TABLE test_table
ADD COLUMN test_score FLOAT;

UPDATE test_table
SET test_score = (normalized_gpa + normalized_gre + normalized_sat);

ALTER TABLE test_table
MODIFY COLUMN Department VARCHAR(64);

UPDATE test_table
SET Department = 
(CONCAT(
		CASE FLOOR(RAND() * 3 + 1)
		WHEN 1 THEN "DEPARTMENT OF "
        WHEN 2 THEN  "DEPT. OF "
        ELSE ""
        END,
        CASE FLOOR(RAND() * 10 + 1)
        WHEN 1 THEN "ECONS"	WHEN 2 THEN "ECONOMICS"
        WHEN 3 THEN "AGRIC"	WHEN 4 THEN "AGRICULTURE"
        WHEN 5 THEN "BIO" 	WHEN 6 THEN "BIOLOGY"
        WHEN 7 THEN "MATH"	WHEN 8 THEN "MATHEMATICS"
        ELSE "PHYSICS"
        END));

UPDATE test_table
SET Department = "BIOLOGY"
WHERE POSITION("BIO" IN DEPARTMENT) > 0;

UPDATE test_table
SET Department = "MATHEMATICS"
WHERE INSTR(DEPARTMENT, "MATH") > 0;

UPDATE test_table
SET Department = "AGRICULTURE"
WHERE POSITION("AGRI" IN Department) > 0;

UPDATE test_table
SET Department = "ECONOMICS"
WHERE POSITION("ECO" IN Department) > 0;

UPDATE test_table
SET Department = "PHYSICS"
WHERE POSITION("PHY" IN Department) > 0;
    

SELECT *
FROM test_table;

WITH trim_stat AS 
	(SELECT AVG(gpa) AS trim_mean, STD(gpa) AS trim_std
     FROM test_table, (SELECT MIN(gpa) AS min_gpa FROM test_table) AS t1,
					  (SELECT MAX(gpa) AS max_gpa FROM test_table) AS t2
	 WHERE gpa > min_gpa OR gpa < max_gpa) 
SELECT gpa
FROM test_table
CROSS JOIN trim_stat
WHERE gpa > (trim_mean - 2*trim_std) OR (gpa < trim_mean + 2*trim_std)
ORDER BY gpa;

SELECT * 
FROM test_table
WHERE SOUNDEX(department) = SOUNDEX("mathematics")