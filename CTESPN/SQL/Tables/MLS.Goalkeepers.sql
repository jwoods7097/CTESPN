IF OBJECT_ID(N'MLS.Goalkeepers') IS NULL
BEGIN  
    CREATE TABLE MLS.Goalkeepers
    (
        PlayerID INT NOT NULL IDENTITY(1, 1),
        PlayerTypeID INT NOT NULL

        CONSTRAINT [PK_MLS_Goalkeepers_PlayerID] PRIMARY KEY CLUSTERED
        (
            PlayerID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.Goalkeepers')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Players')
            AND fk.[name] = N'FK_MLS_Goalkeepers_MLS_Players'
    )
BEGIN 
    ALTER TABLE MLS.Goalkeepers
    ADD CONSTRAINT [FK_MLS_Goalkeepers_MLS_Players] FOREIGN KEY
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