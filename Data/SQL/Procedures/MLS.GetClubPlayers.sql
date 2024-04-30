CREATE OR ALTER PROCEDURE MLS.GetClubPlayers
    @ClubID INT
AS

SELECT P.PlayerID, P.Name, P.PlayerTypeID, CP.DateStarted, CP.DateEnded
FROM MLS.ClubPlayer CP 
    INNER JOIN MLS.Player P ON CP.PlayerID = P.PlayerID AND CP.PlayerTypeID = P.PlayerTypeID
    LEFT JOIN MLS.Outfielder O ON P.PlayerID = O.PlayerID AND P.PlayerTypeID = O.PlayerTypeID
    LEFT JOIN MLS.Goalkeeper G ON P.PlayerID = G.PlayerID AND P.PlayerTypeID = G.PlayerTypeID
WHERE CP.ClubID = @ClubID
ORDER BY P.PlayerTypeID, P.PlayerID
GO

EXEC MLS.GetClubPlayers 1