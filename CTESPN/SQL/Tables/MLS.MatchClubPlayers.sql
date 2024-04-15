IF OBJECT_ID(N'MLS.MatchClubPlayers') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchClubPlayers
    (
        MatchClubPlayerID INT NOT NULL IDENTITY(1, 1),
        ClubPlayerID INT NOT NULL,
        PlayerTypeID INT NOT NULL,
        MatchID INT NOT NULL,
        ClubID INT NOT NULL,
        SubstitutedForPlayer INT,
        SubstitutionTime INT

        CONSTRAINT [PK_MLS_MatchClubPlayers_MatchClubPlayerID] PRIMARY KEY CLUSTERED
        (
            MatchClubPlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubPlayers')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.ClubPlayers')
            AND fk.[name] = N'FK_MLS_MatchClubPlayers_MLS_ClubPlayers'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubPlayers
    ADD CONSTRAINT [FK_MLS_MatchClubPlayers_MLS_ClubPlayers] FOREIGN KEY
    (
        ClubPlayerID,
        PlayerTypeID,
        ClubID
    )
    REFERENCES MLS.ClubPlayers
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
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubPlayers')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClubs')
            AND fk.[name] = N'FK_MLS_MatchClubPlayers_MLS_MatchClubs'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubPlayers
    ADD CONSTRAINT [FK_MLS_MatchClubPlayers_MLS_MatchClubs] FOREIGN KEY
    (
        MatchID,
        ClubID
    )
    REFERENCES MLS.MatchClubs
    (
        MatchID,
        ClubID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchClubPlayers')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClubPlayers')
            AND fk.[name] = N'FK_MLS_MatchClubPlayers_MLS_MatchClubPlayers'
    )
BEGIN 
    ALTER TABLE MLS.MatchClubPlayers
    ADD CONSTRAINT [FK_MLS_MatchClubPlayers_MLS_MatchClubPlayers] FOREIGN KEY
    (
        SubstitutedForPlayer
    )
    REFERENCES MLS.MatchClubPlayers
    (
        MatchClubPlayerID
    )
END;
