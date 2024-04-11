IF OBJECT_ID(N'MLS.Matches') IS NULL
BEGIN  
    CREATE TABLE MLS.Matches
    (
        MatchID INT NOT NULL IDENTITY(1, 1),
        HomeClubID INT NOT NULL,
        AwayClubID INT NOT NULL,
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

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.Matches')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Clubs')
            AND fk.[name] = N'FK_MLS_Matches_MLS_HomeClub'
    )
BEGIN 
    ALTER TABLE MLS.Matches
    ADD CONSTRAINT [FK_MLS_Matches_MLS_HomeClub] FOREIGN KEY
    (
        HomeClubID
    )
    REFERENCES MLS.Clubs
    (
        ClubID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.Matches')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.AwayClub')
            AND fk.[name] = N'FK_MLS_Matches_MLS_AwayClub'
    )
BEGIN 
    ALTER TABLE MLS.Matches
    ADD CONSTRAINT [FK_MLS_Matches_MLS_AwayClub] FOREIGN KEY
    (
        AwayClubID
    )
    REFERENCES MLS.Clubs
    (
        ClubID
    )
END;
