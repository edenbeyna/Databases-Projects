SELECT mk1.number,
       (SELECT COUNT(DISTINCT mk2.party)
        FROM memberInKnesset AS mk2
        WHERE mk2.number = mk1.number) AS partyCount
FROM memberInKnesset AS mk1
GROUP BY mk1.number
ORDER BY mk1.number;
