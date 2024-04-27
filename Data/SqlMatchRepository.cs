using DataAccess;
using Data.Models;
using Data.DataDelegates;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Testing.Platform.Extensions.Messages;

namespace Data
{
    public class SqlMatchRepository
    {
        public readonly SqlCommandExecutor executor;

        public SqlMatchRepository(string connectionString)
        {
            executor = new SqlCommandExecutor(connectionString);
        }

        public Match CreateMatch(string location, DateOnly date, int attendance)
        {
            if (string.IsNullOrEmpty(location)) { throw new ArgumentException(); }
            var d = new CreateMatchDataDelegate(location, date, attendance);
            return executor.ExecuteNonQuery(d);
        }

        public MatchClub CreateMatchHomeClub(int clubid, int matchid, string formation, int score)
        {
            if (string.IsNullOrEmpty(formation)) { throw new ArgumentException(); }
            var d = new CreateMatchClubDataDelegate(clubid, MatchClubType.Home, matchid, formation, score);
            return executor.ExecuteNonQuery(d);
        }

        public MatchClub CreateMatchAwayClub(int clubid, int matchid, string formation, int score) {
            if (string.IsNullOrEmpty(formation)) { throw new ArgumentException(); }
            var d = new CreateMatchClubDataDelegate(clubid, MatchClubType.Away, matchid, formation, score);
            return executor.ExecuteNonQuery(d);
        }

        public IReadOnlyList<MatchWithClub> RetrieveMatchesWithClubs() {
            return executor.ExecuteReader(new RetrieveMatchesWithClubsDataDelegate());
        }
<<<<<<< HEAD
=======

        public IReadOnlyList<MatchesForClub> GetMatchesForClub() {
            return executor.ExecuteReader(new GetMatchesForClubDataDelegate());
        }

        public IReadOnlyList<MatchesForClub> GetMatchesForClub() {
            return executor.ExecuteReader(new GetMatchesForClubDataDelegate());
        }

        public IReadOnlyList<MatchesForPlayer> GetMatchesForPLayer() {
            return executor.ExecuteReader(new GetMatchesForPlayerDataDelegate());
        }
>>>>>>> 70b43281a7a2f6a7eb379ebd83bb363eb31d76cc
    }
}
