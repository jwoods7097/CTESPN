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

        public Club CreateClub(string name, string abb, string location, string conference)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(abb)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(location)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(conference)) throw new ArgumentException();
            var d = new CreateClubDataDelegate(name, abb, location, conference);
            return executor.ExecuteNonQuery(d);
        }

        public IReadOnlyList<Club> RetrieveClubs()
        {
            return executor.ExecuteReader(new RetrieveClubsDataDelegate());
        }
    }
}
