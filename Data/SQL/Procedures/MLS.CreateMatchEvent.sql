CREATE OR ALTER PROCEDURE MLS.CreateMatchEvent
    @MatchID INT,
    @Time INT,
    @Commentary NVARCHAR(2048),
    @MatchEventID INT OUTPUT
AS
INSERT MLS.MatchEvent(MatchID, [Time], Commentary)
VALUES(@MatchID, @Time, @Commentary)

SET @MatchEventID = SCOPE_IDENTITY();
GO
