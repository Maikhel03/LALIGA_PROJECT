# La Liga Data Analysis (2010/11 – 2022/23)

A multi-season SQL analysis of Spain's top football division, covering performance, discipline, squad composition, and stadium data across 13 seasons. Results visualised in an interactive Power BI dashboard.

---

## Project Overview

As a football fan, I wanted to go beyond watching the game and actually interrogate the data behind it. This project uses a relational database spanning six tables to answer questions about team dominance, player longevity, disciplinary trends, and squad demographics across over a decade of La Liga football.

**Tools used:** SQL (SQL Server) · Power BI · Microsoft Excel

---

## Dataset

The database contains six tables:

| Table | Description |
|---|---|
| `Laliga_Ranking` | Season-by-season league standings (P, W, D, L, GF, GA) |
| `Laliga_Weeks` | Match-week level results |
| `Laliga_Stadiums` | Stadium names and their associated clubs per season |
| `Stats_with_Nationalities` | Individual player stats including goals, Man of the Match awards, nationality, and position |
| `team_stats` | Home/Away breakdowns of team performance including cards |
| `team_finance` | Squad composition data including number of foreign players |

**Coverage:** 2010/11 to 2022/23 seasons

---

## Key Questions Explored

### 1. Which players were ever-present across the entire 13-season dataset?
Identified players who appeared in all 13 distinct seasons — a measure of elite longevity in one of the world's most competitive leagues.

```sql
SELECT Player
FROM Stats_with_Nationalities
WHERE Season BETWEEN '2010/2011' AND '2022/2023'
GROUP BY Player
HAVING COUNT(DISTINCT Season) = 13
```

### 2. Which teams had the highest win percentage across all seasons?
Used a CTE to aggregate total games and wins per team, then computed win percentage to rank teams by sustained performance.

```sql
WITH WINS AS (
    SELECT Team, SUM(P) AS Total_Games_Played, SUM(W) AS Total_Wins
    FROM Laliga_Ranking
    GROUP BY Team
)
SELECT *, ROUND((CAST(Total_Wins AS FLOAT) / Total_Games_Played) * 100, 1) AS Win_Percentage
FROM WINS
ORDER BY Win_Percentage DESC
```

### 3. How did Real Madrid's goal contribution break down by position in 2013/14?
Isolated one of the club's strongest seasons to understand whether goals were driven by forwards alone or distributed across positions.

### 4. Which seasons saw the most home yellow cards — and which teams were the most aggressive?
Filtered home fixtures to find disciplinary patterns across seasons and clubs.

### 5. How many unique stadiums has La Liga seen, and which clubs used them?
Explored stadium data to capture club relocations and ground changes over the 13-year window.

### 6. What is the relationship between foreign player count and team performance?
Joined `team_finance` with `team_stats` to begin exploring how squad internationalisation correlates with results.

---

## Power BI Dashboard

The SQL findings were brought into Power BI for visual storytelling. The dashboard covers:

- Season-by-season ranking trends for top clubs
- Disciplinary heatmaps (yellow and red cards, home vs away)
- Player Man of the Match leaderboard across all seasons
- Win percentage rankings across all teams in the dataset

---

## Key Findings

- **Dominance at the top is extreme** — Real Madrid and Barcelona account for a disproportionate share of wins across the 13 seasons, with win percentages significantly above all other clubs.
- **Home aggression varies sharply by season** — certain seasons show notable spikes in yellow cards at home, suggesting tactical shifts league-wide.
- **Player longevity is rare** — very few players maintained consistent La Liga presence across all 13 seasons, underlining how competitive squad retention is in elite football.
- **Positional goals at Real Madrid (2013/14)** — forwards unsurprisingly led, but the data reveals meaningful contributions from midfield in what was one of the club's most prolific campaigns.

---

## What I Learned

- Writing CTEs to simplify complex aggregations
- Using `HAVING` with `COUNT(DISTINCT ...)` for longitudinal player tracking
- Joining tables with mismatched granularity (season-level vs match-level)
- Translating SQL output into a coherent visual narrative in Power BI

---

## Repository Structure

```
LALIGA_PROJECT/
│
├── LALIGA PROJECT.sql        # All SQL queries with comments
├── Laliga DASHBOARD.pbix     # Power BI dashboard file
├── Laliga DASHBOARD.pdf      # Static export of dashboard
├── archive (4)/              # Source data files
└── README.md
```

---

*This is part of my data analysis portfolio. I'm currently building projects at the intersection of SQL, Python, and Power BI.*
