USE Master
GO
IF DB_ID('RH') IS NOT NULL
BEGIN
ALTER DATABASE RH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE RH
END
GO
CREATE DATABASE RH
GO
USE RH
GO


DROP TABLE IF EXISTS Patient;
CREATE TABLE Patient (
Id INT IDENTITY(1,1) PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
PatientTlfNr NVARCHAR (8) NOT NULL
);

DROP TABLE IF EXISTS Doktor;
CREATE TABLE Doktor (
Id INT IDENTITY(1,1) PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Speciale;
CREATE TABLE Speciale (
Id INT IDENTITY(1,1) PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL,
DoktorId INT FOREIGN KEY REFERENCES Doktor(Id)
);

DROP TABLE IF EXISTS TilDeltDoktor;
CREATE TABLE TilDeltDoktor (
Id INT IDENTITY(1,1) PRIMARY KEY,
PatientId INT FOREIGN KEY REFERENCES Patient(Id),
SpecialeId INT FOREIGN KEY REFERENCES Speciale(Id)
);

USE master;
GO
ALTER LOGIN sa WITH PASSWORD = 'Passw0rd';
GO
ALTER LOGIN sa ENABLE;
GO
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode', REG_DWORD, 2;
GO

CREATE LOGIN Niels WITH PASSWORD = 'Passw0rd', CHECK_POLICY = OFF;

USE RH;
GO
CREATE USER Niels FOR LOGIN Niels;
GO

USE RH;
GO
EXEC sp_addrolemember 'db_owner', 'Niels';
GO

CREATE LOGIN Ole WITH PASSWORD = 'Passw0rd', CHECK_POLICY = OFF;

USE RH;
GO
CREATE USER Ole FOR LOGIN Ole;
GO

USE RH
GO
EXEC sp_addrolemember 'db_datareader', 'Ole';
GO

