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
        
        public MainWindow()
        {
            InitializeComponent();
            mainView = new MainView();
            ViewBox.Child = mainView;
            clubView = new ClubView();
            playerView = new PlayerView();
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
                        ViewBox.Child = clubView;
                        break;
                    case "ViewPlayersButton":
                        ViewBox.Child = playerView;
                        break;
                    case "BackButton":
                        ViewBox.Child = mainView;
                        break;
                }
                e.Handled = true;
            }
        }
    }
}
