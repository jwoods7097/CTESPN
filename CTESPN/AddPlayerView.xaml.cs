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
using Data;
using Data.Models;

namespace CTESPN
{
    /// <summary>
    /// Interaction logic for AddPlayerView.xaml
    /// </summary>
    public partial class AddPlayerView : UserControl
    {
        static int playerid = 0;

        public AddPlayerView()
        {
            DataContext = new SqlClubRepository();
            InitializeComponent();
            PositionComboBox.ItemsSource = Enum.GetValues(typeof(Data.Models.PlayerType)).Cast<Data.Models.PlayerType>();
        }

        private void AddPlayerButton_Click(object sender, RoutedEventArgs e)
        {
            playerid++;
            string name = NameTextBox.Text;
            int club = ((Club)ClubComboBox.SelectedItem).ClubID;
            PlayerType pt = (PlayerType)PositionComboBox.SelectedItem;
            string position = PositionComboBox.Text;

            SqlPlayerRepository repo1 = new SqlPlayerRepository();

            Player p = repo1.CreatePlayer(playerid, pt, name, position);

            SqlClubPlayerRepository repo2 = new SqlClubPlayerRepository();

            repo2.CreateClubPlayer(playerid, pt, club);

            MessageBoxResult result = MessageBox.Show("Successfully added player to club", "Success", MessageBoxButton.OK);
            if (result == MessageBoxResult.OK)
            {
                NameTextBox.Clear();
                ClubComboBox.SelectedIndex = -1;
                PositionComboBox.SelectedIndex = -1;
            }
        }
    }
}
