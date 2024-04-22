CREATE OR ALTER PROCEDURE MLS.CreatePlayer
	@PlayerTypeID INT,
	@Name NVARCHAR(32),
	@Position NVARCHAR(16),
	@PlayerID INT OUTPUT
AS

INSERT MLS.Player(PlayerTypeID, [Name])
VALUES(@PlayerTypeID, @Name);

SET @PlayerID = SCOPE_IDENTITY();

IF @PlayerTypeID = 4
INSERT MLS.Goalkeeper(PlayerID, PlayerTypeID)
VALUES(@PlayerID, @PlayerTypeID)

ELSE
INSERT MLS.Outfielder(PlayerID, PlayerTypeID, Position)
VALUES(@PlayerID, @PlayerTypeID, @Position)

GO