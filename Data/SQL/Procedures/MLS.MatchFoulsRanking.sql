CREATE OR ALTER PROCEDURE MLS.MatchFoulsRanking
    @StartDate DATE,
    @EndDate DATE
AS
SELECT M.MatchID, M.Date, HomeClub.Name AS HomeClubName, AwayClub.Name AS AwayClubName, SUM(O.Fouls) AS Fouls
FROM 
    MLS.MatchOutfielderStats O 
    INNER JOIN MLS.MatchClubPlayer MCP ON MCP.MatchClubPlayerID = O.MatchClubPlayerID
    INNER JOIN MLS.MatchClub MC ON MCP.MatchID = MC.MatchID AND MCP.ClubID = MC.ClubID
    INNER JOIN MLS.Club HomeClub ON HomeClub.ClubID = MC.ClubID AND MC.MatchClubTypeID = (SELECT MatchClubTypeID FROM MLS.MatchClubType WHERE [Name] = N'Home')
    INNER JOIN MLS.Club AwayClub ON AwayClub.ClubID = MC.ClubID AND MC.MatchClubTypeID = (SELECT MatchClubTypeID FROM MLS.MatchClubType WHERE [Name] = N'Away')
    INNER JOIN MLS.Match M ON M.MatchID = MC.MatchID
WHERE M.Date BETWEEN @StartDate AND @EndDate
GROUP BY M.MatchID, M.Date, HomeClub.Name, AwayClub.Name
ORDER BY Fouls DESC
GO