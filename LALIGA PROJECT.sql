SELECT * FROM Laliga_Weeks;


SELECT * FROM Laliga_Ranking;


SELECT * FROM Laliga_Stadiums;


SELECT * FROM Stats_with_Nationalities;


SELECT * FROM team_finance;


SELECT * FROM team_stats;



--

SELECT Player, Position, MotM, Season 
FROM Stats_with_Nationalities
WHERE Season BETWEEN '2010/2011' AND '2022/2023'
ORDER BY MotM DESC;

SELECT *
FROM team_stats
WHERE Summary = 'Home' AND Season = '2015/2016';

SELECT SUM(Yellow_Card) AS Total_Yellow_Cards, Season, Team
FROM team_stats
WHERE Summary = 'Home'
GROUP BY Season, Team
ORDER BY Total_Yellow_Cards DESC;


--Find out how many red cards teams received at home between 2010/2011 and 2015/2016 seasons.
SELECT SUM(DISTINCT Red_Card) Total_red_cards, ts.Season
FROM team_stats ts
INNER JOIN Laliga_Ranking lr 
ON ts.Team = lr.Team
WHERE ts.Season BETWEEN '2010/2011' AND '2015/2016'
  AND ts.Summary = 'Home'
GROUP BY ts.Summary, ts.Season
ORDER BY Total_red_cards DESC;




--Determine the goals scored by position by Real Madrid players in the 2013/2014 season.
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



--How many stadia have we seen in La liga over the years and which team(s) did they belong to?
SELECT COUNT(DISTINCT Stadium) AS Stadiums
FROM Laliga_Stadiums
WHERE Season BETWEEN '2010/2011' AND '2022/2023';


--List all the stadia and the team they belong to.
SELECT DISTINCT(Stadium) AS Stadiums, Team
FROM Laliga_Stadiums
GROUP BY Team, Stadium, Season
HAVING Season BETWEEN '2010/2011' AND '2022/2023';


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




SELECT ts.Team, ts.Season, Foreigners
FROM team_finance tf
RIGHT JOIN team_stats ts 
ON tf.Season = ts.Season

