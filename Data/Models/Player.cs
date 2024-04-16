namespace Data.Models
{
    public class Player
    {
        public int PlayerID { get; }

        public int PlayerTypeID { get; }

        public string Name { get; }

        public Player(int playerID, int playerTypeID, string name)
        {
            PlayerID = playerID;
            PlayerTypeID = playerTypeID;
            Name = name;
        }
    }
}