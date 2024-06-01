-- This is a project where the goal is to compare the NBA's scoring from 2012-13 season through the 2021-22 season.


--Select All of the Data from the Regular Season Dataset that we are going to use (2012-13 season through 2021-22)

Select *
From [Regular Season];

--Select All of the Data from the Playoff Dataset that we are going to use

Select *
From [Playoffs];


-- Looking at the players with the most Regular Season Scoring Titles 

Select Player, Count('Player') " Amount of times that player won scoring title"
From [Regular Season]
Where Rank=1
Group by PLAYER
Order by 2 Desc;


-- Looking at the players that led Playoffs in scoring

Select Player, Count('Player') " Amount of times player led the playoffs in scoring"
From Playoffs
Where Rank=1
Group by PLAYER
Order by 2 Desc;


--Looking for players that were top 5 in both regular season scoring and playoff scoring in the same season

Select rs.Rank, pl.Rank, rs.Player, pl.Year
From [Regular Season] rs
Inner Join Playoffs pl
On rs.player=pl.player
Where rs.Rank<5 and pl.Rank<5
Group by rs.Rank,pl.Rank, rs.Player,pl.Year
Order by pl.Year asc;


-- Breaking down scorers by tiers with Case statements

Select rs.Rank "Regular Season Rank", pl.Rank "Playoff Rank", rs.Player, pl.Year,
Case when rs.rank <5 and pl.rank <5 Then 'Elite Scorer this year'
When rs.rank<10 and pl.rank<10 Then 'Good scorer this year'
When rs.rank<50 and pl.rank<50 Then 'Above average scorer this year'
Else 'Below Average Scorer this year' End as "Scoring tier"
From [Regular Season] rs
Inner Join Playoffs pl
On rs.player=pl.player
Group by rs.Rank, pl.Rank, rs.Player, pl.Year
Order by pl.Year, rs.Rank asc, pl.Rank asc



--Finding out which teams had the most efficient scorers through the timespan

Select rs.team as "Team Name", Avg(cast(rs.eff as int)) As "Average Efficiency Rating"
From [Regular Season] rs
Inner Join Playoffs pl
on rs.player=pl.player
Where rs.Rank<100 and pl.Rank<100
Group by rs.team
Order by "Average Efficiency Rating" desc
