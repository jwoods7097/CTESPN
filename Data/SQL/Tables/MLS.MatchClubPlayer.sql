IF OBJECT_ID(N'MLS.MatchClubPlayer') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchClubPlayer
    (
        MatchClubPlayerID INT NOT NULL,
        PlayerID INT NOT NULL,
        PlayerTypeID INT NOT NULL,
        MatchID INT NOT NULL,
        ClubID INT NOT NULL,
        SubstitutedForPlayer INT,
        SubstitutionTime NVARCHAR(16),
        Played BIT NOT NULL

        CONSTRAINT [PK_MLS_MatchClubPlayer_MatchClubPlayerID] PRIMARY KEY CLUSTERED
        (
            MatchClubPlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubPlayer')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.ClubPlayer')
            AND fk.[name] = N'FK_MLS_MatchClubPlayer_MLS_ClubPlayer'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubPlayer
    ADD CONSTRAINT [FK_MLS_MatchClubPlayer_MLS_ClubPlayer] FOREIGN KEY
    (
        PlayerID,
        PlayerTypeID,
        ClubID
    )
    REFERENCES MLS.ClubPlayer
    (
        PlayerID,
        PlayerTypeID,
        ClubID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubPlayer')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClub')
            AND fk.[name] = N'FK_MLS_MatchClubPlayer_MLS_MatchClub'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubPlayer
    ADD CONSTRAINT [FK_MLS_MatchClubPlayer_MLS_MatchClub] FOREIGN KEY
    (
        MatchID,
        ClubID
    )
    REFERENCES MLS.MatchClub
    (
        MatchID,
        ClubID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubPlayer')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClubPlayer')
            AND fk.[name] = N'FK_MLS_MatchClubPlayer_MLS_MatchClubPlayer'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubPlayer
    ADD CONSTRAINT [FK_MLS_MatchClubPlayer_MLS_MatchClubPlayer] FOREIGN KEY
    (
        SubstitutedForPlayer
    )
    REFERENCES MLS.MatchClubPlayer
    (
        MatchClubPlayerID
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.MatchClubPlayer')
            AND kc.[name] = N'UK_MLS_MatchClubPlayer_MatchClubPlayerIDPlayerTypeID'
    )
BEGIN
    ALTER TABLE MLS.MatchClubPlayer
    ADD CONSTRAINT [UK_MLS_MatchClubPlayer_MatchClubPlayerIDPlayerTypeID] UNIQUE NONCLUSTERED
    (
        MatchClubPlayerID,
        PlayerTypeID
    )
END;