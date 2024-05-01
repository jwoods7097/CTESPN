using Data.DataDelegates;
using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Data
{
    public class SqlPlayerRepository : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        private readonly SqlCommandExecutor executor;
        private const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=CTESPN;Integrated Security=SSPI;";

        public SqlPlayerRepository()
        {
            executor = new SqlCommandExecutor(connectionString);
            SelectedPlayer = RetrievePlayers[0];
        }

        public Player CreatePlayer(int playerid, PlayerType pt, string name, string position)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException();
            var d = new CreatePlayerDataDelegate(playerid, pt, name, position);
            return executor.ExecuteNonQuery(d);
        }

        private Player _selectedPlayer;

        public Player SelectedPlayer
        {
            get => _selectedPlayer;
            set
            {
                _selectedPlayer = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(SelectedPlayer)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(RetrieveOpponents)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Matches)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(PossibleOpponents)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(SelectedClub)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(GetPreviousClubs)));
            }
        }

        public Club SelectedClub
        {
            get => executor.ExecuteReader(new GetClubForPlayerDataDelegate(SelectedPlayer.PlayerID))[0];
        }

        public IReadOnlyList<Player> RetrievePlayers
        {
            get => executor.ExecuteReader(new RetrievePlayersDataDelegate());
        }

        public List<string> RetrieveOpponents
        {
            get
            {
                var sqlResult = executor.ExecuteReader(new RetrieveOpponentClubsWithPlayerIDDataDelegate(SelectedPlayer.PlayerID));
                List<string> result = new List<string>() { "Any" };
                foreach (var club in sqlResult)
                {
                    result.Add(club.Name);
                }
                return result;
            }
        }

        public List<Club> PossibleOpponents
        {
            get
            {
                var sqlResult = executor.ExecuteReader(new RetrieveOpponentClubsWithPlayerIDDataDelegate(SelectedPlayer.PlayerID));
                List<Club> result = new List<Club>();
                foreach (var club in sqlResult)
                {
                    result.Add(club);
                }
                return result;
            }
        }

        private string _selectedOpponent;

        public string SelectedOpponent
        {
            get => _selectedOpponent;
            set
            {
                _selectedOpponent = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(SelectedOpponent)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Matches)));
            }
        }

        public List<string> RetrieveYears
        {
            get
            {
                var sqlResult = executor.ExecuteReader(new RetrieveYearsDataDelegate());
                List<string> result = new List<string>() { "Any" };
                foreach (var year in sqlResult)
                {
                    result.Add(year.ToString());
                }
                return result;
            }
        }

        private string _selectedYear = "Any";

        public string SelectedYear
        {
            get => _selectedYear;
            set
            {
                _selectedYear = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(SelectedYear)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Matches)));
            }
        }


        public IReadOnlyList<MatchesForPlayer>? Matches
        {
            get
            {
                string startDate;
                string endDate;
                if (SelectedYear == "Any")
                {
                    startDate = "2021-01-01";
                    endDate = "2024-12-31";
                }
                else
                {
                    startDate = $"{SelectedYear}-01-01";
                    endDate = $"{SelectedYear}-12-31";
                }

                if (SelectedOpponent == "Any")
                {
                    return executor.ExecuteReader(new GetMatchesForPlayerDataDelegate(SelectedPlayer.PlayerID, startDate, endDate)); ;
                }
                else
                {
                    var selectedOpponentClub = PossibleOpponents.FirstOrDefault(x => x.Name == SelectedOpponent);
                    if (selectedOpponentClub != null)
                    {
                        int opponentClubID = selectedOpponentClub.ClubID;
                        return executor.ExecuteReader(new GetMatchesForPlayerWithOpponentDataDelegate(SelectedPlayer.PlayerID, opponentClubID, startDate, endDate));
                    }
                    return null;
                }
            }
        }

        public IReadOnlyList<Club> GetPreviousClubs
        {
            get
            {
                return executor.ExecuteReader(new GetPreviousClubsDataDelegate(SelectedPlayer.PlayerID, SelectedClub.ClubID));
            }
        }
    }
}
