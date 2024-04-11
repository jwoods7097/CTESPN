IF NOT EXISTS
    (
        SELECT *
        FROM sys.schemas s
        where s.[name] = N'MLS'
    )
BEGIN  
    EXEC(N'CREATE SCHEMA [MLS] AUTHORIZATION [dbo]');
END;