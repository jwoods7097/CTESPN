--This procedure returns the number of red and yellow cards for each club in a given date range
--This shows how aggressive a club is during matches
--We are using the entire date range for which we have data
CREATE OR ALTER PROCEDURE MLS.ClubCards
    @StartDate DATE,
    @EndDate DATE
AS
SELECT C.ClubID, C.Name, C.Abbreviation,
    (SUM(MOS.YellowCards) + SUM(MGS.YellowCards)) AS YellowCards,
    (SUM(MOS.RedCards) + SUM(MGS.RedCards)) AS RedCards
FROM MLS.Club C
    INNER JOIN MLS.ClubPlayer CP ON C.ClubID = CP.ClubID
    INNER JOIN MLS.MatchClubPlayer MCP ON MCP.PlayerID = CP.PlayerID AND MCP.PlayerTypeID = MCP.PlayerTypeID AND MCP.ClubID = CP.ClubID
    INNER JOIN MLS.MatchClub MC ON MCP.ClubID = MC.ClubID AND MCP.MatchID = MC.MatchID
    INNER JOIN MLS.Match M ON M.MatchID = MC.MatchID
    LEFT JOIN MLS.MatchOutfielderStats MOS ON MCP.MatchClubPlayerID = MOS.MatchClubPlayerID AND MCP.PlayerTypeID = MOS.PlayerTypeID
    LEFT JOIN MLS.MatchGoalkeeperStats MGS ON MCP.MatchClubPlayerID = MGS.MatchClubPlayerID AND MCP.PlayerTypeID = MGS.PlayerTypeID
WHERE 
    M.Date BETWEEN @StartDate AND @EndDate
GROUP BY C.ClubID, C.Name, C.Abbreviation
ORDER BY RedCards DESC, YellowCards DESC
GO

EXEC MLS.ClubCards '2021-01-01', '2024-12-31'