CREATE OR ALTER PROCEDURE MLS.RetrieveMatchesWithClubs
AS

SELECT M.MatchID, M.Location, M.Date, M.Attendance, HomeClub.ClubID AS HomeClubID, AwayClub.ClubID AS AwayClubID, HomeClub.Formation AS HomeFormation, AwayClub.Formation AS AwayFormation, HomeClub.Score AS HomeScore, AwayClub.Score AS AwayScore
FROM MLS.Match M
    INNER JOIN MLS.MatchClub HomeClub ON HomeClub.MatchID = M.MatchID AND HomeClub.MatchClubTypeID = 1
    INNER JOIN MLS.MatchClub AwayClub ON AwayClub.MatchID = M.MatchID AND AwayClub.MatchClubTypeID = 2
GO