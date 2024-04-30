Param(
   [string] $Server = "(localdb)\MSSQLLocalDb",
   [string] $Database = "CTESPN"
)

# This script requires the SQL Server module for PowerShell.
# The below commands may be required.

# To check whether the module is installed.
# Get-Module -ListAvailable -Name SqlServer;

# Install the SQL Server Module
# Install-Module -Name SqlServer -Scope CurrentUser

$CurrentDrive = (Get-Location).Drive.Name + ":"
Set-Location $CurrentDrive

Write-Host ""
Write-Host "Rebuilding database $Database on $Server..."

<#
   If on your local machine, you can drop and re-create the database.
#>
& ".\Scripts\DropDatabase.ps1" -Database $Database
& ".\Scripts\CreateDatabase.ps1" -Database $Database

Write-Host "Creating schema..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Schemas\MLS.sql"

Write-Host "Creating tables..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.PlayerType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.Player.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.Goalkeeper.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.Outfielder.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.Club.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.ClubPlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.MatchClubType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.Match.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.MatchClub.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.MatchClubPlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.MatchGoalkeeperStats.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.MatchOutfielderStats.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables\MLS.MatchEvent.sql"

Write-Host "Stored procedures..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.CreatePlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.RetrievePlayers.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.RetrieveClubPlayers.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.RetrieveClubs.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.RetrieveMatchesWithClubs.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.CreateClubPlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.CreateMatch.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.CreateMatchClubPlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.CreateMatchEvent.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.CreateMatchClub.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.CareerStats.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.ClubCards.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.MatchFoulsRanking.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.TopClubGoalScorers.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.RetrieveOpponentClubs.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.RetrieveYears.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.CreateClub.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetMatchesForClub.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetMatchesForPlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetMatchesForPlayerWithOpponent.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetClubForPlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetMatchesForClubWithOpponent.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetAllPlayersInMatch.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetPlayersInMatchFromClub.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetMatch.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetMatchEvents.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Procedures\MLS.GetPlayerStatsForMatch.sql"

Write-Host "Inserting data..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Data\MLS.MatchClubType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Data\MLS.PlayerType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Data\MLS.Club.sql"
python Data\SQL\Data\InsertBCPData.py

Write-Host "Rebuild completed."
Write-Host ""
