IF OBJECT_ID(N'MLS.Clubs') IS NULL
BEGIN  
    CREATE TABLE MLS.Clubs
    (
        ClubID INT NOT NULL IDENTITY(1, 1),
        [Name] NVARCHAR(64) NOT NULL,
        Abbreviation NVARCHAR(8) NOT NULL,
        HomeLocation NVARCHAR(64) NOT NULL,
        Conference NVARCHAR(16) NOT NULL

        CONSTRAINT [PK_MLS_Clubs_ClubID] PRIMARY KEY CLUSTERED
        (
            ClubID ASC
        )
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.Clubs')
            AND kc.[name] = N'UK_MLS_Clubs_Name'
    )
BEGIN
    ALTER TABLE MLS.Clubs
    ADD CONSTRAINT [UK_MLS_Clubs_Name] UNIQUE NONCLUSTERED
    (
        [Name]
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.Clubs')
            AND kc.[name] = N'UK_MLS_Clubs_Abbreviation'
    )
BEGIN
    ALTER TABLE MLS.Clubs
    ADD CONSTRAINT [UK_MLS_Clubs_Abbreviation] UNIQUE NONCLUSTERED
    (
        Abbreviation
    )
END;