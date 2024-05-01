CREATE OR ALTER PROCEDURE MLS.RetrievePlayers
AS
SELECT P.PlayerID, P.PlayerTypeID, P.[Name],
    IIF(P.PlayerTypeID = 4, 'Goalkeeper', O.Position) Position
FROM MLS.Player P
    LEFT JOIN MLS.Goalkeeper G ON P.PlayerID = G.PlayerID AND P.PlayerTypeID = G.PlayerTypeID
    LEFT JOIN MLS.Outfielder O ON P.PlayerID = O.PlayerID AND P.PlayerTypeID = O.PlayerTypeID
ORDER BY P.Name ASC
GO

EXEC MLS.RetrievePlayers