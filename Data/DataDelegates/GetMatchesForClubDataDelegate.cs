using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetMatchesForClubDataDelegate : DataReaderDelegate<IReadOnlyList<MatchesForClub>>
    {
        public GetMatchesForClubDataDelegate() : base("MLS.GetMatchesForClub")
        {
        }

        public override IReadOnlyList<MatchesForClub> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<MatchesForClub>();

            while (reader.Read())
            {
                p.Add(new MatchesForClub(reader.GetInt32("MatchID"), reader.GetString("Location"), reader.GetValue<DateOnly>("Date"), reader.GetInt32("Attendance"), reader.GetValue<MatchClubType>("HomeOrAway"), reader.GetString("Formation"), reader.GetString("OpponentClub"), reader.GetInt32("Score"), reader.GetInt32("OpponentScore")));
            }

            return p;
        }
    }
}
