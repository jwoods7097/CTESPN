using DataAccess;
using Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    public class GetPlayerMatchStatsDataDelegate : DataReaderDelegate<IReadOnlyList<PlayerStats>>
    {
        public readonly int playerid;

        public readonly int matchid;

        public GetPlayerMatchStatsDataDelegate(int playerid, int matchid) : base("MLS.GetPlayerMatchStats")
        {
            this.playerid = playerid;
            this.matchid = matchid;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("PlayerID", playerid);
            command.Parameters.AddWithValue("MatchID", matchid);
        }

        public override IReadOnlyList<PlayerStats> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<PlayerStats>();
            
            while (reader.Read())
            {
                p.Add(new PlayerStats(reader.IsDbNull("Goals") ? null : reader.GetInt32("Goals"), reader.IsDbNull("Assists") ? null : reader.GetInt32("Assists"), reader.IsDbNull("Offsides") ? null : reader.GetInt32("Offsides"), reader.IsDbNull("Shots") ? null : reader.GetInt32("Shots"), reader.IsDbNull("ShotsOnTarget") ? null : reader.GetInt32("ShotsOnTarget"), reader.IsDbNull("Saves") ? null : reader.GetInt32("Saves"), reader.GetInt32("Fouls"), reader.GetInt32("YellowCards"), reader.GetInt32("RedCards")));
            }

            return p;
        }
    }
}
