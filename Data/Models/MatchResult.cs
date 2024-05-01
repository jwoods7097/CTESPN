namespace Data.Models
{
    public class MatchResult
    {
        public int HomeClubID { get; }
        
        public string HomeClub { get; }

        public int HomeScore { get; }

        public string HomeFormation { get; }

        public int AwayClubID { get; }

        public string AwayClub { get; }

        public int AwayScore { get; }

        public string AwayFormation { get; }

        public string Location { get; }

        public DateOnly Date { get; }

        public int Attendance { get; }

        public MatchResult(int homeClubID, string homeClub, int homeScore, string homeFormation, int awayClubID, string awayClub, int awayScore, string awayFormation, string location, DateTime date, int attendance)
        {
            HomeClubID = homeClubID;
            HomeClub = homeClub;
            HomeScore = homeScore;
            HomeFormation = homeFormation;
            AwayClubID = awayClubID;
            AwayClub = awayClub;
            AwayScore = awayScore;
            AwayFormation = awayFormation;
            Location = location;
            Date = DateOnly.FromDateTime(date);
            Attendance = attendance;
        }
    }
}