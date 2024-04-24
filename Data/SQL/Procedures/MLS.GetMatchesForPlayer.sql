CREATE OR ALTER PROCEDURE MLS.GetMatchesForPlayer
    @PlayerID INT
AS

SELECT M.MatchID, M.Location, M.Date, M.Attendance, 
    IIF(HomeClub.ClubID = @ClubID, HomeClub.MatchClubTypeID, AwayClub.MatchClubTypeID) AS HomeOrAway
    IIF(HomeClub.ClubID = @ClubID, HomeClub.Formation, AwayClub.Formation) AS Formation,
    IIF(HomeClub.ClubID = @ClubID, AwayClub.ClubID, HomeClub.ClubID) AS OpponentClub,
    IIF(HomeClub.ClubID = @ClubID, HomeClub.Score, AwayClub.Score) AS Score,
    IIF(HomeClub.ClubID = @ClubID, AwayClub.Score, HomeClub.Score) AS OpponentScore
FROM MLS.Match M
    INNER JOIN MLS.MatchClub HomeClub ON HomeClub.MatchID = M.MatchID AND HomeClub.MatchClubTypeID = 1
    INNER JOIN MLS.MatchClub AwayClub ON AwayClub.MatchID = M.MatchID AND AwayClub.MatchClubTypeID = 2
WHERE HomeClub.ClubID = @ClubID OR AwayClub.ClubID = @ClubID
GO