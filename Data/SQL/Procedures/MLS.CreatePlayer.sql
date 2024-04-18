CREATE OR ALTER PROCEDURE MLS.CreatePlayer
	@PlayerTypeID INT,
	@Name NVARCHAR(32),
	@PlayerID INT OUTPUT
AS

INSERT MLS.Player(PlayerTypeID, [Name])
VALUES(@PlayerTypeID, @Name);

SET @PlayerID = SCOPE_IDENTITY();
GO