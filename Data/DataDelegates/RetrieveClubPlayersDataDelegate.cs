using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class RetrieveClubPlayersDataDelegate : DataReaderDelegate<IReadOnlyList<Player>>
    {
        public readonly int clubID;
        public RetrieveClubPlayersDataDelegate(int ClubID) : base("MLS.RetrieveClubPlayers")
        {
            this.clubID = ClubID;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("ClubID", clubID);
        }

        public override IReadOnlyList<Player> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<Player>();

            while (reader.Read())
            {
                p.Add(new Player(reader.GetInt32("PlayerID"), reader.GetValue<PlayerType>("PlayerTypeID"), reader.GetString("Name"), reader.IsDbNull("Position") ? null : reader.GetString("Position")));
            }

            return p;
        }
    }
}
