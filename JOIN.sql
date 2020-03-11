--Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT matchid, player
FROM goal 
WHERE teamid = 'GER'

--Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
FROM game
WHERE id=1012

--Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT b.player, b.teamid, a.stadium, a.mdate
FROM game a JOIN goal b ON a.id=b.matchid
WHERE teamid='GER'

--Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT b.team1, b.team2, a.player
FROM goal a
JOIN game b ON a.matchid=b.id
WHERE a.player LIKE 'Mario%'

--Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT a.player, a.teamid, b.coach, a.gtime
FROM goal a
JOIN eteam b ON  a.teamid=b.id
WHERE gtime<=10

--List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT a.mdate, b.teamname
FROM game a
JOIN eteam b ON a.team1=b.id
WHERE b.coach='Fernando Santos'

--List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT a.player
FROM goal a
JOIN game b ON b.id=a.matchid
WHERE b.stadium='National Stadium, Warsaw'

--Instead show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
FROM game JOIN goal ON matchid = id 
WHERE (team1='GER' OR team2='GER') AND teamid <>'GER'

--Show teamname and the total number of goals scored.

SELECT teamname, count(gtime)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname

--Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(gtime)
FROM game
JOIN goal ON id=matchid
GROUP BY stadium

--For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid,mdate, COUNT(gtime)
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY team1, team2
ORDER BY matchid

--For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(teamid)
FROM game
JOIN goal ON id=matchid
WHERE (team1='GER' OR team2='GER') AND teamid='GER'
GROUP BY mdate
ORDER BY matchid

--List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.

SELECT mdate,team1,SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game JOIN goal ON matchid = id
GROUP BY mdate, team1
ORDER BY mdate, matchid, team1, team2