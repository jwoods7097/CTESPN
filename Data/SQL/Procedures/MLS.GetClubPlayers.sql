CREATE OR ALTER PROCEDURE MLS.GetClubPlayers
    @ClubID INT
AS

SELECT P.Name, P.PlayerTypeID,
    (
        SELECT TOP(1) M.Date
        FROM MLS.[Match] M
            INNER JOIN MLS.MatchClubPlayer MCP ON MCP.MatchID = M.MatchID
        WHERE MCP.PlayerID = P.PlayerID AND MCP.ClubID = @ClubID
        ORDER BY M.[Date] ASC
    ) FirstMatch,
    (
        SELECT TOP(1) M.Date
        FROM MLS.[Match] M
            INNER JOIN MLS.MatchClubPlayer MCP ON MCP.MatchID = M.MatchID
        WHERE MCP.PlayerID = P.PlayerID AND MCP.ClubID = @ClubID
        ORDER BY M.[Date] DESC
    ) LatestMatch
FROM MLS.ClubPlayer CP 
    INNER JOIN MLS.Player P ON CP.PlayerID = P.PlayerID AND CP.PlayerTypeID = P.PlayerTypeID
    LEFT JOIN MLS.Outfielder O ON P.PlayerID = O.PlayerID AND P.PlayerTypeID = O.PlayerTypeID
    LEFT JOIN MLS.Goalkeeper G ON P.PlayerID = G.PlayerID AND P.PlayerTypeID = G.PlayerTypeID
WHERE CP.ClubID = @ClubID
ORDER BY P.PlayerTypeID, P.PlayerID
GO

EXEC MLS.GetClubPlayers 1