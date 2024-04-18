namespace Data.Models
{
    public class Goalkeeper
    {
        public int PlayerID { get; }

        public PlayerType PlayerTypeID { get; }

        public Goalkeeper(int playerID, PlayerType playerTypeID) 
        {
            PlayerID = playerID;
            PlayerTypeID = playerTypeID;
        }
    }
}