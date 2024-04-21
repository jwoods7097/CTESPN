CREATE OR ALTER PROCEDURE MLS.CreateClubPlayer
    @PlayerID INT,
    @PlayerTypeID INT,
    @ClubID INT,
    @DateStarted DATE,
    @Name NVARCHAR(32),
    @Position NVARCHAR(16),
    @ClubPlayerID INT OUTPUT
AS
BEGIN
    MERGE MLS.Player AS T
    USING (VALUES (@PlayerID, @PlayerTypeID, @Name)) AS S(PlayerID, PlayerTypeID, Name)
        ON S.PlayerID = T.PlayerID AND S.PlayerTypeID = T.PlayerTypeID
    WHEN NOT MATCHED THEN 
        INSERT (PlayerTypeID, [Name])
        VALUES (S.PlayerTypeID, S.Name)
    OUTPUT INSERTED.PlayerID INTO @OutputTable;

    SELECT TOP 1 @ClubPlayerID = PlayerID FROM @OutputTable;

    IF @PlayerTypeID = 1 OR @PlayerTypeID = 2 OR @PlayerTypeID = 3
    BEGIN
        INSERT INTO MLS.Table1 (PlayerID, ClubID, DateStarted, Position)
        VALUES (@ClubPlayerID, @ClubID, @DateStarted, @Position);
    END
    ELSE IF @PlayerTypeID = 4
    BEGIN
        INSERT INTO MLS.Table2 (PlayerID, ClubID, DateStarted, Position)
        VALUES (@ClubPlayerID, @ClubID, @DateStarted, @Position);
    END

    INSERT INTO MLS.ClubPlayer(PlayerID, PlayerTypeID, ClubID, DateStarted)
    VALUES(@PlayerID, @PlayerTypeID, @ClubID, @DateStarted)

    SET @ClubPlayerID = SCOPE_IDENTITY()
END
GO