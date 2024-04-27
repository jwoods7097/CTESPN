CREATE OR ALTER PROCEDURE MLS.CreatePlayer
	@PlayerID INT,
	@PlayerTypeID INT,
	@Name NVARCHAR(32),
	@Position NVARCHAR(16)
AS

INSERT MLS.Player(PlayerID, PlayerTypeID, [Name])
VALUES(@PlayerID, @PlayerTypeID, @Name);

IF @PlayerTypeID = 4
INSERT MLS.Goalkeeper(PlayerID, PlayerTypeID)
VALUES(@PlayerID, @PlayerTypeID)

ELSE
INSERT MLS.Outfielder(PlayerID, PlayerTypeID, Position)
VALUES(@PlayerID, @PlayerTypeID, @Position)

GO