using DataAccess;
using Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class CreateMatchDataDelegate : NonQueryDataDelegate<Match>
    {
        public readonly string Location;
        public readonly DateOnly Date;
        public readonly int Attendance;

        public CreateMatchDataDelegate(string location, DateOnly date, int attendance) : base("MLS.CreateMatch")
        {
            Location = location;
            Date = date;
            Attendance = attendance;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("Location", Location);
            command.Parameters.AddWithValue("Date", Date);
            command.Parameters.AddWithValue("Attendance", Attendance);

            var p = command.Parameters.Add("MatchID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override Match Translate(Command command)
        {
            return new Match(command.GetParameterValue<int>("MatchID"), Location, Date, Attendance)
        }
    }
}
