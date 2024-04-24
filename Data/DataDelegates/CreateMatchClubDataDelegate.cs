using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class CreateMatchClubDataDelegate : NonQueryDataDelegate<MatchClub>
    {
        public readonly int ClubID;
        public readonly MatchClubType ClubType;
        public readonly int MatchID;
        public readonly string Formation;
        public readonly int Score;

        public CreateMatchClubDataDelegate(int clubid, MatchClubType type, int matchid, string formation, int score) : base("MLS.CreateMatchClub")
        {
            ClubID = clubid;
            ClubType = type;
            MatchID = matchid;
            Formation = formation;
            Score = score;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("ClubID", ClubID);
            command.Parameters.AddWithValue("MatchClubTypeID", ClubType);
            command.Parameters.AddWithValue("MatchID", MatchID);
            command.Parameters.AddWithValue("Formation", Formation);
            command.Parameters.AddWithValue("Score", Score);

            var p = command.Parameters.Add("MatchClubID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override MatchClub Translate(Command command)
        {
            return new MatchClub(command.GetParameterValue<int>("MatchClubID"), ClubID, ClubType, MatchID, Formation, Score);
        }
    }
}
