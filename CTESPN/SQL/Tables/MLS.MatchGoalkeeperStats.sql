IF OBJECT_ID(N'MLS.MatchGoalkeeperStats') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchGoalkeeperStats
    (
        MatchClubPlayerID INT NOT NULL IDENTITY(1, 1),
        MinutesPlayed INT NOT NULL,
        Saves INT NOT NULL,
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
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClubPlayers')
            AND fk.[name] = N'FK_MLS_MatchGoalkeeperStats_MLS_MatchClubPlayers'
    )
BEGIN 
    ALTER TABLE MLS.MatchGoalkeeperStats
    ADD CONSTRAINT [FK_MLS_MatchGoalkeeperStats_MLS_MatchClubPlayers] FOREIGN KEY
    (
        MatchClubPlayerID
    )
    REFERENCES MLS.MatchClubPlayers
    (
        MatchClubPlayerID
    )
END;
