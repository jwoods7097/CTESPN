using Data;
using Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace CTESPN
{
    /// <summary>
    /// Interaction logic for MatchView.xaml
    /// </summary>
    public partial class MatchView : UserControl
    {     
        private SqlMatchRepository repo;

        public MatchView()
        {
            InitializeComponent();
        }

        public void SetDataContext(int matchID)
        {
            this.DataContext = repo = new SqlMatchRepository(matchID);
            repo.GetPlayersInMatch("Any");
        }

        public void HandleRadioButtonSelectionChange(object sender, RoutedEventArgs e)
        {
            if(repo != null) {
                if (e.OriginalSource == AnyButton)
                {
                    repo.GetPlayersInMatch("Any");
                }
                else if (e.OriginalSource == HomeButton)
                {
                    repo.GetPlayersInMatch("Home");
                }
                else if (e.OriginalSource == AwayButton)
                {
                    repo.GetPlayersInMatch("Away");
                }
            }
            e.Handled = true;
        }

        private void HandlePlayerClick(object sender, SelectionChangedEventArgs e)
        {
            if(MatchPlayerDataGrid.SelectedItem is PlayerInMatch pim)
            {
                var result = repo.GetPlayerStats(pim.GetPlayerID());
                if(result.Count > 0)
                {
                    PlayerStats stats = result[0];
                    // Outfielder or Goalkeeper
                    if(stats.Saves == null)
                    {
                        MessageBox.Show($"Goals: {stats.Goals}\nAssists: {stats.Assists}\nOffsides: {stats.Offsides}\nShots: {stats.Shots}\nShots on Target: {stats.ShotsOnTarget}\nFouls: {stats.Fouls}\nYellow Cards: {stats.YellowCards}\nRed Cards: {stats.RedCards}\n", pim.Name + " Stats");
                    }
                    else
                    {
                        MessageBox.Show($"Saves: {stats.Saves}\nFouls: {stats.Fouls}\nYellow Cards: {stats.YellowCards}\nRed Cards: {stats.RedCards}\n", pim.Name + " Stats");
                    }
                }
            }
            e.Handled = true;
        }
    }
}
