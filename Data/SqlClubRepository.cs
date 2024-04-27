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
    public class SqlClubRepository : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        private const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=CTESPN;Integrated Security=SSPI;";

        private readonly SqlCommandExecutor executor;

        public SqlClubRepository()
        {
            executor = new SqlCommandExecutor(connectionString);
            SelectedClub = RetrieveClubs[0];
        }

        private Club _selectedClub;

        public Club SelectedClub
        {
            get => _selectedClub;
            set
            {
                _selectedClub = value;
                _logoPath = $"Assets/ClubLogos/{_selectedClub.ClubID}.gif";
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(SelectedClub)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(LogoPath)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(RetrieveOpponents)));
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Matches)));
            }
        }

        public IReadOnlyList<Club> RetrieveClubs
        {
            get => executor.ExecuteReader(new RetrieveClubsDataDelegate());
        }

        public Club CreateClub(string name, string abb, string location, string conference)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(abb)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(location)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(conference)) throw new ArgumentException();
            var d = new CreateClubDataDelegate(name, abb, location, conference);
            var result = executor.ExecuteNonQuery(d);
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(RetrieveClubs)));
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(RetrieveOpponents)));
            return result;
        }

        public List<string> RetrieveOpponents
        {
            get
            {
                var sqlResult = executor.ExecuteReader(new RetrieveOpponentClubsDataDelegate(SelectedClub.ClubID));
                List<string> result = new List<string>() { "Any" };
                foreach(var club in sqlResult) {
                    result.Add(club.Name);
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

        private string _logoPath = "Assets/ClubLogos/0.gif";

        public string LogoPath
        {
            get => _logoPath;
        }

        public IReadOnlyList<MatchesForClub> Matches
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
                    return executor.ExecuteReader(new GetMatchesForClubDataDelegate(SelectedClub.ClubID, startDate, endDate));
                }
                else
                {
                    int opponentClubID = RetrieveClubs.FirstOrDefault(x => x.Name == SelectedOpponent).ClubID;
                    return executor.ExecuteReader(new GetMatchesForClubWithOpponentDataDelegate(SelectedClub.ClubID, opponentClubID, startDate, endDate));
                }
            }
        }
    }
}
