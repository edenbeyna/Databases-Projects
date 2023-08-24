SELECT number, AVG(startYear - birthYear) AS avgAge
FROM members
NATURAL JOIN memberInKnesset
NATURAL JOIN knessets
GROUP BY number
ORDER BY number;