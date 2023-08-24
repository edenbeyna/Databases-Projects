 SELECT number, party, COUNT(distinct uid) as memberCount
 FROM memberInKnesset m1
 GROUP BY m1.number , m1.party
 HAVING count(DISTINCT uid) >= ALL
(SELECT COUNT(uid)
 FROM memberInKnesset m2
 WHERE m1.number = m2.number
 GROUP BY m2.number, m2.party
 )
ORDER BY(number, party)