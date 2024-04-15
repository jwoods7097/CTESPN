IF OBJECT_ID(N'MLS.Matches') IS NULL
BEGIN  
    CREATE TABLE MLS.Matches
    (
        MatchID INT NOT NULL IDENTITY(1, 1),
        [Location] NVARCHAR(64) NOT NULL,
        [Date] DATE NOT NULL,
        Attendance INT NOT NULL,
        HomeFormation NVARCHAR(8) NOT NULL,
        AwayFormation NVARCHAR(8) NOT NULL,
        HomeScore INT NOT NULL,
        AwayScore INT NOT NULL

        CONSTRAINT [PK_MLS_Matches_MatchID] PRIMARY KEY CLUSTERED
        (
            MatchID ASC
        )
    )
END;