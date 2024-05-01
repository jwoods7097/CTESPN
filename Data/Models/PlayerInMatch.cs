using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class PlayerInMatch
    {
        private int PlayerID;

        public string Name { get; }

        public string Position { get; }

        public string Club { get; }

        public string SubstitutionTime { get; }

        public string Substitute { get; }

        public string Played { get; }

        public PlayerInMatch(int playerID, string name, string position, string club, string substitutionTime, string substitute, string played)
        {
            PlayerID = playerID;
            Name = name;
            Position = position;
            Club = club;
            SubstitutionTime = substitutionTime;
            Substitute = substitute;
            Played = played;
        }

        public int GetPlayerID()
        {
            return PlayerID;
        }
    }
}
