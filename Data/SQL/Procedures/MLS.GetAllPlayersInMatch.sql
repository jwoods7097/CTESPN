-- Gets all players that were in a match
CREATE OR ALTER PROCEDURE MLS.GetAllPlayersInMatch
    @MatchID INT
AS

SELECT P.PlayerID, P.Name, PT.Name Position, C.Name Club, ISNULL(MCP.SubstitutionTime, '') SubstitutionTime,
    ISNULL((
        SELECT TOP(1) SP.Name
        FROM MLS.Player SP
        WHERE SP.PlayerID = MCP.SubstitutedForPlayer
    ), '') Substitute,
    IIF(MCP.Played = 1, 'Yes', 'No') AS Played
FROM MLS.MatchClubPlayer MCP
    INNER JOIN MLS.MatchClub MC ON MC.ClubID = MCP.ClubID AND MC.MatchID = MCP.MatchID
    INNER JOIN MLS.Club C ON C.ClubID = MC.ClubID
    INNER JOIN MLS.Player P ON P.PlayerID = MCP.PlayerID 
    INNER JOIN MLS.PlayerType PT ON MCP.PlayerTypeID = PT.PlayerTypeID
WHERE MCP.MatchID = @MatchID
ORDER BY MC.MatchClubTypeID ASC, Played DESC, PT.PlayerTypeID ASC
GO

EXEC MLS.GetAllPlayersInMatch 623516