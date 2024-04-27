using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetMatchesForClubWithOpponentDataDelegate : DataReaderDelegate<IReadOnlyList<MatchesForClub>>
    {
        public readonly int clubID;

        public readonly int opponentClubID;

        public readonly string startDate;

        public readonly string endDate;

        public GetMatchesForClubWithOpponentDataDelegate(int ClubID, int OpponentClubID, string StartDate, string EndDate) : base("MLS.GetMatchesForClubWithOpponent")
        {
            this.clubID = ClubID;
            this.opponentClubID = OpponentClubID;
            this.startDate = StartDate;
            this.endDate = EndDate;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("ClubID", clubID);
            command.Parameters.AddWithValue("OpponentClubID", opponentClubID);
            command.Parameters.AddWithValue("StartDate", startDate);
            command.Parameters.AddWithValue("EndDate", endDate);
        }

        public override IReadOnlyList<MatchesForClub> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<MatchesForClub>();

            while (reader.Read())
            {
                p.Add(new MatchesForClub(reader.GetString("HomeClub"), reader.GetString("AwayClub"), reader.GetValue<DateTime>("Date"), reader.GetInt32("Score"), reader.GetInt32("OpponentScore"), reader.GetString("MatchOutcome")));
            }

            return p;
        }
    }
}
