CREATE OR ALTER PROCEDURE MLS.CreateMatch
    @Location NVARCHAR(64),
    @Date DATE,
    @Attendance INT,
    @MatchID INT OUTPUT
AS

INSERT MLS.Match([Location], [Date], Attendance)
VALUES(@Location, @Date, @Attendance)

SET @MatchID = SCOPE_IDENTITY();
GO