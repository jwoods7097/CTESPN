using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class GetPreviousClubsDataDelegate : DataReaderDelegate<IReadOnlyList<PreviousClub>>
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

        public override IReadOnlyList<PreviousClub> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<PreviousClub>();
            
            while (reader.Read())
            {
                p.Add(new PreviousClub(reader.GetString("Name"), reader.GetValue<DateTime>("FirstMatch"), reader.GetValue<DateTime>("LastMatch")));
            }

            return p;
        }
    }
}
