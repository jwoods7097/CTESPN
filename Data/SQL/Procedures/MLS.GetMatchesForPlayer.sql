CREATE OR ALTER PROCEDURE MLS.GetMatchesForPlayer
    @PlayerID INT
AS

SELECT C.ClubID, C.Name AS ClubName, M.MatchID, MC.Formation, MC.Score, 
FROM MLS.Player P 
    INNER JOIN MLS.ClubPlayer CP ON P.PlayerID = CP.PlayerID AND P.PlayerTypeID = CP.PlayerTypeID
    INNER JOIN MLS.Club C ON C.ClubID = CP.ClubID
    INNER JOIN MLS.MatchClub MC ON C.ClubID = MC.ClubID
    INNER JOIN MLS.Match M ON M.MatchID = MC.MatchID

WHERE HomeClub.ClubID = @ClubID OR AwayClub.ClubID = @ClubID
GO