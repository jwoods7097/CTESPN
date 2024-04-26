IF OBJECT_ID(N'MLS.Club') IS NULL
BEGIN  
    CREATE TABLE MLS.Club
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
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.Club')
            AND kc.[name] = N'UK_MLS_Clubs_Name'
    )
BEGIN
    ALTER TABLE MLS.Club
    ADD CONSTRAINT [UK_MLS_Clubs_Name] UNIQUE NONCLUSTERED
    (
        [Name]
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.key_constraints kc
        WHERE kc.parent_object_id = OBJECT_ID(N'MLS.Club')
            AND kc.[name] = N'UK_MLS_Clubs_Abbreviation'
    )
BEGIN
    ALTER TABLE MLS.Club
    ADD CONSTRAINT [UK_MLS_Clubs_Abbreviation] UNIQUE NONCLUSTERED
    (
        Abbreviation
    )
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.check_constraints cc
        WHERE cc.parent_column_id = OBJECT_ID(N'MLS.Club')
            AND cc.[name] = N'CK_MLS_Club_Name'
    )
BEGIN
    ALTER TABLE MLS.Club
    ADD CONSTRAINT [CK_MLS_Club_Name] CHECK ([Name] <> N'')
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.check_constraints cc
        WHERE cc.parent_column_id = OBJECT_ID(N'MLS.Club')
            AND cc.[name] = N'CK_MLS_Club_Abbreviation'
    )
BEGIN
    ALTER TABLE MLS.Club
    ADD CONSTRAINT [CK_MLS_Club_Abbreviation] CHECK (Abbreviation <> N'')
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.check_constraints cc
        WHERE cc.parent_column_id = OBJECT_ID(N'MLS.Club')
            AND cc.[name] = N'CK_MLS_Club_HomeLocation'
    )
BEGIN
    ALTER TABLE MLS.Club
    ADD CONSTRAINT [CK_MLS_Club_HomeLocation] CHECK (HomeLocation <> N'')
END;

IF NOT EXISTS
    (
        SELECT *
        FROM sys.check_constraints cc
        WHERE cc.parent_column_id = OBJECT_ID(N'MLS.Club')
            AND cc.[name] = N'CK_MLS_Club_Conference'
    )
BEGIN
    ALTER TABLE MLS.Club
    ADD CONSTRAINT [CK_MLS_Club_Conference] CHECK (Conference <> N'')
END;