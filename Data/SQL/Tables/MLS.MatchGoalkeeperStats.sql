IF OBJECT_ID(N'MLS.MatchGoalkeeperStats') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchGoalkeeperStats
    (
        MatchClubPlayerID INT NOT NULL,
        PlayerTypeID INT NOT NULL,
        Saves INT NOT NULL,
        Fouls INT NOT NULL,
        YellowCards INT NOT NULL,
        RedCards INT NOT NULL

        CONSTRAINT [PK_MLS_MatchGoalkeeperStats_MatchClubPlayerID] PRIMARY KEY CLUSTERED
        (
            MatchClubPlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchGoalkeeperStats')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClubPlayer')
            AND fk.[name] = N'FK_MLS_MatchGoalkeeperStats_MLS_MatchClubPlayer'
    )
BEGIN 
    ALTER TABLE MLS.MatchGoalkeeperStats
    ADD CONSTRAINT [FK_MLS_MatchGoalkeeperStats_MLS_MatchClubPlayer] FOREIGN KEY
    (
        MatchClubPlayerID,
        PlayerTypeID
    )
    REFERENCES MLS.MatchClubPlayer
    (
        MatchClubPlayerID,
        PlayerTypeID
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.check_constraints cc
        WHERE cc.parent_object_id = OBJECT_ID(N'MLS.MatchGoalkeeperStats')
            AND cc.[name] = N'CC_MLS_MatchGoalkeeperStats_PlayerTypeID'
    )
BEGIN
    ALTER TABLE MLS.MatchGoalkeeperStats
    ADD CONSTRAINT [CC_MLS_MatchGoalkeeperStats_PlayerTypeID] CHECK (PlayerTypeID = 4)
END;