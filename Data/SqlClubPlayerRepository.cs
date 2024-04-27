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
    public class SqlClubPlayerRepository
    {
        private const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=CTESPN;Integrated Security=SSPI;";

        private readonly SqlCommandExecutor executor;

        public SqlClubPlayerRepository()
        {
            executor = new SqlCommandExecutor(connectionString);
        }

        public ClubPlayer CreateClubPlayer(int playerid, PlayerType ptid, int clubid)
        {
            var d = new CreateClubPlayerDataDelegate(ptid, playerid, clubid);
            return executor.ExecuteNonQuery(d);
        }
    }
}
