using Data.Models;
using DataAccess;
using NuGet.Frameworks;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetMatchesForPlayerDataDelegate : DataReaderDelegate<IReadOnlyList<MatchesForPlayer>>
    {
        public GetMatchesForPlayerDataDelegate() : base("MLS.GetMatchesForPlayer")
        {
        }

        public override IReadOnlyList<MatchesForPlayer> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<MatchesForPlayer>();

            while (reader.Read())
            {
                p.Add(new MatchesForPlayer(reader.GetInt32("MatchID"), reader.GetString("Location"), reader.GetValue<DateOnly>("Date"), reader.GetInt32("Attendance"), reader.GetInt32("HomeClubID"), reader.GetInt32("AwayClubID"), reader.GetString("HomeFormation"), reader.GetString("AwayFormation"), reader.GetInt32("HomeScore"), reader.GetInt32("AwayScore")));
            }

            return p;
        }
    }
}
