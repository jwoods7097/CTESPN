using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Data.DataDelegates
{
    internal class RetrieveOpponentClubsDataDelegate : DataReaderDelegate<IReadOnlyList<Club>>
    {
        public readonly int clubID;

        public RetrieveOpponentClubsDataDelegate(int ClubID) : base("MLS.RetrieveOpponentClubs")
        {
            this.clubID = ClubID;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

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
