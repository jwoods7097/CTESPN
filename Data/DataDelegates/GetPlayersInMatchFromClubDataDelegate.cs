using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetAllPlayersInMatchDataDelegate : DataReaderDelegate<IReadOnlyList<PlayerInMatch>>
    {
        public readonly int matchID;
        
        public GetAllPlayersInMatchDataDelegate(int MatchID) : base("MLS.GetAllPlayersInMatch")
        {
            matchID = MatchID;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("MatchID", matchID);
        }

        public override IReadOnlyList<PlayerInMatch> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<PlayerInMatch>();

            while (reader.Read())
            {
                p.Add(new PlayerInMatch(reader.GetString("Name"), reader.GetString("Position"), reader.GetString("Club"), reader.GetString("SubstitutionTime"), reader.GetString("Substitute"), reader.GetString("Played")));
            }

            return p;
        }
    }
}
