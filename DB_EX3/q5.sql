WITH member_counts AS (
  SELECT number, party, COUNT(*) AS totalMembers
  FROM memberInKnesset
  NATURAL JOIN members
  GROUP BY number, party
),
female_member_counts AS (
  SELECT number, party, COUNT(*)::float AS femaleMembers
  FROM memberInKnesset
  NATURAL JOIN members
  WHERE gender = 'female'
  GROUP BY number, party
)
SELECT mc.party, mc.number, (fmc.femaleMembers / mc.totalMembers) * 100.0 AS femalePercent
FROM member_counts mc
JOIN female_member_counts fmc ON mc.number = fmc.number AND mc.party = fmc.party
WHERE (fmc.femaleMembers / mc.totalMembers) >= 0.3
ORDER BY mc.party, mc.number;
