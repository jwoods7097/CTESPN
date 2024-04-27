namespace Data.Models
{
    public class MatchesForClub
    {
        public string HomeClub { get; }

        public string AwayClub { get; }

        public DateTime Date { get; }

        public int Score { get; }

        public int OpponentScore { get; }
        
        public string MatchOutcome { get; }

        public MatchesForClub(string homeClub, string awayClub, DateTime date, int score, int opponentScore, string matchOutcome)
        {
            HomeClub = homeClub;
            AwayClub = awayClub;
            Date = date;
            Score = score;
            OpponentScore = opponentScore;
            MatchOutcome = matchOutcome;
        }
    }
}