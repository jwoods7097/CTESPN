using Data.Models;
using DataAccess;
using NuGet.Frameworks;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetMatchesForPlayerDataDelegate : DataReaderDelegate<IReadOnlyList<MatchesForClub>>
    {
        public readonly int playerID;
        public readonly string startDate;
        public readonly string endDate;

        public GetMatchesForPlayerDataDelegate(int playerID, string startDate, string endDate) : base("MLS.GetMatchesForPlayer")
        {
            this.playerID = playerID;
            this.startDate = startDate;
            this.endDate = endDate;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("PlayerID", playerID);
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
