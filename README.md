# CTESPN: Common Table Expression Soccer Performance Navigator

## Project Structure

- CTESPN: The main C# WPF application
	- MainView is the Home Page of the application
	- ClubView is the page that shows club information, including players and matches
	- PlayerView shows specific information about players and their statistics
	- AddClubView is used to add a new club
	- AddPlayerView is used to insert a new player

- Data: The data for the application
	- Data/SQL/Tables: All create table scripts
	- Data/SQL/Schemas: Create schema script for MLS
	- Data/SQL/Procedures: All stored procedures
	- Data/SQL/Data: All scripts to populate with initial data. Data for python script are in Data/SQL/CSV
	- Data/SQL/CSV: The raw CSV files used to source data for populating the tables
	- Data/SQL/FMT: The scripts used for importing CSV information using BCP
	- All other non-SQL code is in Data (backend) and CTESPN (UI)

- DataAccess: Contains readers, delegates, and exceptions used in the process of reading data from the SQL tables into the application

- RawData: Excel spreadsheets containing information pulled from the Webmining scripts

- Scripts: SQL and Powershell scripts for creating/dropping database tables, as well as
		a Python script to structure CSV files

- Webmining: Python scripts used for web mining and data collection/presentation from the ESPN website,
		along with a .md file of links we used for webmining

- RebuildDatabase.ps1 is a Powershell script that can be used to drop and rebuild all tables from scratch

## How to Run

1. Run the `RebuildDatabase.ps1` script to build the database
2. Open the CTESPN solution in the CTESPN directory
3. Run the CTESPN project in Visual Studio
