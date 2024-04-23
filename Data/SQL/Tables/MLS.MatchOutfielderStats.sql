IF OBJECT_ID(N'MLS.MatchOutfielderStats') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchOutfielderStats
    (
        MatchClubPlayerID INT NOT NULL,
        MinutesPlayed INT NOT NULL,
        PosessionTime INT NOT NULL,
        CornerKicks INT NOT NULL,
        Goals INT NOT NULL,
        Fouls INT NOT NULL,
        Offsides INT NOT NULL,
        YellowCards INT NOT NULL,
        RedCards INT NOT NULL

        CONSTRAINT [PK_MLS_MatchOutfielderStats_MatchClubPlayerID] PRIMARY KEY CLUSTERED
        (
            MatchClubPlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchOutfielderStats')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.MatchClubPlayer')
            AND fk.[name] = N'FK_MLS_MatchOutfielderStats_MLS_MatchClubPlayer'
    )
BEGIN 
    ALTER TABLE MLS.MatchOutfielderStats
    ADD CONSTRAINT [FK_MLS_MatchOutfielderStats_MLS_MatchClubPlayer] FOREIGN KEY
    (
        MatchClubPlayerID
    )
    REFERENCES MLS.MatchClubPlayer
    (
        MatchClubPlayerID
    )
END;
