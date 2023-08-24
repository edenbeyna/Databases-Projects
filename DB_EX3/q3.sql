SELECT DISTINCT members.name
FROM members
JOIN (
  SELECT memberInKnesset.uid
  FROM memberInKnesset
  GROUP BY memberInKnesset.uid
  HAVING COUNT(DISTINCT memberInKnesset.party) = 1
     AND COUNT(DISTINCT memberInKnesset.number) >= 5
) AS subquery ON members.uid = subquery.uid
ORDER BY members.name;
