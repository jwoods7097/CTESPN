namespace Data.Models
{
    public class MatchesForPlayer
    {
        public string PlayerName { get; }
        public int ClubID { get; }
        public string ClubName { get; }
        public string OpponentClubName { get; }
        public MatchClubType HomeOrAway { get; }
        public int MatchID { get; }
        public DateOnly Date { get; }
        public string Location { get; }
        public string Formation { get; }
        public int Score { get; }
        public int OpponentScore { get; }
        public int Attendance { get; }

        public MatchesForPlayer(string playername, int clubid, string clubname, string opponentclubname, MatchClubType hoa, int matchid, DateOnly date, string location, string formation, int score, int opponentscore, int attendance)
        {
            PlayerName = playername;
            ClubID = clubid;
            ClubName = clubname;
            OpponentClubName = opponentclubname;
            HomeOrAway = hoa;
            MatchID = matchid;
            Date = date;
            Location = location;
            Formation = formation;
            Score = score;
            OpponentScore = opponentscore;
            Attendance = attendance;
        }
    }
}