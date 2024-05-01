using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class PreviousClub
    {
        public string Name { get; }

        public DateOnly FirstMatch { get; }

        public DateOnly LastMatch { get; }

        public PreviousClub(string name, DateTime firstMatch, DateTime lastMatch)
        {
            Name = name;
            FirstMatch = DateOnly.FromDateTime(firstMatch);
            LastMatch = DateOnly.FromDateTime(lastMatch);
        }
    }
}
