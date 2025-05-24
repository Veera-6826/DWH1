/*

===============================================
BLAH BLAH BLAH ABOUT THE DATABASE
===============================================

*/


USE MASTER;
GO  

-- Drop the existing data base if exists and create new
IF EXISTS(SELECT 1 FROM sys.database WHERE name = 'Datawarehouse')
BEGIN 
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse;
END;
GO
--Create a new database 'Datawarehouse'
CREATE DATABASE Datawarehouse;
GO

USE Datawarehouse
GO

--Create schemas

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

