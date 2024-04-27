CREATE OR ALTER PROCEDURE MLS.RetrieveClubPlayers
    @ClubID INT
AS
    SELECT 
        CP.ClubPlayerID,
        CP.PlayerID, 
        CP.PlayerTypeID, 
        P.Name,
        CP.ClubID, 
        CP.DateStarted, 
        CP.DateEnded,
        CASE 
            WHEN CP.PlayerTypeID = 4 THEN 'Goalkeeper'
            ELSE O.Position
        END AS Position
    FROM 
        MLS.ClubPlayer CP
    LEFT JOIN 
        MLS.Player P ON CP.PlayerID = P.PlayerID
    LEFT JOIN 
        MLS.Goalkeeper G ON CP.PlayerID = G.PlayerID AND CP.PlayerTypeID = G.PlayerTypeID
    LEFT JOIN 
        MLS.Outfielder O ON CP.PlayerID = O.PlayerID AND CP.PlayerTypeID = O.PlayerTypeID
    WHERE 
        CP.ClubID = @ClubID
    GO