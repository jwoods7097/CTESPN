IF OBJECT_ID(N'MLS.MatchClubs') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchClubs
    (
        MatchClubID INT NOT NULL IDENTITY(1, 1),
        ClubID INT NOT NULL,
        MatchClubTypeID INT NOT NULL,
        MatchID INT NOT NULL,

        CONSTRAINT [PK_MLS_MatchClubs_MatchClubID] PRIMARY KEY CLUSTERED
        (
            MatchClubID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubs')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Clubs')
            AND fk.[name] = N'FK_MLS_MatchClubs_MLS_Clubs'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubs
    ADD CONSTRAINT [FK_MLS_MatchClubs_MLS_Clubs] FOREIGN KEY
    (
        ClubID
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
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubs')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClubTypes')
            AND fk.[name] = N'FK_MLS_MatchClubs_MLS_MatchClubTypes'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubs
    ADD CONSTRAINT [FK_MLS_MatchClubs_MLS_MatchClubTypes] FOREIGN KEY
    (
        MatchClubTypeID
    )
    REFERENCES MLS.MatchClubTypes
    (
        MatchCLubTypeID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubs')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Matches')
            AND fk.[name] = N'FK_MLS_MatchClubs_MLS_Matches'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubs
    ADD CONSTRAINT [FK_MLS_MatchClubs_MLS_Matches] FOREIGN KEY
    (
        MatchID
    )
    REFERENCES MLS.Matches
    (
        MatchID
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.MatchClubs')
            AND kc.[name] = N'UK_MLS_MatchClubs_ClubIDMatchID'
    )
BEGIN
    ALTER TABLE MLS.MatchClubs
    ADD CONSTRAINT [UK_MLS_MatchClubs_ClubIDMatchID] UNIQUE NONCLUSTERED
    (
        MatchID,
        ClubID
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.MatchClubs')
            AND kc.[name] = N'UK_MLS_MatchClubs_MatchClubTypeIDMatchID'
    )
BEGIN
    ALTER TABLE MLS.MatchClubs
    ADD CONSTRAINT [UK_MLS_MatchClubs_MatchClubTypeIDMatchID] UNIQUE NONCLUSTERED
    (
        MatchClubTypeID,
        MatchID
    )
END;