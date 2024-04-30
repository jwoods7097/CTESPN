namespace Data.Models
{
    public class MatchEvent
    {
        public string Time { get; }
        public string Commentary { get; }

        public MatchEvent(string time, string commentary)
        {
            Time = time;
            Commentary = commentary;
        }
    }
}