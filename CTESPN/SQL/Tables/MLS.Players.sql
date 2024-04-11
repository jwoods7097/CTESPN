IF OBJECT_ID(N'MLS.Players') IS NULL
BEGIN
    CREATE TABLE MLS.Players
    (
        PlayerID INT NOT NULL IDENTITY(1, 1),
        PlayerTypeID INT NOT NULL,
        [Name] NVARCHAR(32) NOT NULL

        CONSTRAINT [PK_MLS_Players_PlayerID] PRIMARY KEY CLUSTERED
        (
            PlayerID ASC
        )
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.Players')
            AND kc.[name] = N'UK_MLS_Players_PlayerIDPlayerTypeID'
    )
BEGIN
    ALTER TABLE MLS.Players
    ADD CONSTRAINT [UK_MLS_PlayerIDPlayerTypeID] UNIQUE NONCLUSTERED
    (
        PlayerID,
        PlayerTypeID
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.Players')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.PlayerTypes')
            AND fk.[name] = N'FK_MLS_Players_MLS_PlayerTypes'
    )
BEGIN 
    ALTER TABLE MLS.Players
    ADD CONSTRAINT [FK_MLS_Players_MLS_PlayerTypes] FOREIGN KEY
    (
        PlayerTypeID
    )
    REFERENCES MLS.PlayerTypes
    (
        PlayerTypeID
    )
END;
