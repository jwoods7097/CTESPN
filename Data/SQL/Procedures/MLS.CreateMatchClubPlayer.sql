--Do this after MatchClub and ClubPlayer are created
CREATE OR ALTER PROCEDURE MLS.CreateMatchClubPlayer
    @ClubPlayerID INT,
    @PlayerTypeID INT,
    @MatchID INT,
    @ClubID INT,
    @SubstitutedForPlayer INT,
    @SubstitutionTime INT,
    @Played BIT,
    @Goals INT,
    @Assists INT,
    @Offsides INT,
    @Shots INT,
    @ShotsOnTarget INT,
    @Fouls INT,
    @YellowCards INT,
    @RedCards INT,
    @Saves INT,
    @MatchClubPlayerID INT OUTPUT
AS
INSERT MLS.MatchClubPlayer(ClubPlayerID, PlayerTypeID, MatchID, ClubID, SubstitutedForPlayer, SubstitutionTime, Played)
VALUES(@ClubPlayerID, @PlayerTypeID, @MatchID, @ClubID, @SubstitutedForPlayer, @SubstitutionTime, @Played)

SET @MatchClubPlayerID = SCOPE_IDENTITY();

IF @PlayerTypeID = 4
INSERT MLS.MatchGoalkeeperStats(MatchClubPlayerID, Saves, Fouls, YellowCards, RedCards)
VALUES(@MatchClubPlayerID, @Saves, @Fouls, @YellowCards, @RedCards)

ELSE
INSERT MLS.MatchOutfielderStats(MatchClubPlayerID, Goals, Assists, Fouls, Offsides, Shots, ShotsOnTarget, YellowCards, RedCards)
VALUES(@MatchClubPlayerID, @Goals, @Assists, @Fouls, @Offsides, @Shots, @ShotsOnTarget, @YellowCards, @RedCards)

GO
