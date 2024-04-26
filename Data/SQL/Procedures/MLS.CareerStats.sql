--This procedure returns the career stats for each player (all time)
--Since our application only has data for 2021-2024, this range is our "all time"
--Some cells are null due to our data source not having data on those particular statistics
CREATE OR ALTER PROCEDURE MLS.CareerStats
AS
SELECT P.PlayerID, P.PlayerTypeID, P.[Name], 
    SUM(IIF(MCP.Played = 1, 1, 0)) AS MatchesPlayed,
    SUM(IIF(P.PlayerTypeID <> 4, MOS.Goals, NULL)) AS Goals,
    SUM(IIF(P.PlayerTypeID <> 4, MOS.Assists, NULL)) AS Assists,
    SUM(IIF(P.PlayerTypeID <> 4, MOS.Fouls, MGS.Fouls)) AS Fouls,
    SUM(IIF(P.PlayerTypeID <> 4, MOS.Offsides, NULL)) AS Offsides,
    SUM(IIF(P.PlayerTypeID <> 4, MOS.Shots, NULL)) AS Shots,
    SUM(IIF(P.PlayerTypeID <> 4, MOS.ShotsOnTarget, NULL)) AS ShotsOnTarget,
    SUM(IIF(P.PlayerTypeID = 4, MGS.Saves, NULL)) AS Saves,
    SUM(IIF(P.PlayerTypeID = 4, MGS.YellowCards, MOS.YellowCards)) AS YellowCards,
    SUM(IIF(P.PlayerTypeID = 4, MGS.RedCards, MOS.RedCards)) AS RedCards
FROM MLS.Player P
    INNER JOIN MLS.ClubPlayer CP ON CP.PlayerID = P.PlayerID AND CP.PlayerTypeID = P.PlayerTypeID
    INNER JOIN MLS.MatchClubPlayer MCP ON CP.PlayerID = MCP.PlayerID AND CP.PlayerTypeID = MCP.PlayerTypeID AND CP.ClubID = MCP.ClubID
    LEFT JOIN MLS.MatchOutfielderStats MOS ON MCP.MatchClubPlayerID = MOS.MatchClubPlayerID AND MCP.PlayerTypeID = MOS.PlayerTypeID
    LEFT JOIN MLS.MatchGoalkeeperStats MGS ON MCP.MatchClubPlayerID = MGS.MatchClubPlayerID AND MCP.PlayerTypeID = MGS.PlayerTypeID
GROUP BY P.PlayerID, P.PlayerTypeID, P.[Name]
ORDER BY PlayerID ASC
GO

EXEC MLS.CareerStats