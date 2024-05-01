using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetPlayersInMatchFromClubDataDelegate : DataReaderDelegate<IReadOnlyList<PlayerInMatch>>
    {
        public readonly int matchID;

        public readonly int clubID;
        
        public GetPlayersInMatchFromClubDataDelegate(int MatchID, int ClubID) : base("MLS.GetPlayersInMatchFromClub")
        {
            matchID = MatchID;
            clubID = ClubID;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("MatchID", matchID);
            command.Parameters.AddWithValue("ClubID", clubID);
        }

        public override IReadOnlyList<PlayerInMatch> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<PlayerInMatch>();

            while (reader.Read())
            {
                p.Add(new PlayerInMatch(reader.GetInt32("PlayerID"), reader.GetString("Name"), reader.GetString("Position"), reader.GetString("Club"), reader.GetString("SubstitutionTime"), reader.GetString("Substitute"), reader.GetString("Played")));
            }

            return p;
        }
    }
}
