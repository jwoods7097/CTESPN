# CTESPN: Common Table Expression Soccer Performance Navigator

## Project Structure

- CTESPN: The main C# WPF application

- Data: The data for the application
    - Data/SQL/Tables: All create table scripts
    - Data/SQL/Procedures: All procedures
    - Data/SQL/Data: All scripts to populate with initial data. Data for python script are in Data/SQL/CSV
    - All other non-SQL code is in Data (backend) and CTESPN (UI)

- Webmining: Python scripts used for web mining and data collection/presentation
- SentimentAnalysis: Python scripts used for sentiment analysis
