CREATE OR ALTER PROCEDURE MLS.GetMatchesForPlayer
    @PlayerID INT
AS

SELECT P.[Name], C.ClubID, C.[Name] AS ClubName, M.MatchID, M.[Date], M.[Location], MC.Formation, MC.Score, MCP.PlayerID 
FROM MLS.Player P 
    INNER JOIN MLS.ClubPlayer CP ON P.PlayerID = CP.PlayerID AND P.PlayerTypeID = CP.PlayerTypeID
    INNER JOIN MLS.Club C ON C.ClubID = CP.ClubID
    INNER JOIN MLS.MatchClub MC ON C.ClubID = MC.ClubID
    INNER JOIN MLS.Match M ON M.MatchID = MC.MatchID
    INNER JOIN MLS.MatchClubPlayer MCP ON CP.PlayerID = MCP.PlayerID AND CP.PlayerTypeID = MCP.PlayerTypeID AND CP.ClubID = MCP.ClubID
WHERE MCP.Played = 1 AND MCP.PlayerID = @PlayerID
GO

EXEC MLS.GetMatchesForPlayer 45843