namespace Data.Models
{
    public class MatchGoalkeeperStats 
    {
        public int MatchClubPlayerID { get; }
        public int MinutesPlayed { get; }
        public int Saves { get; }
        public int YellowCards { get; }
        public int RedCards { get; }

        public MatchGoalkeeperStats(int matchClubPlayerID, int minutesPlayed, int saves, int yellowCards, int redCards)
        {
            MatchClubPlayerID = matchClubPlayerID;
            MinutesPlayed = minutesPlayed;
            Saves = saves;
            YellowCards = yellowCards;
            RedCards = redCards;
        }
    }
}