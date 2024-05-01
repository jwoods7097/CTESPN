CREATE OR ALTER PROCEDURE MLS.GetClubForPlayer
    @PlayerID INT
AS

SELECT C.ClubID, C.[Name], C.[Abbreviation], C.HomeLocation, C.Conference
FROM MLS.ClubPlayer CP 
    INNER JOIN MLS.Club C ON C.ClubID = CP.ClubID
WHERE CP.PlayerID = @PlayerID;
GO

EXEC MLS.GetClubForPlayer 364138