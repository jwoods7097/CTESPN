using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class ClubPlayerInfo
    {
        public int PlayerID { get; }
        public string Name { get; }
        public PlayerType PlayerType { get; }
        public DateTime DateStarted { get; }
        public DateTime? DateEnded { get; }

        public ClubPlayerInfo(int playerID, string name, PlayerType pt, DateTime dateStarted, DateTime? dateEnded)
        {
            PlayerID = playerID;
            Name = name;
            PlayerType = pt;
            DateStarted = dateStarted;
            DateEnded = dateEnded;
        }
    }
}
