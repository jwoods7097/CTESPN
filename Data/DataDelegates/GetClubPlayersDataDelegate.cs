using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class GetClubPlayersDataDelegate : DataReaderDelegate<IReadOnlyList<ClubPlayerInfo>>
    {
        public readonly int ClubID;

        public GetClubPlayersDataDelegate(int clubID) : base("MLS.GetClubPlayers")
        {
            this.ClubID = clubID;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("ClubID", ClubID);
        }

        public override IReadOnlyList<ClubPlayerInfo> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<ClubPlayerInfo>();

            while (reader.Read())
            {
                p.Add(new ClubPlayerInfo(reader.GetString("Name"), reader.GetValue<PlayerType>("PlayerTypeID"), reader.GetValue<DateTime>("FirstMatch"), reader.IsDbNull("LatestMatch") ? null : reader.GetValue<DateTime>("LatestMatch")));
            }

            return p;
        }
    }
}
