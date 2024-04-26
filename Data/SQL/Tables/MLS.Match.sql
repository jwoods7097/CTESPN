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

IF NOT EXISTS
    (
        SELECT *
        FROM sys.check_constraints cc
        WHERE cc.parent_column_id = OBJECT_ID(N'MLS.Match')
            AND cc.[name] = N'CK_MLS_Match_Location'
    )
BEGIN
    ALTER TABLE MLS.Match
    ADD CONSTRAINT [CK_MLS_Match_Location] CHECK ([Location] <> N'')
END;
