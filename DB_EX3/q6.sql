WITH RECURSIVE member_paths AS (
  SELECT m.uid, m.name, 0 AS distance
  FROM members m
  WHERE m.name = 'Menachem Begin'

  UNION

  SELECT m2.uid, m2.name, mp.distance + 1
  FROM members m1
  JOIN memberInKnesset mk1 ON m1.uid = mk1.uid
  JOIN memberInKnesset mk2 ON mk1.number = mk2.number AND mk1.party = mk2.party
  JOIN members m2 ON mk2.uid = m2.uid
  JOIN member_paths mp ON m1.uid = mp.uid
  WHERE mp.distance < 3
)
SELECT DISTINCT m.name
FROM members m
WHERE m.uid NOT IN (
  SELECT mp.uid
  FROM member_paths mp
)
ORDER BY m.name;
