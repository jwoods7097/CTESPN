-- Gets all players that were in a match
CREATE OR ALTER PROCEDURE MLS.GetPlayersInMatchFromClub
    @MatchID INT,
    @ClubID INT
AS

SELECT P.Name, PT.Name Position, C.Name Club, ISNULL(MCP.SubstitutionTime, '') SubstitutionTime,
    ISNULL((
        SELECT SP.Name
        FROM MLS.Player SP
        WHERE SP.PlayerID = MCP.SubstitutedForPlayer
    ), '') Substitute,
    IIF(MCP.Played = 1, 'Yes', 'No') AS Played
FROM MLS.MatchClubPlayer MCP
    INNER JOIN MLS.Player P ON P.PlayerID = MCP.PlayerID 
    INNER JOIN MLS.Club C ON C.ClubID = MCP.ClubID
    INNER JOIN MLS.PlayerType PT ON MCP.PlayerTypeID = PT.PlayerTypeID
WHERE MCP.MatchID = @MatchID AND MCP.ClubID = @ClubID
ORDER BY Played DESC, MCP.PlayerTypeID ASC
GO

EXEC MLS.GetPlayersInMatchFromClub 692697, 3