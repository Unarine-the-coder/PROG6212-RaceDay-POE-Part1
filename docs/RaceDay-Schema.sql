-- ============================================================
-- Database: RaceDayDB
-- ============================================================
CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

-- ============================================================
-- 1. USER TABLE
-- ============================================================
CREATE TABLE [User] (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,
    DateOfBirth DATE NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- ============================================================
-- 2. ROLE TABLE
-- ============================================================
CREATE TABLE [Role] (
    RoleId INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(MAX) NULL
);
GO

-- ============================================================
-- 3. EVENTCATEGORY TABLE (Junction)
-- ============================================================
CREATE TABLE [EventCategory] (
    EventCategoryId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    CategoryId INT NOT NULL
);
GO

-- ============================================================
-- 4. EVENT TABLE
-- ============================================================
CREATE TABLE [Event] (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    EventName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    OrganiserId INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- ============================================================
-- 5. CATEGORY TABLE
-- ============================================================
CREATE TABLE [Category] (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO