IF OBJECT_ID(N'MLS.Match') IS NULL
BEGIN  
    CREATE TABLE MLS.[Match]
    (
        MatchID INT NOT NULL,
        [Location] NVARCHAR(64) NOT NULL,
        [Date] DATE NOT NULL,
        Attendance INT

        CONSTRAINT [PK_MLS_Match_MatchID] PRIMARY KEY CLUSTERED
        (
            MatchID ASC
        )
    )
END;
