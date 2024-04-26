IF OBJECT_ID(N'MLS.Player') IS NULL
BEGIN
    CREATE TABLE MLS.Player
    (
        PlayerID INT NOT NULL,
        PlayerTypeID INT NOT NULL,
        [Name] NVARCHAR(32) COLLATE Latin1_General_CI_AS NOT NULL 

        CONSTRAINT [PK_MLS_Player_PlayerID] PRIMARY KEY CLUSTERED
        (
            PlayerID ASC,
            PlayerTypeID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.Player')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.PlayerType')
            AND fk.[name] = N'FK_MLS_Player_MLS_PlayerType'
    )
BEGIN 
    ALTER TABLE MLS.Player
    ADD CONSTRAINT [FK_MLS_Player_MLS_PlayerType] FOREIGN KEY
    (
        PlayerTypeID
    )
    REFERENCES MLS.PlayerType
    (
        PlayerTypeID
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.check_constraints cc
        WHERE cc.parent_column_id = OBJECT_ID(N'MLS.Player')
            AND cc.[name] = N'CK_MLS_Player_Name'
    )
BEGIN
    ALTER TABLE MLS.Player
    ADD CONSTRAINT [CK_MLS_Player_Name] CHECK ([Name] <> N'')
END;
