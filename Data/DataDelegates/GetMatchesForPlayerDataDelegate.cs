using Data.Models;
using DataAccess;
using NuGet.Frameworks;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetMatchesForPlayerDataDelegate : DataReaderDelegate<IReadOnlyList<MatchesForPlayer>>
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

        public override IReadOnlyList<MatchesForPlayer> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<MatchesForPlayer>();

            while (reader.Read())
            {
                p.Add(new MatchesForPlayer(reader.GetString("Name"), reader.GetInt32("ClubID"), reader.GetString("ClubName"), reader.GetString("OpponentClubName"), reader.GetValue<MatchClubType>("HomeOrAway"), reader.GetInt32("MatchID"), reader.GetValue<DateTime>("Date"), reader.GetString("Location"), reader.GetString("Formation"), reader.GetInt32("Score"), reader.GetInt32("OpponentScore"), reader.GetString("MatchOutcome"), reader.GetInt32("Attendance")));
            }

            return p;
        }
    }
}
