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

Write-Host "Inserting data..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Data\MLS.MatchClubType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Data\MLS.PlayerType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Data\MLS.Club.sql"

Write-Host "Rebuild completed."
Write-Host ""

Set-Location $CurrentDrive
