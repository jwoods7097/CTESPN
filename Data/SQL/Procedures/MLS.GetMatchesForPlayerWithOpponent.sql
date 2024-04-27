CREATE OR ALTER PROCEDURE MLS.GetMatchesForPlayerWithOpponent
    @PlayerID INT,
    @OpponentClubID INT,
    @StartDate DATE,
    @EndDate DATE
AS

SELECT P.[Name], C.ClubID, C.[Name] AS ClubName, 
    (
        SELECT C.[Name]
        FROM MLS.Club C 
        WHERE C.ClubID = Opp.ClubID
    ) AS OpponentClubName,
    IIF(MC.MatchClubTypeID = 1, 1, 2) AS HomeOrAway,
    M.MatchID, M.[Date], M.[Location], MC.Formation, MC.Score, OPP.Score AS OpponentScore,
    CASE
        WHEN MC.Score > OPP.Score THEN 'Win'
        WHEN MC.Score < OPP.Score THEN 'Loss'
        ELSE 'Draw'
    END AS MatchOutcome,
    ISNULL(M.Attendance, 0) AS Attendance
FROM MLS.Player P 
    INNER JOIN MLS.ClubPlayer CP ON P.PlayerID = CP.PlayerID AND P.PlayerTypeID = CP.PlayerTypeID
    INNER JOIN MLS.Club C ON C.ClubID = CP.ClubID
    INNER JOIN MLS.MatchClubPlayer MCP ON CP.PlayerID = MCP.PlayerID AND CP.PlayerTypeID = MCP.PlayerTypeID AND CP.ClubID = MCP.ClubID
    INNER JOIN MLS.MatchClub MC ON MCP.ClubID = MC.ClubID AND MCP.MatchID = MC.MatchID
    INNER JOIN MLS.MatchClub OPP ON OPP.MatchID = MC.MatchID AND OPP.ClubID <> MC.MatchID
    INNER JOIN MLS.Match M ON M.MatchID = MC.MatchID
WHERE P.PlayerID = @PlayerID AND MCP.Played = 1 AND OPP.ClubID <> MC.ClubID AND M.[Date] BETWEEN @StartDate AND @EndDate AND OPP.ClubID = @OpponentClubID
ORDER BY M.[Date] DESC
GO

EXEC MLS.GetMatchesForPlayerWithOpponent 5289, 4, '2021-01-01', '2024-12-31'