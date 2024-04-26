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
                p.Add(new MatchesForPlayer(reader.GetString("Name"), reader.GetInt32("ClubID"), reader.GetString("ClubName"), reader.GetString("OpponentClubName"), reader.GetValue<MatchClubType>("HomeOrAway"), reader.GetInt32("MatchID"), reader.GetValue<DateOnly>("Date"), reader.GetString("Location"), reader.GetString("HomeFormation"), reader.GetInt32("HomeScore"), reader.GetInt32("AwayScore"), reader.GetInt32("Attendance")));
            }

            return p;
        }
    }
}
