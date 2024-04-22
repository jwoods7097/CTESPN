--Only do this after a player is created using the outputted PlayerID
CREATE OR ALTER PROCEDURE MLS.CreateClubPlayer
    @PlayerID INT,
    @PlayerTypeID INT,
    @ClubID INT,
    @DateStarted DATE,
    @ClubPlayerID INT OUTPUT
AS
BEGIN
    INSERT INTO MLS.ClubPlayer(PlayerID, PlayerTypeID, ClubID, DateStarted)
    VALUES(@PlayerID, @PlayerTypeID, @ClubID, @DateStarted)

    SET @ClubPlayerID = SCOPE_IDENTITY()
END
GO