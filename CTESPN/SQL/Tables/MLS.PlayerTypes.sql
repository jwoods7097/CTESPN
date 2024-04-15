IF OBJECT_ID(N'MLS.PlayerTypes') IS NULL
BEGIN
	CREATE TABLE MLS.PlayerTypes
    (
	    PlayerTypeID INT NOT NULL,
		[Name] NVARCHAR(32) NOT NULL

		CONSTRAINT [PK_MLS_PlayerTypes_PlayerTypeID] PRIMARY KEY CLUSTERED
		(
		    PlayerTypeID ASC
		)
	)
END;

IF NOT EXISTS
	(
		SELECT *
		FROM sys.key_constraints kc
		WHERE kc.parent_object_id = OBJECT_ID(N'MLS.PlayerTypes')
			AND kc.[name] = N'UK_MLS_PlayerTypes_Name'
	)
BEGIN
	ALTER TABLE MLS.PlayerTypes
	ADD CONSTRAINT [UK_MLS_PlayerTypes_Name] UNIQUE NONCLUSTERED
	(
		[Name] ASC
	)
END;
