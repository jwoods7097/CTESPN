CREATE OR ALTER PROCEDURE MLS.CareerStats
AS
SELECT P.PlayerID, P.PlayerTypeID, P.[Name], SUM(MCP.Played) AS MatchesPlayed,
    IIF(P.PlayerID = 4, )
FROM MLS.Player P
    INNER JOIN MLS.ClubPlayer CP ON CP.PlayerID = P.PlayerID AND CP.PlayerTypeID = P.PlayerTypeID
    INNER JOIN MLS.MatchClubPlayer MCP ON CP.ClubPlayerID = MCP.ClubPlyerID AND CP.PlayerTypeID = MCP.PlayerTypeID AND CP.ClubID = MCP.ClubID
    INNER JOIN MLS.MatchOutfielderStats MOS ON MCP.MatchClubPlayerID = MOS.MatchClubPlayerID
    INNER JOIN MLS.MatchGoalkeeperStats MGS ON MCP.MatchClubPlayerID = MDS.MatchClubPlayerID
GROUP BY P.PlayerID, P.PlayerTypeID, P.[Name]
ORDER BY PlayerID ASC
GO