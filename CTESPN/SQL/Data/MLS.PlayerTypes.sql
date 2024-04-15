DECLARE @PlayerTypesStaging TABLE (
    PlayerTypeID INT NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(32) NOT NULL
)

INSERT @PlayerTypesStaging(PlayerTypeID, [Name])
VALUES
    (1, 'Forward'),
    (2, 'Midfielder'),
    (3, 'Defender'),
    (4, 'Goalkeeper');

MERGE MLS.PlayerTypes T
USING @PlayerTypesStaging S ON S.PlayerTypeID = T.PlayerTypeID
WHEN MATCHED AND S.[Name] <> T.[Name] THEN
    UPDATE
    SET [Name] = S.[Name]
WHEN NOT MATCHED THEN 
    INSERT(PlayerTypeID, [Name])
    VALUES(S.PlayerTypeID, S.[Name]);