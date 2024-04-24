namespace Data.Models
{
    public class MatchesForClub
    {
        public int MatchID { get; }
        public string Formation { get; }
        public int Score { get; }
        public int OpponentScore { get; }
        public MatchClubType HomeOrAway { get; }
        public int OpponentClub { get; }
        public string Location { get; }
        public DateOnly Date { get; }
        public int Attendance { get; }

        public MatchesForClub(int matchID, string location, DateOnly date, int attendance, MatchClubType homeoraway, string formation, int opponentclub, int score, int opponentscore) 
        {
            MatchID = matchID;
            Location = location;
            Date = date;
            Attendance = attendance;
            OpponentClub = opponentclub;
            Formation = formation;
            Score = score;
            OpponentScore = opponentscore;
            HomeOrAway = homeoraway;
        }
    }
}