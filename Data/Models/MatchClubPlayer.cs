namespace Data.Models 
{
    public class MatchClubPlayer
    {
        public int MatchClubPlayerID { get; }
        public int ClubPlayerID { get; }
        public int PlayerTypeID { get; }
        public int MatchID { get; }
        public int ClubID { get; }
        public int? SubstitutedForPlayer { get; }
        public int? SubstitutionTime { get; }

        public MatchClubPlayer(int matchClubPlayerID, int clubPlyerID, int playerTypeID, int matchID, int clubID, int? substitutedForPlayer, int? substitutionTime)
        {
            MatchClubPlayerID = matchClubPlayerID;
            ClubPlayerID = clubPlyerID;
            PlayerTypeID = playerTypeID;
            MatchID = matchID;
            ClubID = clubID;
            SubstitutedForPlayer = substitutedForPlayer;
            SubstitutionTime = substitutionTime;
        }
    }
}