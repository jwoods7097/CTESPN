CREATE OR ALTER PROCEDURE MLS.GetPreviousClubs
    @PlayerID INT,
    @ClubID INT
AS

SELECT C.ClubID, C.[Name], C.Abbreviation, C.HomeLocation, C.Conference
FROM MLS.ClubPlayer CP 
    INNER JOIN MLS.Club C ON CP.ClubID = C.ClubID
WHERE CP.PlayerID = @PlayerID AND CP.ClubID <> @ClubID
GO

EXEC MLS.GetPreviousClubs 6746, 6