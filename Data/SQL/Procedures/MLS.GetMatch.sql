-- Gets details about a Match from a given MatchID
CREATE OR ALTER PROCEDURE MLS.GetMatch
    @MatchID INT
AS

WITH HomeClub(ClubID, MatchID, [Name], Score, Formation) AS (
    SELECT HC.ClubID, HMC.MatchID, HC.[Name], HMC.Score, HMC.Formation
    FROM MLS.MatchClub HMC
        INNER JOIN MLS.Club HC ON HC.ClubID = HMC.ClubID AND HMC.MatchClubTypeID = 1
),
AwayClub(ClubID, MatchID, [Name], Score, Formation) AS (
    SELECT AC.ClubID, AMC.MatchID, AC.[Name], AMC.Score, AMC.Formation
    FROM MLS.MatchClub AMC
        INNER JOIN MLS.Club AC ON AC.ClubID = AMC.ClubID AND AMC.MatchClubTypeID = 2
)
SELECT HomeClub.ClubID HomeClubID, HomeClub.Name HomeClub, HomeClub.Score HomeScore, HomeClub.Formation HomeFormation, 
    AwayClub.ClubID AwayClubID, AwayClub.[Name] AwayClub, AwayClub.[Score] AwayScore, AwayClub.[Formation] AwayFormation, 
    M.[Location], M.[Date], ISNULL(M.Attendance, 0) Attendance
FROM MLS.[Match] M
    INNER JOIN HomeClub ON HomeClub.MatchID = M.MatchID
    LEFT JOIN AwayClub ON AwayClub.MatchID = M.MatchID
WHERE M.MatchID = @MatchID
GO

EXEC MLS.GetMatch 598135