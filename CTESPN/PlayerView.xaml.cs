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

namespace CTESPN
{
    /// <summary>
    /// Interaction logic for PlayerView.xaml
    /// </summary>
    public partial class PlayerView : UserControl
    {
        private const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=CTESPN;Integrated Security=SSPI;";

        public PlayerView()
        {
            InitializeComponent();
            this.DataContext = new SqlPlayerRepository(connectionString);
        }
    }
}
