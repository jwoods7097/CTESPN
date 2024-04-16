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
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.PlayerType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Player.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Goalkeeper.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Outfielder.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Club.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.ClubPlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchClubType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.Match.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchClub.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchClubPlayer.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchGoalkeeperStats.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchOutfielderStats.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Tables\MLS.MatchEvent.sql"

# Write-Host "Stored procedures..."
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.CreatePerson.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.RetrievePersons.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.FetchPerson.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.GetPerson.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.SavePersonAddress.sql"
# Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "PersonData\Sql\Procedures\Person.RetrieveAddressesForPerson.sql"

Write-Host "Inserting data..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Data\MLS.MatchClubType.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "SQL\Data\MLS.PlayerType.sql"

Write-Host "Rebuild completed."
Write-Host ""

Set-Location $CurrentDrive
