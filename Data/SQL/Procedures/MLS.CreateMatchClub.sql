CREATE OR ALTER PROCEDURE MLS.CreateMatchClub
    @ClubID INT,
    @MatchClubTypeID INT,
    @MatchID INT,
    @Formation NVARCHAR(8),
    @Score INT

INSERT MLS.Match([Location], [Date], Attendance)
VALUES(@Location, @Date, @Attendance)

SET @MatchID = SCOPE_IDENTITY();
GO
