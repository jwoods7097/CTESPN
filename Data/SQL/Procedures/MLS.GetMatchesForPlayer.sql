CREATE OR ALTER PROCEDURE MLS.GetMatchesForPlayer
    @PlayerID INT,
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
SELECT M.MatchID, HomeClub.[Name] HomeClub, AwayClub.[Name] AwayClub, M.[Date], HomeClub.Score, AwayClub.Score OpponentScore,
    CASE 
        WHEN HomeClub.Score > AwayClub.Score THEN 'Win'
        WHEN HomeClub.Score = AwayClub.Score THEN 'Draw'
        WHEN HomeClub.Score < AwayClub.Score THEN 'Loss'
    END AS MatchOutcome
FROM MLS.MatchClubPlayer MCP
    INNER JOIN MLS.Match M ON M.MatchID = MCP.MatchID
    INNER JOIN HomeClub ON HomeClub.MatchID = M.MatchID
    LEFT JOIN AwayClub ON AwayClub.MatchID = M.MatchID
WHERE MCP.PlayerID = @PlayerID AND MCP.Played = 1 AND M.[Date] BETWEEN @StartDate AND @EndDate
ORDER BY M.[Date] ASC
GO

EXEC MLS.GetMatchesForPlayer 8894, '2021-01-01', '2024-12-31'
