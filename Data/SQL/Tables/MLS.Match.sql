IF OBJECT_ID(N'MLS.Match') IS NULL
BEGIN  
    CREATE TABLE MLS.[Match]
    (
        MatchID INT NOT NULL IDENTITY(1, 1),
        [Location] NVARCHAR(64) NOT NULL,
        [Date] DATE NOT NULL,
        Attendance INT NOT NULL

        CONSTRAINT [PK_MLS_Match_MatchID] PRIMARY KEY CLUSTERED
        (
            MatchID ASC
        )
    )
END;
