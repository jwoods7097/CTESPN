DECLARE @ClubStaging TABLE (
    [Name] NVARCHAR(64) NOT NULL,
    Abbreviation NVARCHAR(8) NOT NULL,
    HomeLocation NVARCHAR(64) NOT NULL,
    Conference NVARCHAR(16) NOT NULL
)

INSERT @ClubStaging([Name], Abbreviation, HomeLocation, Conference)
VALUES
    ('Atlanta United FC', 'ATL', 'Atlanta, Georgia, USA', 'Eastern'),
    ('Austin FC', 'ATX', 'Austin, Texas, USA', 'Western'),
    ('CF Montréal', 'MTL', 'Montreal, Canada', 'Eastern'),
    ('Charlotte FC', 'CLT', 'Charlotte, North Carolina, USA', 'Eastern'),
    ('Chicago Fire FC', 'CHI', 'Chicago, Illinois, USA', 'Eastern'),
    ('Colorado Rapids', 'COL', 'Commerce City, Colorado, USA', 'Western'),
    ('Columbus Crew', 'CLB', 'Columbus, Ohio, USA', 'Eastern'),
    ('D.C. United', 'DC', 'Washington, District of Columbia, USA', 'Eastern'),
    ('FC Cincinatti', 'CIN', 'Cincinatti, Ohio, USA', 'Eastern'),
    ('FC Dallas', 'DAL', 'Frisco, Texas, USA', 'Western'),
    ('Houston Dynamo FC', 'HOU', 'Houston, Texas, USA', 'Western'),
    ('Inter Miami CF', 'MIA', 'Fort Lauderdale, Florida, USA', 'Eastern'),
    ('LA Galaxy', 'LA', 'Carson, California, USA', 'Western'),
    ('LAFC', 'LAFC', 'Los Angeles, California, USA', 'Western'),
    ('Minnesota United FC', 'MIN', 'Saint Paul, Minnesota, USA', 'Western'),
    ('Nashville SC', 'NSH', 'Nashville, Tennessee, USA', 'Eastern'),
    ('New England Revolution', 'NE', 'Foxborough, Massachusetts, USA', 'Eastern'),
    ('New York City FC', 'NYC', 'New York City, USA', 'Eastern'),
    ('New York Red Bulls', 'NY', 'Harrison, New Jersey, USA', 'Eastern'),
    ('Orlando City FC', 'ORL', 'Orlando, Florida, USA', 'Eastern'),
    ('Philadelphia Union', 'PHI', 'Chester, Pennsylvania, USA', 'Eastern'),
    ('Portland Timbers', 'POR', 'Portland, Oregon, USA', 'Western'),
    ('Real Salt Lake', 'RSL', 'Sandy, Utah, USA', 'Western'),
    ('San Jose Earthquakes', 'SJ', 'San Jose, California, USA', 'Western'),
    ('Seattle Sounders', 'SEA', 'Seattle, Washington, USA', 'Western'),
    ('Sporting Kansas City', 'SKC', 'Kansas City, Kansas, USA', 'Western'),
    ('St. Louis CITY SC', 'STL', 'St. Louis, Missouri, USA', 'Western'),
    ('Toronto FC', 'TOR', 'Toronto, Canada', 'Eastern'),
    ('Vancouver Whitecaps', 'VAN', 'Vancouver, Canada', 'Western')
;

MERGE MLS.Club C
USING @ClubStaging S ON S.Abbreviation = C.Abbreviation
WHEN MATCHED AND (
        S.[Name] <> C.[Name] OR
        S.Abbreviation <> C.Abbreviation OR
        S.HomeLocation <> C.HomeLocation OR
        S.Conference <> C.Conference
    ) THEN
    UPDATE
    SET 
        [Name] = C.[Name],
        Abbreviation = C.Abbreviation,
        HomeLocation = C.HomeLocation,
        Conference = C.Conference
WHEN NOT MATCHED THEN 
    INSERT([Name], Abbreviation, HomeLocation, Conference)
    VALUES(S.[Name], S.Abbreviation, S.HomeLocation, S.Conference);