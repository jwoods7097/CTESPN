IF OBJECT_ID(N'MLS.Outfielder') IS NULL
BEGIN  
    CREATE TABLE MLS.Outfielder
    (
        PlayerID INT NOT NULL,
        PlayerTypeID INT NOT NULL,
        Position NVARCHAR(16) NOT NULL

        CONSTRAINT [PK_MLS_Outfielder_PlayerID] PRIMARY KEY CLUSTERED
        (
            PlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.Outfielder')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Player')
            AND fk.[name] = N'FK_MLS_Outfielder_MLS_Player'
    )
BEGIN 
    ALTER TABLE MLS.Outfielder
    ADD CONSTRAINT [FK_MLS_Outfielder_MLS_Player] FOREIGN KEY
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