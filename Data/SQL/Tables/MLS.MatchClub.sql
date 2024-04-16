IF OBJECT_ID(N'MLS.MatchClub') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchClub
    (
        MatchClubID INT NOT NULL IDENTITY(1, 1),
        ClubID INT NOT NULL,
        MatchClubTypeID INT NOT NULL,
        MatchID INT NOT NULL,
        Formation NVARCHAR(16) NOT NULL,
        Score INT NOT NULL

        CONSTRAINT [PK_MLS_MatchClub_MatchClubID] PRIMARY KEY CLUSTERED
        (
            MatchClubID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClub')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Club')
            AND fk.[name] = N'FK_MLS_MatchClub_MLS_Club'
    )
BEGIN 
    ALTER TABLE MLS.MatchClub
    ADD CONSTRAINT [FK_MLS_MatchClub_MLS_Club] FOREIGN KEY
    (
        ClubID
    )
    REFERENCES MLS.Club
    (
        ClubID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClub')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClubType')
            AND fk.[name] = N'FK_MLS_MatchClub_MLS_MatchClubType'
    )
BEGIN 
    ALTER TABLE MLS.MatchClub
    ADD CONSTRAINT [FK_MLS_MatchClub_MLS_MatchClubType] FOREIGN KEY
    (
        MatchClubTypeID
    )
    REFERENCES MLS.MatchClubType
    (
        MatchCLubTypeID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClub')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Match')
            AND fk.[name] = N'FK_MLS_MatchClub_MLS_Match'
    )
BEGIN 
    ALTER TABLE MLS.MatchClub
    ADD CONSTRAINT [FK_MLS_MatchClub_MLS_Match] FOREIGN KEY
    (
        MatchID
    )
    REFERENCES MLS.Match
    (
        MatchID
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.MatchClub')
            AND kc.[name] = N'UK_MLS_MatchClub_ClubIDMatchID'
    )
BEGIN
    ALTER TABLE MLS.MatchClub
    ADD CONSTRAINT [UK_MLS_MatchClub_ClubIDMatchID] UNIQUE NONCLUSTERED
    (
        MatchID,
        ClubID
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.MatchClub')
            AND kc.[name] = N'UK_MLS_MatchClub_MatchClubTypeIDMatchID'
    )
BEGIN
    ALTER TABLE MLS.MatchClub
    ADD CONSTRAINT [UK_MLS_MatchClub_MatchClubTypeIDMatchID] UNIQUE NONCLUSTERED
    (
        MatchClubTypeID,
        MatchID
    )
END;