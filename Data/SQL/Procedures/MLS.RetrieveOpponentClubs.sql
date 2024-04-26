CREATE OR ALTER PROCEDURE MLS.RetrieveOpponentClubs
    @ClubID INT
AS

SELECT C.ClubID, C.[Name], C.Abbreviation, C.HomeLocation, C.Conference
FROM MLS.Club C
WHERE C.ClubID <> @ClubID
GO

EXEC MLS.RetrieveOpponentClubs 26