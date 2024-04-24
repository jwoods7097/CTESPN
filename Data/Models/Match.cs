namespace Data.Models
{
    public class Match
    {
        public int MatchID { get; }
        public string Location { get; }
        public DateOnly Date { get; }
        public int Attendance { get; }

        public Match(int matchID, string location, DateOnly date, int attendance)
        {
            MatchID = matchID;
            Location = location;
            Date = date;
            Attendance = attendance;
        }
    }
}