namespace Data.Models
{
    public class MatchWithClub
    {
        public int HomeClubID { get; }
        public int AwayClubID { get; }
        public int MatchID { get; }
        public string HomeFormation { get; }
        public string AwayFormation { get; }
        public int HomeScore { get; }
        public int AwayScore { get; }
        public string Location { get; }
        public DateOnly Date { get; }
        public int Attendance { get; }

        public MatchWithClub(int matchID, string location, DateOnly date, int attendance, int homeclubid, int awayclubid, string homeclubformation, string awayclubformation, int homescore, int awayscore) 
        {
            MatchID = matchID;
            Location = location;
            Date = date;
            Attendance = attendance;
            HomeClubID = homeclubid;
            AwayClubID = awayclubid;
            HomeFormation = homeclubformation;
            AwayFormation = awayclubformation;
            HomeScore = homescore;
            AwayScore = awayscore;
        }
    }
}