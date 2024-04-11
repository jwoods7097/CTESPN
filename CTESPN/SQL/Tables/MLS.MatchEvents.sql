IF OBJECT_ID(N'MLS.MatchEvents') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchEvents
    (
        MatchEventID INT NOT NULL IDENTITY(1, 1),
        MatchID INT NOT NULL,
        [Time] INT NOT NULL,
        Commentary NVARCHAR(2048) NOT NULL

        CONSTRAINT [PK_MLS_MatchEvents_MatchEventID] PRIMARY KEY CLUSTERED
        (
            MatchEventID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchEvents')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Matches')
            AND fk.[name] = N'FK_MLS_MatchEvents_MLS_Matches'
    )
BEGIN 
    ALTER TABLE MLS.MatchEvents
    ADD CONSTRAINT [FK_MLS_MatchEvents_MLS_Matches] FOREIGN KEY
    (
        MatchID
    )
    REFERENCES MLS.Matches
    (
        MatchID
    )
END;
