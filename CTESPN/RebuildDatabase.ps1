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
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Schemas\MLS.sql"

Write-Host "Creating tables..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.PlayerTypes.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Players.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Goalkeepers.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Outfielders.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Clubs.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.ClubPlayers.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchClubTypes.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Matches.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchClubs.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchClubPlayers.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchGoalkeeperStats.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchOutfielderStats.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchEvents.sql"

# Write-Host "Stored procedures..."
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.CreatePerson.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.RetrievePersons.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.FetchPerson.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.GetPerson.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.SavePersonAddress.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.RetrieveAddressesForPerson.sql"

Write-Host "Inserting data..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Data\MLS.MatchClubTypes.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Data\MLS.PlayerTypes.sql"

Write-Host "Rebuild completed."
Write-Host ""

Set-Location $CurrentDrive
