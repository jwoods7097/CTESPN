using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class CreateClubDataDelegate : NonQueryDataDelegate<Club>
    {
        public readonly string name;
        public readonly string abb;
        public readonly string location;
        public readonly string conference;

        public CreateClubDataDelegate(string name, string abb, string location, string conference) : base("MLS.CreateClub")
        {
            this.name = name;
            this.abb = abb;
            this.location = location;
            this.conference = conference;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("Name", name);
            command.Parameters.AddWithValue("Abbreviation", abb);
            command.Parameters.AddWithValue("Location", location);
            command.Parameters.AddWithValue("Conference", conference);

            var p = command.Parameters.Add("ClubID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override Club Translate(Command command)
        {
            return new Club(command.GetParameterValue<int>("ClubID"), name, abb, location, conference);
        }
    }
}
