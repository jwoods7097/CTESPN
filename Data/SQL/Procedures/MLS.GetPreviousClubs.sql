CREATE OR ALTER PROCEDURE MLS.GetPreviousClubs
    @PlayerID INT,
    @ClubID INT
AS

SELECT C.[Name], MIN(M.[Date]) AS FirstMatch, MAX(M.[Date]) AS LastMatch
FROM MLS.MatchClubPlayer MCP 
    INNER JOIN MLS.Club C ON MCP.ClubID = C.ClubID
    INNER JOIN MLS.[Match] M ON M.MatchID = MCP.MatchID
WHERE MCP.PlayerID = @PlayerID AND MCP.ClubID <> @ClubID
GROUP BY C.Name
GO

EXEC MLS.GetPreviousClubs 6746, 6