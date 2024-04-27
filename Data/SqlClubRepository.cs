﻿using Data.DataDelegates;
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
                //PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(RetrievePlayers)));
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
            return executor.ExecuteNonQuery(d);
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

        public List<string> RetrieveClubPlayers
        {
            get
            {
                var sqlResult = executor.ExecuteReader(new RetrieveClubPlayersDataDelegate(SelectedClub.ClubID));
                List<string> result = new List<string>() { "Any" };
                foreach (var player in sqlResult)
                {
                    result.Add(player.Name);
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
