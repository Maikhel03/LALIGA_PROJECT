SELECT * FROM Laliga_Weeks;


SELECT * FROM Laliga_Ranking;


SELECT * FROM Laliga_Stadiums;


SELECT * FROM Stats_with_Nationalities;


SELECT * FROM team_finance;


SELECT * FROM team_stats;



--



SELECT *
FROM team_stats
WHERE Summary = 'Home' AND Season = '2015/2016';

--Exploring the number of MOTM award accrued by players across the seasons

SELECT Player, Position, MotM, Season 
FROM Stats_with_Nationalities
WHERE Season BETWEEN '2010/2011' AND '2022/2023'
ORDER BY MotM DESC;



SELECT SUM(Yellow_Card) AS Total_Yellow_Cards, Season, Team
FROM team_stats
WHERE Summary = 'Home'
GROUP BY Season, Team
ORDER BY Total_Yellow_Cards DESC;


--How many red cards did home teams receive per season?.
SELECT SUM(DISTINCT Red_Card) AS Total_red_cards, ts.Season
FROM team_stats ts
INNER JOIN Laliga_Ranking lr 
ON ts.Team = lr.Team
WHERE ts.Season BETWEEN '2010/2011' AND '2022/2023'
  AND ts.Summary = 'Home'
GROUP BY ts.Summary, ts.Season
ORDER BY Total_red_cards DESC;




--3. How did Real Madrid's goal contribution break down by position in 2013/14?
--Isolated one of the club's strongest seasons to understand whether goals were driven by forwards alone or distributed across positions.
SELECT Position, SUM(Goals) AS total_goals 
FROM Stats_with_Nationalities
WHERE Team = 'Real Madrid' AND Season = '2013/2014'
GROUP BY Position
ORDER BY total_goals DESC;




--Find the players who have been in the league since the beginning of the timeframe of the dataset till the end.
SELECT Player
FROM Stats_with_Nationalities
WHERE Season BETWEEN '2010/2011' AND '2022/2023'
GROUP BY Player
HAVING COUNT(DISTINCT season) = 13



--How many teams have played in La liga within the timeframe of the dataset?
SELECT COUNT(DISTINCT Team) AS Number_of_Teams
FROM Laliga_Ranking;



-- 5. How many unique stadiums has La Liga seen, and which clubs used them?
--Explored stadium data to capture club relocations and ground changes over the 13-year window.
SELECT COUNT(DISTINCT Stadium) AS Stadiums
FROM Laliga_Stadiums
WHERE Season BETWEEN '2010/2011' AND '2022/2023';


SELECT DISTINCT(Stadium) AS Stadiums, Team
FROM Laliga_Stadiums
WHERE Season BETWEEN '2010/2011' AND '2022/2023'
GROUP BY Team, Stadium, Season;


--Calculate the win percentage of each team across all seasons
WITH WINS AS (
   SELECT Team, SUM(P) AS Total_Games_Played, SUM(W) AS Total_Wins, SUM(L) AS Total_Losses
   FROM Laliga_Ranking
   GROUP BY Team)
SELECT *, ROUND((CAST(Total_Wins AS FLOAT) / Total_Games_Played) * 100, 1) AS Win_Percentage 
FROM WINS
ORDER BY Win_Percentage DESC;



--6. What is the relationship between foreign player count and team performance?
--Joined `team_finance` with `team_stats` to begin exploring how squad internationalisation correlates with results.
SELECT DISTINCT(ts.Season), ts.Team,  Foreigners
FROM team_finance tf
LEFT JOIN team_stats ts 
ON tf.Season = ts.Season
ORDER BY Foreigners DESC



SELECT AVG(CM) AS Average_Height
FROM Stats_with_Nationalities
;

SELECT 
    Team,
    COUNT(DISTINCT Season) AS "Number of seasons"
FROM team_stats
GROUP BY Team;


ALTER TABLE team_stats ADD "Number of seasons" INT;


UPDATE team_stats
SET "Number of seasons" = sub.season_count
FROM (
    SELECT Team, COUNT(DISTINCT Season) AS season_count
    FROM team_stats
    GROUP BY Team
) sub
WHERE team_stats.Team = sub.Team;




