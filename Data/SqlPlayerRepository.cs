using Data.DataDelegates;
using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data
{
    public class SqlPlayerRepository
    {
        private readonly SqlCommandExecutor executor;

        public SqlPlayerRepository(string connectionString)
        {
            executor = new SqlCommandExecutor(connectionString);
        }

        public Player CreatePlayer(PlayerType pt, string name, string position)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException();
            var d = new CreatePlayerDataDelegate(pt, name, position);
            return executor.ExecuteNonQuery(d);
        }

        public IReadOnlyList<Player> RetrievePlayers()
        {
            return executor.ExecuteReader(new RetrievePlayersDataDelegate());
        }
    }
}
