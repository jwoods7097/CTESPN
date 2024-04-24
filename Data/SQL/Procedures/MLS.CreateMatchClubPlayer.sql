--Do this after MatchClub and ClubPlayer are created
CREATE OR ALTER PROCEDURE MLS.CreateMatchClubPlayer
    @ClubPlayerID INT,
    @PlayerTypeID INT,
    @MatchID INT,
    @ClubID INT,
    @SubstitutedForPlayer INT,
    @SubstitutionTime INT,
    @Played BIT,
    @MinutesPlayed INT,
    @PosessionTime INT,
    @CornerKicks INT,
    @Goals INT,
    @Fouls INT,
    @Offsides INT,
    @YellowCards INT,
    @RedCards INT,
    @Saves INT,
    @MatchClubPlayerID INT OUTPUT
AS
INSERT MLS.MatchClubPlayer(ClubPlayerID, PlayerTypeID, MatchID, ClubID, SubstitutedForPlayer, SubstitutionTime, Played)
VALUES(@ClubPlayerID, @PlayerTypeID, @MatchID, @ClubID, @SubstitutedForPlayer, @SubstitutionTime, @Played)

SET @MatchClubPlayerID = SCOPE_IDENTITY();

IF @PlayerTypeID = 4
INSERT MLS.MatchGoalkeeperStats(MatchClubPlayerID, MinutesPlayed, Saves, YellowCards, RedCards)
VALUES(@MatchClubPlayerID, @MinutesPlayed, @Saves, @YellowCards, @RedCards)

ELSE
INSERT MLS.MatchOutfielderStats(MatchClubPlayerID, MinutesPlayed, PosessionTime, CornerKicks, Goals, Fouls, Offsides, YellowCards, RedCards)
VALUES(@MatchClubPlayerID, @MinutesPlayed, @PosessionTime, @CornerKicks, @Goals, @Fouls, @Offsides, @YellowCards, @RedCards)

GO
