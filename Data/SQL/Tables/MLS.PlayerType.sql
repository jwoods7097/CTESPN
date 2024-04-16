IF OBJECT_ID(N'MLS.PlayerType') IS NULL
BEGIN
	CREATE TABLE MLS.PlayerType
    (
	    PlayerTypeID INT NOT NULL,
		[Name] NVARCHAR(32) NOT NULL

		CONSTRAINT [PK_MLS_PlayerType_PlayerTypeID] PRIMARY KEY CLUSTERED
		(
		    PlayerTypeID ASC
		)
	)
END;

IF NOT EXISTS
	(
		SELECT *
		FROM sys.key_constraints kc
		WHERE kc.parent_object_id = OBJECT_ID(N'MLS.PlayerType')
			AND kc.[name] = N'UK_MLS_PlayerType_Name'
	)
BEGIN
	ALTER TABLE MLS.PlayerType
	ADD CONSTRAINT [UK_MLS_PlayerType_Name] UNIQUE NONCLUSTERED
	(
		[Name] ASC
	)
END;
