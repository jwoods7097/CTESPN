namespace Data.Models
{
    public class Club
    {
        public int ClubID { get; }
        public string Name { get; }
        public string Abbreviation { get; }
        public string HomeLocation { get; }
        public string Conference { get; }

        public Club(int clubID, string name, string abbreviation, string homeLocation, string conference)
        {
            ClubID = clubID,
            Name = name;
            Abbreviation = abbreviation;
            HomeLocation = homeLocation;
            Conference = conference;
        }
    }
}