using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetMatchDataDelegate : DataReaderDelegate<IReadOnlyList<MatchResult>>
    {
        public readonly int matchID;
        
        public GetMatchDataDelegate(int MatchID) : base("MLS.GetMatch")
        {
            matchID = MatchID;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("MatchID", matchID);
        }

        public override IReadOnlyList<MatchResult> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<MatchResult>();

            while (reader.Read())
            {
                p.Add(new MatchResult(reader.GetInt32("HomeClubID"), reader.GetString("HomeClub"), reader.GetInt32("HomeScore"), reader.GetString("HomeFormation"), reader.GetInt32("AwayClubID"), reader.GetString("AwayClub"), reader.GetInt32("AwayScore"), reader.GetString("AwayFormation"), reader.GetString("Location"), reader.GetValue<DateTime>("Date"), reader.GetInt32("Attendance")));
            }

            return p;
        }
    }
}
