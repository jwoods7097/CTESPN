CREATE OR ALTER PROCEDURE MLS.ClubCards
    @StartDate DATE,
    @EndDate DATE
AS
SELECT C.ClubID, C.Name, C.Abbreviation,
    (SUM(MOS.YellowCards) + SUM(MGS.YelloCards)) AS YellowCards,
    (SUM(MOS.RedCards) + SUM(MGS.RedCards)) AS RedCards
FROM MLS.Club C
    INNER JOIN MLS.ClubPlayer CP ON C.ClubID = CP.ClubID
    INNER JOIN MLS.MatchClubPlayer MCP ON MCP.ClubPlayerID = CP.ClubPlayerID AND MCP.PlayerTypeID = MCP.PlayerTypeID AND MCP.ClubID = CP.ClubID
    INNER JOIN MLS.MatchClub MC ON MCP.ClubID = MC.ClubID AND MCP.MatchID = MC.MatchID
    INNER JOIN MLS.Match M ON M.MatchID = MC.MatchID
    INNER JOIN MLS.MatchOutfielderStats MOS ON MCP.MatchClubPlayerID = MOS.MatchClubPlayerID
    INNER JOIN MLS.MatchGoalkeeperStats MGS ON MCP.MatchClubPlayerID = MGS.MatchClubPlayerID
WHERE 
    M.Date BETWEEN @StartDate AND @EndDate
GROUP BY C.ClubID, C.Name, C.Abbreviation
ORDER BY RedCards DESC, YellowCards DESC
GO