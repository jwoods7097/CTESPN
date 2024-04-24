namespace Data.Models
{
    public class Player
    {
        public int PlayerID { get; }

        public PlayerType PlayerTypeID { get; }

        public string Name { get; }

        public string? Position { get; }

        public Player(int playerID, PlayerType playerTypeID, string name, string? position)
        {
            PlayerID = playerID;
            PlayerTypeID = playerTypeID;
            Name = name;
            Position = position;
        }
    }
}