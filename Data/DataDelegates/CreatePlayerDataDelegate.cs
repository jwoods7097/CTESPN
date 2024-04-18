using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class CreatePlayerDataDelegate : NonQueryDataDelegate<Player>
    {
        public readonly PlayerType pt;
        public readonly string name;

        public CreatePlayerDataDelegate(PlayerType pt, string name) : base("MLS.CreatePlayer")
        {
            this.pt = pt;
            this.name = name;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("PlayerTypeID", pt);
            command.Parameters.AddWithValue("Name", name);

            var p = command.Parameters.Add("PlayerID", SqlDbType.Int);
            p.Direction = ParameterDirection.Output;
        }

        public override Player Translate(Command command)
        {
            return new Player(command.GetParameterValue<int>("PlayerID"), pt, name);
        }
    }
}
