using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class ClubPlayerInfo
    {
        public string Name { get; }
        public PlayerType PlayerType { get; }
        public DateOnly FirstMatch { get; }
        public DateOnly? LatestMatch { get; }

        public ClubPlayerInfo(string name, PlayerType pt, DateTime firstMatch, DateTime? latestMatch)
        {
            Name = name;
            PlayerType = pt;
            FirstMatch = DateOnly.FromDateTime(firstMatch);
            LatestMatch = latestMatch == null ? null : DateOnly.FromDateTime((DateTime)latestMatch);
        }
    }
}
