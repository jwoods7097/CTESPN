--Do this after a Match is created
CREATE OR ALTER PROCEDURE MLS.CreateMatchClub
    @ClubID INT,
    @MatchClubTypeID INT,
    @MatchID INT,
    @Formation NVARCHAR(8),
    @Score INT,
    @MatchClubID INT OUTPUT
AS
INSERT MLS.MatchClub(ClubID, MatchClubTypeID, MatchID, Formation, Score)
VALUES(@ClubID, @MatchClubTypeID, @MatchID, @Formation, @Score)

SET @MatchClubID = SCOPE_IDENTITY();
GO
