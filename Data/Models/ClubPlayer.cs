namespace Data.Models
{
    public class ClubPlayer
    {
        public int ClubPlayerID { get; }
        public int PlayerID { get; }
        public PlayerType PlayerTypeID { get; }
        public int ClubID { get; }
        public DateTime DateStarted { get; }
        public DateTime? DateEnded { get; }

        public ClubPlayer(int clubPlayerID, int playerID, PlayerType playerTypeID, int clubID, DateTime dateStarted, DateTime? dateEnded) 
        {
            ClubPlayerID = clubPlayerID;
            PlayerID = playerID;
            PlayerTypeID = playerTypeID;
            ClubID = clubID;
            DateStarted = dateStarted;
            DateEnded = dateEnded; 
        }
    }
}