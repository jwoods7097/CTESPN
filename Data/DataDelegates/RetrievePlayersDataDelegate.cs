using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class RetrievePlayersDataDelegate : DataReaderDelegate<IReadOnlyList<Player>>
    {
        public RetrievePlayersDataDelegate() : base("MLS.RetrievePlayers")
        {
        }

        public override IReadOnlyList<Player> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<Player>();

            while (reader.Read())
            {
                p.Add(new Player(reader.GetInt32("PlayerID"), reader.GetValue<PlayerType>("PlayerTypeID"), reader.GetString("Name")));
            }

            return p;
        }
    }
}
