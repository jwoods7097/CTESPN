using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class GetPreviousClubsDataDelegate : DataReaderDelegate<IReadOnlyList<Club>>
    {
        public readonly int playerID;
        public readonly int clubID;

        public GetPreviousClubsDataDelegate(int playerID, int clubID) : base("MLS.GetPreviousClubs")
        {
            this.playerID = playerID;
            this.clubID = clubID;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("PlayerID", playerID);
            command.Parameters.AddWithValue("ClubID", clubID);
        }

        public override IReadOnlyList<Club> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<Club>();
            
            while (reader.Read())
            {
                p.Add(new Club(reader.GetInt32("ClubID"), reader.GetString("Name"), reader.GetString("Abbreviation"), reader.GetString("HomeLocation"), reader.GetString("Conference")));
            }

            return p;
        }
    }
}
