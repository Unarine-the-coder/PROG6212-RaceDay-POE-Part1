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

-- ============================================================
-- 6. ENROLMENT TABLE
-- ============================================================
CREATE TABLE [Enrolment] (
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId INT NOT NULL,
    EventCategoryId INT NOT NULL,
    EnrolmentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Active',
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- ============================================================
-- 7. RESULT TABLE
-- ============================================================
CREATE TABLE [Result] (
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL,
    Score DECIMAL(5,2) NULL,
    Grade NVARCHAR(10) NULL,
    Remarks NVARCHAR(MAX) NULL,
    DateRecorded DATETIME DEFAULT GETDATE()
);
GO

-- ============================================================
-- FOREIGN KEYS AND CONSTRAINTS
-- ============================================================

-- Event: OrganiserId references User
ALTER TABLE [Event] ADD CONSTRAINT FK_Event_Organiser FOREIGN KEY (OrganiserId) REFERENCES [User](UserId) ON DELETE CASCADE;

-- EventCategory: EventId references Event
ALTER TABLE [EventCategory] ADD CONSTRAINT FK_EventCategory_Event FOREIGN KEY (EventId) REFERENCES [Event](EventId) ON DELETE CASCADE;

-- EventCategory: CategoryId references Category
ALTER TABLE [EventCategory] ADD CONSTRAINT FK_EventCategory_Category FOREIGN KEY (CategoryId) REFERENCES [Category](CategoryId) ON DELETE CASCADE;

-- EventCategory: Unique constraint to prevent duplicates
ALTER TABLE [EventCategory] ADD CONSTRAINT UQ_EventCategory_Event_Category UNIQUE (EventId, CategoryId);

-- Enrolment: ParticipantId references User
ALTER TABLE [Enrolment] ADD CONSTRAINT FK_Enrolment_Participant FOREIGN KEY (ParticipantId) REFERENCES [User](UserId) ON DELETE CASCADE;

-- Enrolment: EventCategoryId references EventCategory
ALTER TABLE [Enrolment] ADD CONSTRAINT FK_Enrolment_EventCategory FOREIGN KEY (EventCategoryId) REFERENCES [EventCategory](EventCategoryId) ON DELETE CASCADE;

-- Enrolment: Unique constraint to prevent duplicate enrolments
ALTER TABLE [Enrolment] ADD CONSTRAINT UQ_Enrolment_Participant_Category UNIQUE (ParticipantId, EventCategoryId);

-- Enrolment: Check constraint for Status
ALTER TABLE [Enrolment] ADD CONSTRAINT CHK_Enrolment_Status CHECK (Status IN ('Active', 'Cancelled', 'Completed'));

-- Result: EnrolmentId references Enrolment
ALTER TABLE [Result] ADD CONSTRAINT FK_Result_Enrolment FOREIGN KEY (EnrolmentId) REFERENCES [Enrolment](EnrolmentId) ON DELETE CASCADE;

-- ============================================================
-- SEED DATA
-- ============================================================

-- Insert Roles
INSERT INTO [Role] (RoleName, Description) VALUES
('Organiser', 'Can create, edit, and delete events, manage categories, capture results.'),
('Participant', 'Can browse events, enrol, view own enrolments and results.');
GO

-- Insert Users (2 Organisers, 2 Participants)
INSERT INTO [User] (FirstName, LastName, Email, PasswordHash, PhoneNumber, DateOfBirth) VALUES
('John', 'Doe', 'john.organiser@raceday.co.za', 'hashed_pw_1', '0821234567', '1980-05-15'),
('Jane', 'Smith', 'jane.organiser@raceday.co.za', 'hashed_pw_2', '0839876543', '1975-11-20'),
('Alice', 'Mokoena', 'alice.runner@raceday.co.za', 'hashed_pw_3', '0712345678', '1990-06-10'),
('Peter', 'van der Merwe', 'peter.runner@raceday.co.za', 'hashed_pw_4', '0723456789', '1985-09-25');
GO