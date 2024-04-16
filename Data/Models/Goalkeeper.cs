namespace Data.Models
{
    public class Goalkeeper
    {
        public int PlayerID { get; }

        public int PlayerTypeID { get; }

        public Goalkeeper(int playerID, int playerTypeID) 
        {
            PlayerID = playerID;
            PlayerTypeID = playerTypeID;
        }
    }
}