USE [master]
GO

CREATE DATABASE [SignUpDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SignUpDb', FILENAME = N'C:\mssql\SignUpDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SignUpDb_log', FILENAME = N'C:\mssql\SignUpDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 08/02/2017 13:59:08
-- Generated from EDMX file: C:\scm\github\dockersamples\newsletter-signup\src\SignUp\SignUp.Web\Model\SignUpModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [SignUpDb];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_dbo_Prospects_dbo_Countries_Country_CountryCode]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Prospects] DROP CONSTRAINT [FK_dbo_Prospects_dbo_Countries_Country_CountryCode];
GO
IF OBJECT_ID(N'[dbo].[FK_dbo_Prospects_dbo_Roles_Role_RoleCode]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Prospects] DROP CONSTRAINT [FK_dbo_Prospects_dbo_Roles_Role_RoleCode];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Countries]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Countries];
GO
IF OBJECT_ID(N'[dbo].[Prospects]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Prospects];
GO
IF OBJECT_ID(N'[dbo].[Roles]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Roles];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Countries'
CREATE TABLE [dbo].[Countries] (
    [CountryCode] nvarchar(128)  NOT NULL,
    [CountryName] nvarchar(max)  NULL
);
GO

-- Creating table 'Prospects'
CREATE TABLE [dbo].[Prospects] (
    [ProspectId] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(max)  NULL,
    [LastName] nvarchar(max)  NULL,
    [CompanyName] nvarchar(max)  NULL,
    [EmailAddress] nvarchar(max)  NULL,
    [Country_CountryCode] nvarchar(128)  NULL,
    [Role_RoleCode] nvarchar(128)  NULL
);
GO

-- Creating table 'Roles'
CREATE TABLE [dbo].[Roles] (
    [RoleCode] nvarchar(128)  NOT NULL,
    [RoleName] nvarchar(max)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [CountryCode] in table 'Countries'
ALTER TABLE [dbo].[Countries]
ADD CONSTRAINT [PK_Countries]
    PRIMARY KEY CLUSTERED ([CountryCode] ASC);
GO

-- Creating primary key on [ProspectId] in table 'Prospects'
ALTER TABLE [dbo].[Prospects]
ADD CONSTRAINT [PK_Prospects]
    PRIMARY KEY CLUSTERED ([ProspectId] ASC);
GO

-- Creating primary key on [RoleCode] in table 'Roles'
ALTER TABLE [dbo].[Roles]
ADD CONSTRAINT [PK_Roles]
    PRIMARY KEY CLUSTERED ([RoleCode] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Country_CountryCode] in table 'Prospects'
ALTER TABLE [dbo].[Prospects]
ADD CONSTRAINT [FK_dbo_Prospects_dbo_Countries_Country_CountryCode]
    FOREIGN KEY ([Country_CountryCode])
    REFERENCES [dbo].[Countries]
        ([CountryCode])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_dbo_Prospects_dbo_Countries_Country_CountryCode'
CREATE INDEX [IX_FK_dbo_Prospects_dbo_Countries_Country_CountryCode]
ON [dbo].[Prospects]
    ([Country_CountryCode]);
GO

-- Creating foreign key on [Role_RoleCode] in table 'Prospects'
ALTER TABLE [dbo].[Prospects]
ADD CONSTRAINT [FK_dbo_Prospects_dbo_Roles_Role_RoleCode]
    FOREIGN KEY ([Role_RoleCode])
    REFERENCES [dbo].[Roles]
        ([RoleCode])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_dbo_Prospects_dbo_Roles_Role_RoleCode'
CREATE INDEX [IX_FK_dbo_Prospects_dbo_Roles_Role_RoleCode]
ON [dbo].[Prospects]
    ([Role_RoleCode]);
GO

-- --------------------------------------------------
-- Ref data
-- --------------------------------------------------

INSERT INTO Countries (CountryCode, CountryName) VALUES ('-', '--Not telling')
GO

INSERT INTO Countries (CountryCode, CountryName) VALUES ('GBR', 'United Kingdom')
GO

INSERT INTO Countries (CountryCode, CountryName) VALUES ('USA', 'United States')
GO

INSERT INTO Countries (CountryCode, CountryName) VALUES ('PT', 'Portugal')
GO

INSERT INTO Countries (CountryCode, CountryName) VALUES ('NOR', 'Norway')
GO

INSERT INTO Countries (CountryCode, CountryName) VALUES ('SWE', 'Sweden')
GO

INSERT INTO Countries (CountryCode, CountryName) VALUES ('IRE', 'Ireland')
GO

INSERT INTO Roles (RoleCode, RoleName) VALUES ('-', '--Not telling')
GO

INSERT INTO Roles (RoleCode, RoleName) VALUES ('DA', 'Developer Advocate')
GO

INSERT INTO Roles (RoleCode, RoleName) VALUES ('DM', 'Decision Maker')
GO

INSERT INTO Roles (RoleCode, RoleName) VALUES ('AC', 'Architect')
GO

INSERT INTO Roles (RoleCode, RoleName) VALUES ('EN', 'Engineer')
GO

INSERT INTO Roles (RoleCode, RoleName) VALUES ('OP', 'IT Ops')
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------