IF OBJECT_ID(N'MLS.MatchClubType') IS NULL
BEGIN
	CREATE TABLE MLS.MatchClubType
    (
	    MatchClubTypeID INT NOT NULL,
		[Name] NVARCHAR(4) NOT NULL

		CONSTRAINT [PK_MLS_MatchClubType_MatchClubTypeID] PRIMARY KEY CLUSTERED
		(
		    MatchClubTypeID ASC
		)
	)
END;

IF NOT EXISTS
	(
		SELECT *
		FROM sys.key_constraints kc
		WHERE kc.parent_object_id = OBJECT_ID(N'MLS.MatchClubType')
			AND kc.[name] = N'UK_MLS_MatchClubType_Name'
	)
BEGIN
	ALTER TABLE MLS.MatchClubType
	ADD CONSTRAINT [UK_MLS_MatchClubType_Name] UNIQUE NONCLUSTERED
	(
		[Name] ASC
	)
END;
