CREATE OR ALTER PROCEDURE MLS.GetPlayerMatchStats
    @PlayerID INT,
    @MatchID INT
AS

SELECT OS.Goals, OS.Assists, OS.Offsides, OS.Shots, OS.ShotsOnTarget, GS.Saves,
    IIF(MCP.PlayerTypeID = 4, GS.Fouls, OS.Fouls) Fouls,
    IIF(MCP.PlayerTypeID = 4, GS.YellowCards, OS.YellowCards) YellowCards,
    IIF(MCP.PlayerTypeID = 4, GS.RedCards, OS.RedCards) RedCards
FROM MLS.MatchClubPlayer MCP
    LEFT JOIN MLS.MatchOutfielderStats OS ON OS.MatchClubPlayerID = MCP.MatchClubPlayerID
    LEFT JOIN MLS.MatchGoalkeeperStats GS ON GS.MatchClubPlayerID = MCP.MatchClubPlayerID
WHERE MCP.MatchID = @MatchID AND MCP.PlayerID = @PlayerID
GO

EXEC MLS.GetPlayerMatchStats 184960, 692718
