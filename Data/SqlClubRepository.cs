using Data.DataDelegates;
using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
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
            }
        }

        public IReadOnlyList<Club> RetrieveClubs
        {
            get => executor.ExecuteReader(new RetrieveClubsDataDelegate());
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

        private string _logoPath = "Assets/ClubLogos/0.gif";

        public string LogoPath
        {
            get => _logoPath;
        }


    }
}
