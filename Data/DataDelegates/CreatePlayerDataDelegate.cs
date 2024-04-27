using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class CreatePlayerDataDelegate : NonQueryDataDelegate<Player>
    {
        public readonly PlayerType pt;
        public readonly string name;
        public readonly string position;
        public readonly int playerid;

        public CreatePlayerDataDelegate(int playerid, PlayerType pt, string name, string position) : base("MLS.CreatePlayer")
        {
            this.playerid = playerid;
            this.pt = pt;
            this.name = name;
            this.position = position;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("PlayerID", playerid);
            command.Parameters.AddWithValue("PlayerTypeID", pt);
            command.Parameters.AddWithValue("Name", name);
            command.Parameters.AddWithValue("Position", position);
        }

        public override Player Translate(Command command)
        {
            return new Player(playerid, pt, name, position);
        }
    }
}
