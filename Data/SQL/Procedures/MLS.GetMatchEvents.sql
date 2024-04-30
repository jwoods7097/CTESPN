-- Get Match Commentary
CREATE OR ALTER PROCEDURE MLS.GetMatchEvents
    @MatchID INT
AS

SELECT ME.[Time], ME.Commentary
FROM MLS.MatchEvent ME
WHERE ME.MatchID = @MatchID
ORDER BY ME.MatchEventID DESC
GO

EXEC MLS.GetMatchEvents 692697