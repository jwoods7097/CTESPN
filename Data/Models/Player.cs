namespace Data.Models
{
    public class Player
    {
        public int PlayerID { get; }

        public PlayerType PlayerTypeID { get; }

        public string Name { get; }

        public Player(int playerID, PlayerType playerTypeID, string name)
        {
            PlayerID = playerID;
            PlayerTypeID = playerTypeID;
            Name = name;
        }
    }
}