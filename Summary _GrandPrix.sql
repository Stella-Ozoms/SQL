---From the Master Database,table F1-Stats,is the History of GrandPrix-----

---Span of the  Formula-1 History  --- 
select Distinct([year])
from dbo.[F1-Stats]
order by 1 asc

---Names of all drivers in the history of the grand-prix, 1950-2021---
select  Distinct([Driver's forename] +' '+ ','+ ' '+ [Driver's surname])as DriversInHistory
from dbo.[F1-Stats]
order by 1 asc

---Number  of  drivers in the history of  grand-prix, 1950-2021---
select Count( Distinct([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]))as NumberOfDriversInHistory
from dbo.[F1-Stats]

---Names of all teams in the history of the  grand-prix,1950-2021---
select Distinct([Constructor name])
from dbo.[F1-Stats]
order by 1 asc

---Number  teams that has participated history of the  grand-prix,1950-2021---
select Count(Distinct([Constructor name])) as NumberOfTeamsInHistory
from dbo.[F1-Stats]
order by 1 asc

----The Event that has had  the most Drivers----
select [Year],[Event name],count([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]) as TotalRacersPerEvent
from dbo.[F1-Stats]
group by [Event name],[Year]
order by 3 desc

----Top racer from 1950-1970---
select ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]) as RacersName ,sum(points)as TotalGrandPrixPoints,[status]
from dbo.[F1-Stats]
where ([year] between 1950 and 1970) and( status = 'Finished')
group by ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]),[status]
having sum(points)> 0
order by 2 desc

---Top racer from 1971 -1990---
select ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]) as RacersName ,sum([points])as TotalGrandPrixPoints,[status]
from dbo.[F1-Stats]
where ([year] between 1971 and 1990)  and ( [status] = 'Finished')    
group by ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]),[status]
having sum([points])> 0
order by 2 desc

----Top racer from 1991-2010----
select ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname])as RacersName ,sum([points]) as  TotalGrandPrixPoints,[status]
from dbo.[F1-Stats]
where ([year] between 1991 and 2010) and( [status] = 'Finished')and (fastestLap is not NULL) AND (fastestLapSpeed is not NULL)
     AND  (fastestLapTime is not NULL)
group by ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]),[status]
having sum([points]) > 0
order by 2 desc 

---Top racer from 2011-2021----
select ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]) as RacersName , sum([points]) as TotalGrandPrixPoints,[status]
from dbo.[F1-Stats]
where ([year] between 2011 and 2021) and([status]= 'Finished')and(fastestLap is not NULL) AND (fastestLapSpeed is not NULL)
      AND  (fastestLapTime is not NULL)
group by ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]),[status]
having sum([points]) > 0
order by 2 desc

--- Best Driver  in History,from 1950 to 2021---
select ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]) as RacersName , sum([points]) as TotalEventPoints
from dbo.[F1-Stats]
where ([status] = 'Finished')And (fastestLap is not NULL) AND (fastestLapSpeed is not NULL) AND  (fastestLapTime is not NULL)
group by ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname])
having  sum([points])> 0
order by 2 desc

---Best Team In History----
Select [Constructor name] as Team ,Sum([Points]) as TotalEventPoints
from dbo.[F1-Stats]
where ([status] = 'Finished') and (fastestLap is not NULL) AND (fastestLapSpeed is not NULL) AND  (fastestLapTime is not NULL) 
group by  [Constructor name]
Having Sum([Points])> 0
order by 2 Desc

---Errors in history--
select Distinct[status]
from dbo.[F1-Stats]
where [status] not like '%La%'
order by 1 asc

----Number of Errors ever made By Teams---
select [year],[Event name],[Constructor name]AS Team,Count([status]) as NumberOfErrorsByTeam      
from dbo.[F1-Stats]
where [status] <> 'Finished'
group by  [year],[Constructor name],[Event name]
order by 4 desc

---- Number of Engine Failures by team---
select [Constructor name],COUNT([status]) as EngineFailures
from dbo.[F1-Stats]
where [status] like 'Engine%'
GROUP BY  [Constructor name]
order by 2 DESC

---Number of collision by team---
select [Constructor name],COUNT([status]) as CollisionRate
from dbo.[F1-Stats]
where [status] like 'Collision%'
Group by [Constructor name]
order by 2 desc

---Number of Accidents by team---
select [Constructor name],COUNT([status])as RateOfAccidents
from dbo.[F1-Stats]
where [status]='Accident'
Group by [Constructor name]
order by 2 desc

---Average speed by Team----
select [Constructor name],AVG([fastestLapSpeed]) AS  speedtime
from dbo.[F1-Stats]
where ([status] = 'Finished') 
group by [Constructor name]
Having AVG([fastestLapSpeed]) > 0
order by 2 ASC

---Top Reasons For Unfinished race and Total Number of times it happened in history--
select [status]as  ReasonForUnfinishedRace,Count([status]) as NumberOfReoccurance
from dbo.[F1-Stats]
where ([status] <> 'Finished') and ([status] not like'%Lap%')
group by [status]
order by 2 desc

---Drivers Race Summary---
select ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]) as RacersName,[Driver's nationality], 
        Count([Event name]) as RaceCount,Sum([points]) as OverallPoints
from dbo.[F1-Stats]
group by ([Driver's forename] +' '+ ','+ ' '+ [Driver's surname]),[Driver's nationality]
order by 4 desc


