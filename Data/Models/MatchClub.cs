namespace Data.Models
{
    public class MatchClub
    {
        public int MatchClubID { get; }
        public int ClubID { get; }
        public MatchClubType MatchClubTypeID { get; }
        public int MatchID { get; }
        public string Formation { get; }
        public int Score { get; }

        public MatchClub(int matchClubID, int clubID, MatchClubType matchClubTypeID, int matchID, string formation, int score) 
        {
            MatchClubID = matchClubID;
            ClubID = clubID;
            MatchClubTypeID = matchClubTypeID;
            MatchID = matchID;
            Formation = formation;
            Score = score;
        }
    }
}