CREATE OR ALTER PROCEDURE MLS.TopClubGoalScorers
AS
BEGIN
WITH PlayerRanking AS (
    SELECT P.PlayerID, C.ClubID, P.Name AS PlayerName, C.Name AS ClubName, C.Abbreviation,
        SUM(IIF(MCP.Played = 1, 1, 0)) AS MatchesPlayed,
        SUM(MOS.Goals) AS CareerGoals,
        ROW_NUMBER() OVER(PARTITION BY C.ClubID ORDER BY SUM(MOS.Goals) DESC) AS Ranking
    FROM MLS.Club C
        INNER JOIN MLS.ClubPlayer CP ON C.ClubID = CP.ClubID
        INNER JOIN MLS.Player P ON CP.PlayerID = P.PlayerID AND CP.PlayerTypeID = P.PlayerTypeID
        INNER JOIN MLS.MatchClubPlayer MCP ON MCP.PlayerID = CP.PlayerID AND MCP.PlayerTypeID = MCP.PlayerTypeID AND MCP.ClubID = CP.ClubID
        INNER JOIN MLS.MatchOutfielderStats MOS ON MCP.MatchClubPlayerID = MOS.MatchClubPlayerID
        INNER JOIN MLS.MatchGoalkeeperStats MGS ON MCP.MatchClubPlayerID = MGS.MatchClubPlayerID
    GROUP BY P.PlayerID, C.ClubID, P.Name, C.Name, C.Abbreviation
)
SELECT PlayerID, ClubID, PlayerName, ClubName, Abbreviation, MatchesPlayed, CareerGoals
FROM PlayerRanking
WHERE Ranking <= 3
ORDER BY ClubID, CareerGoals DESC
END
GO