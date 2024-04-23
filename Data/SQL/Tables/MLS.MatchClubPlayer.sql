IF OBJECT_ID(N'MLS.MatchClubPlayer') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchClubPlayer
    (
        MatchClubPlayerID INT NOT NULL IDENTITY(1, 1),
        ClubPlayerID INT NOT NULL,
        PlayerTypeID INT NOT NULL,
        MatchID INT NOT NULL,
        ClubID INT NOT NULL,
        SubstitutedForPlayer INT,
        SubstitutionTime INT,
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
        ClubPlayerID,
        PlayerTypeID,
        ClubID
    )
    REFERENCES MLS.ClubPlayer
    (
        ClubPlayerID,
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
