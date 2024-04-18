CREATE OR ALTER PROCEDURE MLS.RetrievePlayers
AS

SELECT P.PlayerID, P.PlayerTypeID, P.[Name]
FROM MLS.Player P
GO