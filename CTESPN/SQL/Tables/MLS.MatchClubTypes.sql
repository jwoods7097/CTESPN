IF OBJECT_ID(N'MLS.MatchClubTypes') IS NULL
BEGIN
	CREATE TABLE MLS.MatchClubTypes
    (
	    MatchClubTypeID INT NOT NULL,
		[Name] NVARCHAR(4) NOT NULL

		CONSTRAINT [PK_MLS_MatchClubTypes_MatchClubTypeID] PRIMARY KEY CLUSTERED
		(
		    MatchClubTypeID ASC
		)
	)
END;

IF NOT EXISTS
	(
		SELECT *
		FROM sys.key_constraints kc
		WHERE kc.parent_object_id = OBJECT_ID(N'MLS.MatchClubTypes')
			AND kc.[name] = N'UK_MLS_MatchClubTypes_Name'
	)
BEGIN
	ALTER TABLE MLS.MatchClubTypes
	ADD CONSTRAINT [UK_MLS_MatchClubTypes_Name] UNIQUE NONCLUSTERED
	(
		[Name] ASC
	)
END;
