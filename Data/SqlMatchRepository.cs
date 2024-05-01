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
using System.ComponentModel;

namespace Data
{
    public class SqlMatchRepository : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        private const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=CTESPN;Integrated Security=SSPI;";

        public readonly SqlCommandExecutor executor;

        private int matchID;

        public MatchResult CurrentMatch { get; }

        public IReadOnlyList<MatchEvent> MatchEvents { get; }

        private IReadOnlyList<PlayerInMatch> _players;
        
        public IReadOnlyList<PlayerInMatch> Players
        {
            get => _players;
            set
            {
                _players = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Players)));
            }
        }

        public SqlMatchRepository(int matchID)
        {
            this.matchID = matchID;
            executor = new SqlCommandExecutor(connectionString);
            CurrentMatch = executor.ExecuteReader(new GetMatchDataDelegate(matchID))[0];
            MatchEvents = executor.ExecuteReader(new GetMatchEventsDataDelegate(matchID));
        }

        public void GetPlayersInMatch(string clubtype)
        {
            switch(clubtype)
            {
                case "Any":
                    Players = executor.ExecuteReader(new GetAllPlayersInMatchDataDelegate(matchID));
                    break;
                case "Home":
                    Players = executor.ExecuteReader(new GetPlayersInMatchFromClubDataDelegate(matchID, CurrentMatch.HomeClubID));
                    break;
                case "Away":
                    Players = executor.ExecuteReader(new GetPlayersInMatchFromClubDataDelegate(matchID, CurrentMatch.AwayClubID));
                    break;
                default:
                    throw new ArgumentException();
            }
        }

        public IReadOnlyList<PlayerStats> GetPlayerStats(int playerID)
        {
            return executor.ExecuteReader(new GetPlayerMatchStatsDataDelegate(playerID, matchID));
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

        public IReadOnlyList<MatchWithClub> RetrieveMatchesWithClubs()
        {
            return executor.ExecuteReader(new RetrieveMatchesWithClubsDataDelegate());
        }
    }
}
