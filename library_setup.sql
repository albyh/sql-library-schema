IF NOT EXISTS (SELECT * FROM sys.databases WHERE [name] = 'dbTechAcadLibrary')
  BEGIN
	CREATE DATABASE dbTechAcadLibrary
	PRINT 'dbTechAcadLibrary Created'
	--GO
  END

USE dbTechAcadLibrary

/*
CREATE SCHEMA [TechAcad] AUTHORIZATION [dbo]
GO
*/

--Create TABLES 
     
IF object_id('Publisher','U') IS NOT NULL
	BEGIN
		DROP TABLE Publisher
		--GO
	END

CREATE TABLE Publisher
(
Name varchar(50) PRIMARY KEY NOT NULL,
Address varchar(50),
Phone nchar(10)
)	
PRINT 'dbo.Publisher Created'
GO

IF object_id('Book','U') IS NOT NULL
	BEGIN
		DROP TABLE Book
		--GO
	END
CREATE TABLE Book
(
BookId int PRIMARY KEY NOT NULL IDENTITY(1,1),
Title varchar(50) NOT NULL,
PublisherName varchar(50) NOT NULL,
FOREIGN KEY(PublisherName) REFERENCES Publisher(Name) 
ON UPDATE CASCADE
ON DELETE CASCADE
)	
PRINT 'dbo.Book Created'
GO

	
IF object_id('Library_Branch','U') IS NOT NULL 
	BEGIN
		DROP TABLE Library_Branch
		--GO
	END
CREATE TABLE Library_Branch
(
BranchId int PRIMARY KEY NOT NULL IDENTITY(11000,1000),
BranchName varchar(50) NOT NULL,
[Address] varchar(50)
)	
PRINT 'dbo.Library_Branch Created'
GO
     

IF object_id('Borrower','U') IS NOT NULL
	BEGIN
		DROP TABLE Borrower
		--GO
	END
CREATE TABLE Borrower
(
CardNo int PRIMARY KEY NOT NULL IDENTITY(1000,1),
Name varchar(50) NOT NULL,
[Address] varchar(50),
Phone nchar(10) 
)	
PRINT 'dbo.Borrower Created'
GO     

IF object_id('Book_Copies','U') IS NOT NULL
	BEGIN
		DROP TABLE Book_Copies
		--GO
	END

CREATE TABLE Book_Copies
(
BookId int NOT NULL,
BranchId int NOT NULL,
No_Of_Copies int NOT NULL,
FOREIGN KEY(BookId) REFERENCES Book(BookId)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY(BranchId) REFERENCES Library_Branch(BranchId)
ON UPDATE CASCADE
ON DELETE CASCADE
)	
PRINT 'dbo.Book_Copies Created'
GO
     
IF object_id('Book_Authors','U') IS NOT NULL
	BEGIN
		DROP TABLE Book_Authors
		--GO
	END

CREATE TABLE Book_Authors
(
BookId int NOT NULL,
AuthorName varchar(50) NOT NULL,
FOREIGN KEY(BookId) REFERENCES Book(BookId)
ON UPDATE CASCADE
ON DELETE CASCADE
)	
PRINT 'dbo.Book_Authors Created'
GO
	     
IF object_id('Book_Loans','U') IS NOT NULL
	BEGIN
		DROP TABLE Book_Loans
		--GO
	END

CREATE TABLE Book_Loans
(
BookId int NOT NULL,
BranchId int NOT NULL,
CardNo int NOT NULL,
DateOut date,
DueDate date,
FOREIGN KEY(BookId) REFERENCES Book(BookId)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY(BranchId) REFERENCES Library_Branch(BranchId)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY(CardNo) REFERENCES Borrower(CardNo)
ON UPDATE CASCADE
ON DELETE CASCADE
)	
GO
PRINT 'dbo.Book_Loans Created'


--Populate tables
INSERT INTO Publisher ([Name],[Address])
VALUES
('Penguin','24 E 5th Ave, New York'),
('Hachette', '555 W 52nd St, New York'),
('Harper', '235 E Broadway St, New York')

INSERT INTO Book (Title,PublisherName)
VALUES 
('The Lost Tribe', 'Penguin'),
('Gone With the Wind', 'Hachette'),
('Hunger Games', 'Hachette'),
('To Kill a Mockingbird', 'Penguin'),
('Pride & Prejudice', 'Hachette'),
('Twilight', 'Hachette'),
('Animal Farm', 'Hachette'),
('The Book Thief', 'Penguin'),
('The Giving Tree', 'Penguin'),
('Hitchhiker''s Guide', 'Harper'),
('Fault in Our Stars', 'Harper'),
('Hobbit', 'Harper'),
('Lord of the Rings', 'Penguin'),
('Wuthering Heights', 'Penguin'),
('The da Vinci Code', 'Penguin'),
('Alice in Wonderland', 'Penguin'),
('Divergent', 'Harper'),
('The Picture of Dorian Gray', 'Harper'),
('Lord of the Flies', 'Harper'),
('Ender''s Game', 'Harper'),
('The Alchemist', 'Penguin'),
('Time Traveler''s Wife', 'Penguin'),
('Crime & Punishment', 'Harper'),
('Jane Eyre', 'Hachette'),
('Charlotte''s Web', 'Penguin'),
('The Stand', 'Hachette'),
('City of Bones', 'Harper'),
('11/22/63', 'Hachette')
PRINT 'dbo.Books populated'

INSERT INTO Library_Branch (BranchName, [Address])
VALUES 
('Sharpstown','12300 Main St'),
('Westview','5584 West Ave.'),
('Central','24 1st St'),
('Northtown','935 North St.')
PRINT 'dbo.Library_Branch populated'

INSERT INTO Book_Authors (BookId, AuthorName)
VALUES 
(1,'Mark Lee'),
(2,'Margaret Mitchell'),
(3,'Suzanne Collins'),
(4,'Harper Lee'),
(5,'Jane Austen'),
(6,'Stephenie Meyer'),
(7,'George Orwell'),
(8,'Markus Zusak'),
(9,'Shel Silverstein'),
(10,'Douglas Adams'),
(11,'John Green'),
(12,'JRR Tolkien'),
(13,'JRR Tolkien'),
(14,'Emily Bronte'),
(15,'Dan Brown'),
(16,'Lewis Carroll'),
(17,'Veronica Roth'),
(18,'Oscar Wilde'),
(19,'William Golding'),
(20,'Orson Scott Card'),
(21,'Paulo Coelho'),
(22,'Audrey Niffenegger'),
(23,'Fyodor Dostoyevsky'),
(24,'Charlotte Bronte'),
(25,'EB White'),
(26,'Stephen King'),
(27,'Casandra Clare'),
(28,'Stephen King')
PRINT 'dbo.Authors populated'

INSERT INTO Borrower ([Name],[Address])
VALUES 
('Imma Reader', '2464 NE Division St'),
('Timmy Kindle', '43 N Smith Ave.'),
('Betty Simmons', '2523 NE Market St.'),
('Marcus Lee', '24 N Williams Ave.'),
('Jane Austen', '6543 NE Denton St.'),
('Stephenie Meyer', '240 SE Swail Ave.'),
('George Orton', '2308 SE Greystone St.'),
('Martin Zell', '953 SE Carlton Ave.'),
('Sheila Wozniak', '2021 SE Milwaukie Ave'),
('Dan Smith', '2409 SW 45th Ave.'),
('John Dunn', '9953 SW 24th Ave.'),
('Terry Dunn', '08 SW River Pkwy'),
('Candy Cane', '493 SW Hood St.'),
('Allison Reynolds', '4089 SW Tanager Dr.'),
('Freddy Krueger', '23049 NW Moonbeam Ln.'),
('Minnie Mouse', '3409 NW Tacoma St.'),
('George Carlin', '8984 NW Miller Rd.'),
('Marcus Aurelius', '8842 NW Cornelius St.'),
('Felix Unger', '23445 NE Betheny Ave.'),
('Betty Rubble', '409 SE Stone Ln.'),
('John Slate', '492 SE Bonita Rd.'),
('Gary Gumbel', '0459 SW Livery Rd.'),
('Rudolph Valentino', '893 SE Tonaka Rd.'),
('Steve McQueen', '8349 NW Broadway Ave.'),
('Gary Carter', '408 NW Beaverton Rd.')
PRINT 'dbo.Borrower populated'

/*
FOR TESTING
	USE MASTER
	DROP DATABASE dbTechAcadLibrary
	DROP TABLE Book_Loans
	DROP TABLE Book_Copies
	DROP TABLE Borrower
	DROP TABLE Library_Branch
	DROP TABLE Book_Authors
	DROP TABLE Book
	DROP TABLE Publisher
*/
  