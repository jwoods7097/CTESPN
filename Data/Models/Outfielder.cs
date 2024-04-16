namespace Data.Models
{
    public class Outfielder
    {
        public int PlayerID { get; }

        public int PlayerTypeID { get; }

        public Outfielder(int playerID, int playerTypeID) 
        {
            PlayerID = playerID;
            PlayerTypeID = playerTypeID;
        }
    }
}