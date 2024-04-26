IF OBJECT_ID(N'MLS.ClubPlayer') IS NULL
BEGIN  
    CREATE TABLE MLS.ClubPlayer
    (
        ClubPlayerID INT NOT NULL IDENTITY(1, 1),
        PlayerID INT NOT NULL,
        PlayerTypeID INT NOT NULL,
        ClubID INT NOT NULL,
        DateStarted DATE NOT NULL,
        DateEnded DATE

        CONSTRAINT [PK_MLS_ClubPlayer_ClubPlayerID] PRIMARY KEY CLUSTERED
        (
            ClubPlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.ClubPlayer')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Player')
            AND fk.[name] = N'FK_MLS_ClubPlayer_MLS_Player'
    )
BEGIN 
    ALTER TABLE MLS.ClubPlayer
    ADD CONSTRAINT [FK_MLS_ClubPlayer_MLS_Player] FOREIGN KEY
    (
        PlayerID,
        PlayerTypeID
    )
    REFERENCES MLS.Player
    (
        PlayerID,
        PlayerTypeID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.ClubPlayer')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Club')
            AND fk.[name] = N'FK_MLS_ClubPlayer_MLS_Club'
    )
BEGIN 
    ALTER TABLE MLS.ClubPlayer
    ADD CONSTRAINT [FK_MLS_ClubPlayer_MLS_Club] FOREIGN KEY
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
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.ClubPlayer')
            AND kc.[name] = N'UK_MLS_ClubPlayer_PlayerIDPlayerTypeIDClubID'
    )
BEGIN
    ALTER TABLE MLS.ClubPlayer
    ADD CONSTRAINT [UK_MLS_ClubPlayer_ClubPlayerIDPlayerTypeIDClubID] UNIQUE NONCLUSTERED
    (
        PlayerID,
        PlayerTypeID,
        ClubID
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.check_constraints cc
        WHERE cc.parent_column_id = OBJECT_ID(N'MLS.ClubPlayer')
            AND cc.[name] = N'CK_MLS_ClubPlayer_Date'
    )
BEGIN
    ALTER TABLE MLS.ClubPlayer
    ADD CONSTRAINT [CK_MLS_ClubPlayer_Date] CHECK (DateEnded > DateStarted)
END;