namespace Data.Models
{
    public class MatchOutfielderStats 
    {
        public int MatchClubPlayerID { get; }
        public int MinutesPlayed { get; }
        public int PosessionTime { get; }
        public int CornerKicks { get; }
        public int Goals { get; }
        public int Fouls { get; }
        public int Offsides { get; }
        public int YellowCards { get; }
        public int RedCards { get; }

        public MatchOutfielderStats(int matchClubPlayerID, int minutesPlayed, int posessionTime, int cornerKicks, int goals, int fouls, int offsides, int yellowCards, int redCards)
        {
            MatchClubPlayerID = matchClubPlayerID;
            MinutesPlayed = minutesPlayed;
            PosessionTime = posessionTime;
            CornerKicks = cornerKicks;
            Goals = goals;
            Fouls = fouls;
            Offsides = offsides;
            YellowCards = yellowCards;
            RedCards = redCards;
        }
    }
}