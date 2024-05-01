using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Data.Models;

namespace Data.DataDelegates
{
    internal class GetMatchesForPlayerWithOpponentDataDelegate : DataReaderDelegate<IReadOnlyList<MatchesForClub>>
    {
        public readonly int playerID;
        public readonly int opponentClubID;
        public readonly string startDate;
        public readonly string endDate;
        public GetMatchesForPlayerWithOpponentDataDelegate(int playerID, int opponentClubID, string startDate, string endDate) : base("MLS.GetMatchesForPlayerWithOpponent")
        {
            this.playerID = playerID;
            this.opponentClubID = opponentClubID;
            this.startDate = startDate;
            this.endDate = endDate;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("PlayerID", playerID);
            command.Parameters.AddWithValue("OpponentClubID", opponentClubID);
            command.Parameters.AddWithValue("StartDate", startDate);
            command.Parameters.AddWithValue("EndDate", endDate);
        }

        public override IReadOnlyList<MatchesForClub> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<MatchesForClub>();

            while (reader.Read())
            {
                p.Add(new MatchesForClub(reader.GetInt32("MatchID"), reader.GetString("HomeClub"), reader.GetString("AwayClub"), reader.GetValue<DateTime>("Date"), reader.GetInt32("Score"), reader.GetInt32("OpponentScore"), reader.GetString("MatchOutcome")));
            }

            return p;
        }
    }
}
