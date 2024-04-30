-- Gets the statistics from a match for a specific player
CREATE OR ALTER PROCEDURE MLS.GetPlayerStatsForMatch
    @PlayerID INT,
    @MatchID INT
AS

SELECT
    IIF(MCP.PlayerTypeID <> 4, MOS.Goals, NULL) AS Goals,
    IIF(MCP.PlayerTypeID <> 4, MOS.Assists, NULL) AS Assists,
    IIF(MCP.PlayerTypeID <> 4, MOS.Fouls, MGS.Fouls) AS Fouls,
    IIF(MCP.PlayerTypeID <> 4, MOS.Offsides, NULL) AS Offsides,
    IIF(MCP.PlayerTypeID <> 4, MOS.Shots, NULL) AS Shots,
    IIF(MCP.PlayerTypeID <> 4, MOS.ShotsOnTarget, NULL) AS ShotsOnTarget,
    IIF(MCP.PlayerTypeID = 4, MGS.Saves, NULL) AS Saves,
    IIF(MCP.PlayerTypeID = 4, MGS.YellowCards, MOS.YellowCards) AS YellowCards,
    IIF(MCP.PlayerTypeID = 4, MGS.RedCards, MOS.RedCards) AS RedCards
FROM  MLS.MatchClubPlayer MCP
    LEFT JOIN MLS.MatchOutfielderStats MOS ON MCP.MatchClubPlayerID = MOS.MatchClubPlayerID AND MCP.PlayerTypeID = MOS.PlayerTypeID
    LEFT JOIN MLS.MatchGoalkeeperStats MGS ON MCP.MatchClubPlayerID = MGS.MatchClubPlayerID AND MCP.PlayerTypeID = MGS.PlayerTypeID
WHERE MCP.PlayerID = @PlayerID AND MCP.MatchID = @MatchID
GO

EXEC MLS.GetPlayerStatsForMatch 136775, 692697