DECLARE @PlayerTypeStaging TABLE (
    PlayerTypeID INT NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(32) NOT NULL
)

INSERT @PlayerTypeStaging(PlayerTypeID, [Name])
VALUES
    (1, 'Forward'),
    (2, 'Midfielder'),
    (3, 'Defender'),
    (4, 'Goalkeeper');

MERGE MLS.PlayerTypes T
USING @PlayerTypeStaging S ON S.PlayerTypeID = T.PlayerTypeID
WHEN MATCHED AND S.[Name] <> T.[Name] THEN
    UPDATE
    SET [Name] = S.[Name]
WHEN NOT MATCHED THEN 
    INSERT(PlayerTypeID, [Name])
    VALUES(S.PlayerTypeID, S.[Name]);