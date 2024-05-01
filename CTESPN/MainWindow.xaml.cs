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
using Data.Models;

namespace CTESPN
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        /// <summary>
        /// The main menu of the application
        /// </summary>
        private MainView mainView;
        
        /// <summary>
        /// The view that allows you to look at individual clubs
        /// </summary>
        private ClubView clubView;

        /// <summary>
        /// The view that allows you to look at individual playerss
        /// </summary>
        private PlayerView playerView;

        /// <summary>
        /// The view that allows you to add clubs
        /// </summary>
        private AddClubView addClubView;

        private MatchView matchView;

        /// <summary>
        /// The view that allows you to add players
        /// </summary>
        private AddPlayerView addPlayerView;

        private Stack<UserControl> history;
        
        public MainWindow()
        {
            InitializeComponent();
            history = new Stack<UserControl>();
            mainView = new MainView();
            ViewBox.Child = mainView;
            clubView = new ClubView();
            playerView = new PlayerView();
            addClubView = new AddClubView();
            addPlayerView = new AddPlayerView();
            matchView = new MatchView();
        }

        /// <summary>
        /// Handles Button clicks in the application
        /// </summary>
        /// <param name="sender">The button which was clicked</param>
        /// <param name="e"></param>
        private void HandleClick(object sender, RoutedEventArgs e)
        {
            if(e.OriginalSource is Button b)
            {
                switch (b.Name) {
                    case "ViewClubsButton":
                        history.Push(ViewBox.Child as UserControl);
                        ViewBox.Child = clubView;
                        break;
                    case "ViewPlayersButton":
                        history.Push(ViewBox.Child as UserControl);
                        ViewBox.Child = playerView;
                        break;
                    case "AddClubsButton":
                        history.Push(ViewBox.Child as UserControl);
                        ViewBox.Child = addClubView;
                        break;
                    case "AddPlayersButton":
                        history.Push(ViewBox.Child as UserControl);
                        ViewBox.Child = addPlayerView;
                        break;
                    case "BackButton":
                        ViewBox.Child = history.Pop();
                        break;
                }
                e.Handled = true;
            }
        }

        private void DataGridSelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if(e.OriginalSource is DataGrid dg)
            {
                if(dg.SelectedItem is MatchesForClub mfc)
                {
                    matchView.SetDataContext(mfc.GetMatchID());
                    history.Push(ViewBox.Child as UserControl);
                    ViewBox.Child = matchView;
                }
            }
        }
    }
}
