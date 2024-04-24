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
    public class SqlClubRepository
    {
        private readonly SqlCommandExecutor executor;

        public SqlClubRepository(string connectionString)
        {
            executor = new SqlCommandExecutor(connectionString);
        }

        public IReadOnlyList<Club> RetrieveClubs()
        {
            return executor.ExecuteReader(new RetrieveClubsDataDelegate());
        }
    }
}
