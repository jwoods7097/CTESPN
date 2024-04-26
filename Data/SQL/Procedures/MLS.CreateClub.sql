CREATE OR ALTER PROCEDURE MLS.CreateClub
    @Name NVARCHAR(64),
    @Abbreviation NVARCHAR(8),
    @Location NVARCHAR(64),
    @Conference NVARCHAR(16),
    @ClubID INT OUTPUT
AS
BEGIN
    INSERT INTO MLS.Club([Name], Abbreviation, HomeLocation, Conference)
    VALUES(@Name, @Abbreviation, @Location, @Conference)

    SET @ClubID = SCOPE_IDENTITY()
END
GO