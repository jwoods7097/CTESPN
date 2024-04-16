DECLARE @MatchClubTypeStaging TABLE (
    MatchClubTypeID INT NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(4) NOT NULL
)

INSERT @MatchClubTypeStaging(MatchClubTypeID, [Name])
VALUES
    (1, 'Home'),
    (2, 'Away');

MERGE MLS.MatchClubType T
USING @MatchClubTypeStaging S ON S.MatchClubTypeID = T.MatchClubTypeID
WHEN MATCHED AND S.[Name] <> T.[Name] THEN
    UPDATE
    SET [Name] = S.[Name]
WHEN NOT MATCHED THEN 
    INSERT(MatchClubTypeID, [Name])
    VALUES(S.MatchClubTypeID, S.[Name]);