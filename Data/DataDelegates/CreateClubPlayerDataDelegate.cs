using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class CreateClubPlayerDataDelegate : NonQueryDataDelegate<ClubPlayer>
    {
        public readonly int playerid;
        public readonly PlayerType ptid;
        public readonly int clubid;
        public readonly DateTime dateStarted;

        public CreateClubPlayerDataDelegate(PlayerType pt, int playerid, int clubid) : base("MLS.CreateClubPlayer")
        {
            this.ptid = pt;
            this.playerid = playerid;
            this.clubid = clubid;
            this.dateStarted = DateTime.Now;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("PlayerID", playerid);
            command.Parameters.AddWithValue("PlayerTypeID", ptid);
            command.Parameters.AddWithValue("ClubID", clubid);
            command.Parameters.AddWithValue("DateStarted", dateStarted);

            var p = command.Parameters.Add("ClubPlayerID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override ClubPlayer Translate(Command command)
        {
            return new ClubPlayer(command.GetParameterValue<int>("ClubPlayerID"), playerid, ptid, clubid, dateStarted, null);
        }
    }
}
