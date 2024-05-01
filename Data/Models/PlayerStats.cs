using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class PlayerStats
    {
        public int? Goals { get; }

        public int? Assists { get; }

        public int? Offsides { get; }

        public int? Shots { get; }

        public int? ShotsOnTarget { get; }

        public int? Saves { get; }

        public int Fouls { get; }

        public int YellowCards { get; }

        public int RedCards { get; }

        public PlayerStats(int? goals, int? assists, int? offsides, int? shots, int? shotsOnTarget, int? saves, int fouls, int yellowCards, int redCards)
        {
            Goals = goals;
            Assists = assists;
            Offsides = offsides;
            Shots = shots;
            ShotsOnTarget = shotsOnTarget;
            Saves = saves;
            Fouls = fouls;
            YellowCards = yellowCards;
            RedCards = redCards;
        }
    }
}
