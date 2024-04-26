--This procedure returns the number of fouls for each match in a given date range
--This shows how "heated" a match is
--We are using the entire date range for which we have data
CREATE OR ALTER PROCEDURE MLS.MatchFoulsRanking
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    WITH MatchClubPlayersCTE AS (
        SELECT M.MatchID, M.Date,
            (SELECT C.[Name] FROM MLS.Club C WHERE C.ClubID = Home.ClubID) AS HomeClubName, 
            (SELECT C.[Name] FROM MLS.Club C WHERE C.ClubID = Away.ClubID) AS AwayClubName, 
            MCP.MatchClubPlayerID, MCP.PlayerTypeID
        FROM MLS.Match M
        INNER JOIN MLS.MatchClub Home ON M.MatchID = Home.MatchID AND Home.MatchClubTypeID = (SELECT MatchClubTypeID FROM MLS.MatchClubType WHERE [Name] = N'Home')
        INNER JOIN MLS.MatchClub Away ON M.MatchID = Away.MatchID AND Away.MatchClubTypeID = (SELECT MatchClubTypeID FROM MLS.MatchCLubType WHERE [Name] = N'Away')
        INNER JOIN MLS.MatchClubPlayer MCP ON (Home.MatchID = MCP.MatchID AND Home.ClubID = MCP.ClubID) OR (Away.MatchID = MCP.MatchID AND Away.ClubID = MCP.ClubID)
        WHERE M.Date BETWEEN @StartDate AND @EndDate
    )
    SELECT MCP.MatchID, MCP.Date, MCP.HomeClubName, MCP.AwayClubName, SUM(MOS.Fouls) + SUM(MGS.Fouls) AS Fouls
    FROM MatchClubPlayersCTE MCP
    LEFT JOIN MLS.MatchOutfielderStats MOS ON MCP.MatchClubPlayerID = MOS.MatchClubPlayerID AND MCP.PlayerTypeID = MOS.PlayerTypeID
    LEFT JOIN MLS.MatchGoalkeeperStats MGS ON MCP.MatchClubPlayerID = MGS.MatchClubPlayerID AND MCP.PlayerTypeID = MGS.PlayerTypeID
    GROUP BY MCP.MatchID, MCP.Date, MCP.HomeClubName, MCP.AwayClubName
    ORDER BY Fouls DESC
END
GO

EXEC MLS.MatchFoulsRanking '2021-01-01', '2024-12-31'