IF OBJECT_ID(N'MLS.MatchEvent') IS NULL
BEGIN  
    CREATE TABLE MLS.MatchEvent
    (
        MatchEventID INT NOT NULL IDENTITY(1, 1),
        MatchID INT NOT NULL,
        [Time] NVARCHAR(16),
        Commentary NVARCHAR(2048) NOT NULL

        CONSTRAINT [PK_MLS_MatchEvent_MatchEventID] PRIMARY KEY CLUSTERED
        (
            MatchEventID ASC
        )
    )
END;

IF NOT EXISTS   
    (
        SELECT * 
        FROM sys.foreign_keys fk
        WHERE fk.parent_object_id = OBJECT_ID(N'MLS.MatchEvent')
            AND fk.referenced_object_id = OBJECT_ID(N'MLS.Match')
            AND fk.[name] = N'FK_MLS_MatchEvent_MLS_Match'
    )
BEGIN 
    ALTER TABLE MLS.MatchEvent
    ADD CONSTRAINT [FK_MLS_MatchEvent_MLS_Match] FOREIGN KEY
    (
        MatchID
    )
    REFERENCES MLS.Match
    (
        MatchID
    )
END;