IF OBJECT_ID(N'MLS.Goalkeeper') IS NULL
BEGIN  
    CREATE TABLE MLS.Goalkeeper
    (
        PlayerID INT NOT NULL IDENTITY(1, 1),
        PlayerTypeID INT NOT NULL

        CONSTRAINT [PK_MLS_Goalkeeper_PlayerID] PRIMARY KEY CLUSTERED
        (
            PlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.Goalkeeper')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Player')
            AND fk.[name] = N'FK_MLS_Goalkeeper_MLS_Player'
    )
BEGIN 
    ALTER TABLE MLS.Goalkeeper
    ADD CONSTRAINT [FK_MLS_Goalkeeper_MLS_Player] FOREIGN KEY
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