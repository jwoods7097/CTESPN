namespace Data.Models
{
    public class Outfielder
    {
        public int PlayerID { get; }

        public PlayerType PlayerTypeID { get; }

        public Outfielder(int playerID, PlayerType playerTypeID) 
        {
            PlayerID = playerID;
            PlayerTypeID = playerTypeID;
        }
    }
}