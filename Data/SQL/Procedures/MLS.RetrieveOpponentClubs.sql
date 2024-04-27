CREATE OR ALTER PROCEDURE MLS.RetrieveOpponentClubsWithClubID
    @ClubID INT
AS

SELECT C.ClubID, C.[Name], C.Abbreviation, C.HomeLocation, C.Conference
FROM MLS.Club C
WHERE C.ClubID <> @ClubID
GO

CREATE OR ALTER PROCEDURE MLS.RetrieveOpponentClubsWithPlayerID
    @PlayerID INT
AS
WITH PlayerCTE(ClubID) AS (
    SELECT CP.ClubID
    FROM MLS.ClubPlayer CP
    WHERE CP.PlayerID = @PlayerID
)
SELECT C.ClubID, C.[Name], C.Abbreviation, C.HomeLocation, C.Conference
    FROM MLS.Club C
    INNER JOIN PlayerCTE PCTE ON C.ClubID <> PCTE.ClubID;
GO

EXEC MLS.RetrieveOpponentClubsWithPlayerID 240783