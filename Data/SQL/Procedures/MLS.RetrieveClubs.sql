CREATE OR ALTER PROCEDURE MLS.RetrieveClubs
AS

SELECT C.ClubID, C.[Name], C.Abbreviation, C.HomeLocation, C.Conference
FROM MLS.Club C
GO

EXEC MLS.RetrieveClubs