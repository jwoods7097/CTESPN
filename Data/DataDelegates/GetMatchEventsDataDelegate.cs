using Data.Models;
using DataAccess;
using System.Data;

namespace Data.DataDelegates
{
    internal class GetMatchEventsDataDelegate : DataReaderDelegate<IReadOnlyList<MatchEvent>>
    {
        public readonly int matchID;
        
        public GetMatchEventsDataDelegate(int MatchID) : base("MLS.GetMatchEvents")
        {
            matchID = MatchID;
        }

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("MatchID", matchID);
        }

        public override IReadOnlyList<MatchEvent> Translate(Command command, IDataRowReader reader)
        {
            var p = new List<MatchEvent>();

            while (reader.Read())
            {
                p.Add(new MatchEvent(reader.GetString("Time"), reader.GetString("Commentary")));
            }

            return p;
        }
    }
}
