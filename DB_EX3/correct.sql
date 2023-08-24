SELECT DISTINCT d1.name AS n1, d2.name AS n2
FROM donors d1
JOIN donors d2 ON d1.name < d2.name
WHERE NOT EXISTS (
SELECT cause
FROM (
SELECT cause FROM donors WHERE name = d1.name
EXCEPT
SELECT cause FROM donors WHERE name = d2.name
 ) AS causes
UNION
SELECT cause
FROM (
SELECT cause FROM donors WHERE name = d2.name
EXCEPT
SELECT cause FROM donors WHERE name = d1.name
 ) AS causes
 )
 ORDER BY n1, n2