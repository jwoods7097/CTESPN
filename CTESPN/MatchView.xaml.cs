using Data;
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
    }
}
