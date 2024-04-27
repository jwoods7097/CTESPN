CREATE OR ALTER PROCEDURE MLS.GetMatchesForClub
    @ClubID INT,
    @StartDate DATE,
    @EndDate DATE
AS

WITH HomeClub(ClubID, [Name], Score, MatchID) AS (
    SELECT HC.ClubID, HC.[Name], HMC.Score, HMC.MatchID
    FROM MLS.MatchClub HMC
        INNER JOIN MLS.Club HC ON HC.ClubID = HMC.ClubID AND HMC.MatchClubTypeID = 1
),
AwayClub(ClubID, [Name], Score, MatchID) AS (
    SELECT AC.ClubID, AC.[Name], AMC.Score, AMC.MatchID
    FROM MLS.MatchClub AMC
        INNER JOIN MLS.Club AC ON AC.ClubID = AMC.ClubID AND AMC.MatchClubTypeID = 2
)
SELECT HomeClub.Name HomeClub, AwayClub.Name AwayClub, M.Date, HomeClub.Score, AwayClub.Score,
    CASE 
        WHEN HomeClub.Score > AwayClub.Score THEN 'Win'
        WHEN HomeClub.Score = AwayClub.Score THEN 'Draw'
        WHEN HomeClub.Score < AwayClub.Score THEN 'Loss'
    END AS MatchOutcome
FROM MLS.Match M
    INNER JOIN HomeClub ON HomeClub.MatchID = M.MatchID
    LEFT JOIN AwayClub ON AwayClub.MatchID = M.MatchID
WHERE (HomeClub.ClubID = @ClubID OR AwayClub.ClubID = @ClubID) AND M.[Date] BETWEEN @StartDate AND @EndDate
GO

EXEC MLS.GetMatchesForClub 1, '2021-01-01', '2024-12-31'
