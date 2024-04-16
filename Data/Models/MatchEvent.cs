namespace Data.Models
{
    public class MatchEvent
    {
        public int MatchEventID { get; }
        public int MatchID { get; }
        public int Time { get; }
        public string Commentary { get; }

        public MatchEvent(int matchEventID, int matchID, int time, string commentary)
        {
            MatchEventID = matchEventID;
            MatchID = matchID;
            time = time;
            Commentary = commentary;
        }
    }
}