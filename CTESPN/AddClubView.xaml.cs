﻿using Data;
using System;
using System.Collections.Generic;
using System.DirectoryServices.ActiveDirectory;
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
    /// Interaction logic for AddClubView.xaml
    /// </summary>
    public partial class AddClubView : UserControl
    {
        public AddClubView()
        {
            InitializeComponent();
        }

        private void AddClubButton_Click(object sender, RoutedEventArgs e)
        {
            string name = NameTextBox.Text;
            string abbreviation = AbbreviationTextBox.Text;
            string location = LocationTextBox.Text;
            string conference = (bool)EasternButton.IsChecked ? "Eastern" : "Western";

            SqlClubRepository repo = new SqlClubRepository();

            repo.CreateClub(name, abbreviation, location, conference);

            MessageBoxResult result = MessageBox.Show("Successfully added club", "Success", MessageBoxButton.OK);
            if (result == MessageBoxResult.OK)
            {
                NameTextBox.Clear();
                AbbreviationTextBox.Clear();
                LocationTextBox.Clear();
                EasternButton.IsChecked = true;
            }
        }
    }
}
