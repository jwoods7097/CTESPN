namespace Data.Models
{
    public class MatchesForClub
    {
        private int MatchID;

        public string HomeClub { get; }

        public string AwayClub { get; }

        public DateOnly Date { get; }

        public int Score { get; }

        public int OpponentScore { get; }
        
        public string MatchOutcome { get; }

        public MatchesForClub(int matchID, string homeClub, string awayClub, DateTime date, int score, int opponentScore, string matchOutcome)
        {
            MatchID = matchID;
            HomeClub = homeClub;
            AwayClub = awayClub;
            Date = DateOnly.FromDateTime(date);
            Score = score;
            OpponentScore = opponentScore;
            MatchOutcome = matchOutcome;
        }

        public int GetMatchID()
        {
            return MatchID;
        }
    }
}