CREATE OR ALTER PROCEDURE MLS.RetrievePlayers
AS
SELECT P.PlayerID, P.PlayerTypeID, P.[Name],
    CASE 
        WHEN P.PlayerTypeID = 4 THEN NULL
        ELSE O.Position
    END AS Position
FROM MLS.Player P
    LEFT JOIN MLS.Goalkeeper G ON P.PlayerID = G.PlayerID AND P.PlayerTypeID = G.PlayerTypeID
    LEFT JOIN MLS.Outfielder O ON P.PlayerID = O.PlayerID AND P.PlayerTypeID = O.PlayerTypeID
GO