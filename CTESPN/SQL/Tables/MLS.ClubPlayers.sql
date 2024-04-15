IF OBJECT_ID(N'MLS.ClubPlayers') IS NULL
BEGIN  
    CREATE TABLE MLS.ClubPlayers
    (
        ClubPlayerID INT NOT NULL IDENTITY(1, 1),
        PlayerID INT NOT NULL,
        PlayerTypeID INT NOT NULL,
        ClubID INT NOT NULL,
        DateStarted DATE NOT NULL,
        DateEnded DATE

        CONSTRAINT [PK_MLS_ClubPlayers_ClubPlayerID] PRIMARY KEY CLUSTERED
        (
            ClubPlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.ClubPlayers')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Players')
            AND fk.[name] = N'FK_MLS_ClubPlayers_MLS_Players'
    )
BEGIN 
    ALTER TABLE MLS.ClubPlayers
    ADD CONSTRAINT [FK_MLS_ClubPlayers_MLS_Players] FOREIGN KEY
    (
        PlayerID,
        PlayerTypeID
    )
    REFERENCES MLS.Players
    (
        PlayerID,
        PlayerTypeID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.ClubPlayers')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Clubs')
            AND fk.[name] = N'FK_MLS_ClubPlayers_MLS_Clubs'
    )
BEGIN 
    ALTER TABLE MLS.ClubPlayers
    ADD CONSTRAINT [FK_MLS_ClubPlayers_MLS_Clubs] FOREIGN KEY
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
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.ClubPlayers')
            AND kc.[name] = N'UK_MLS_ClubPlayers_ClubPlayerIDPlayerTypeIDClubID'
    )
BEGIN
    ALTER TABLE MLS.ClubPlayers
    ADD CONSTRAINT [UK_MLS_ClubPlayers_ClubPlayerIDPlayerTypeIDClubID] UNIQUE NONCLUSTERED
    (
        ClubPlayerID,
        PlayerTypeID,
        ClubID
    )
END;