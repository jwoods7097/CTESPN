using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class RetrieveMatchesWithClubsDataDelegate : DataReaderDelegate<IReadOnlyList<MatchWithClub>>
    {
        public RetrieveMatchesWithClubsDataDelegate() : base("MLS.RetrieveMatchesWithClubs")
        {
        }

        public override IReadOnlyList<MatchWithClub> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<MatchWithClub>();

            while (reader.Read())
            {
                p.Add(new MatchWithClub(reader.GetInt32("MatchID"), reader.GetString("Location"), reader.GetValue<DateOnly>("Date"), reader.GetInt32("Attendance"), reader.GetInt32("HomeClubID"), reader.GetInt32("AwayClubID"), reader.GetString("HomeFormation"), reader.GetString("AwayFormation"), reader.GetInt32("HomeScore"), reader.GetInt32("AwayScore")));
            }

            return p;
        }
    }
}
