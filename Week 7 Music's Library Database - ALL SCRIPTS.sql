USE [master]
GO
/****** Object:  Database [Music's Library Database]    Script Date: 11/25/2019 2:53:11 PM ******/

/* Creates Music's Library Database */
CREATE DATABASE [Music's Library Database]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Music''s Library Database', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Music''s Library Database.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Music''s Library Database_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Music''s Library Database_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Music's Library Database] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Music's Library Database].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Music's Library Database] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Music's Library Database] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Music's Library Database] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Music's Library Database] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Music's Library Database] SET ARITHABORT OFF 
GO
ALTER DATABASE [Music's Library Database] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Music's Library Database] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Music's Library Database] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Music's Library Database] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Music's Library Database] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Music's Library Database] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Music's Library Database] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Music's Library Database] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Music's Library Database] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Music's Library Database] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Music's Library Database] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Music's Library Database] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Music's Library Database] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Music's Library Database] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Music's Library Database] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Music's Library Database] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Music's Library Database] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Music's Library Database] SET RECOVERY FULL 
GO
ALTER DATABASE [Music's Library Database] SET  MULTI_USER 
GO
ALTER DATABASE [Music's Library Database] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Music's Library Database] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Music's Library Database] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Music's Library Database] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Music's Library Database] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Music''s Library Database', N'ON'
GO
ALTER DATABASE [Music's Library Database] SET QUERY_STORE = OFF
GO
USE [Music's Library Database]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Music's Library Database]
GO
/****** Object:  UserDefinedFunction [dbo].[getFormattedDate]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* This creates the function to format dates so that the date shows with the day of the week, day, month and year */
CREATE FUNCTION [dbo].[getFormattedDate]
(
@DateValue AS DATETIME
)
RETURNS VARCHAR(MAX)
AS 
BEGIN 
RETURN 
DATENAME(DW, @DateValue) + ','+
DATENAME (DAY, @DateValue)+' '+
DATENAME (MONTH, @DateValue)+','+
DATENAME (YEAR, @DateValue)
END; 
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Below code creates the Authors Table. No nulls are allowed. The Primary Key is the AuthorID */
CREATE TABLE [dbo].[Authors](
	[AuthorID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Library_Authors]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* This code creates a view for the Authors Table called Library_Authors */
CREATE VIEW [dbo].[Library_Authors] AS
SELECT AuthorID, FirstName, LastName
FROM Authors; 
GO
/****** Object:  Table [dbo].[Books]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Below code creates the Books Table. The only null allowed is the DatePulished. The Primary key is the ISBN */
CREATE TABLE [dbo].[Books](
	[ISBN] [int] NOT NULL,
	[BookTitle] [nvarchar](max) NOT NULL,
	[DatePublished] [date] NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Library_Books]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* This creates a view for the Books Table called Library_Books  */
CREATE VIEW [dbo].[Library_Books]
AS
SELECT        ISBN, BookTitle, DatePublished
FROM            dbo.Books
GO
/****** Object:  Table [dbo].[BooksAuthors]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* Below code creates the table that links the Books and Authors table: BooksAuhors. This many to many relationship is created by the foreign keys ISBN and AuthorID */
CREATE TABLE [dbo].[BooksAuthors](
	[ISBN] [int] NOT NULL,
	[AuthorID] [int] NOT NULL,
 CONSTRAINT [PK_BooksAuthors] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC,
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[List_Books_Authors]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* This creates the view for the BooksAuthors called Library_Books_Authors   */
CREATE VIEW [dbo].[Library_Books_Authors] AS 
SELECT ISBN, AuthorID
FROM BooksAuthors; 
GO
/****** Object:  Table [dbo].[BooksCategories]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* Below code creates the table that links Books and Categories table:BooksCategories. This many to many relationship is created by the foreign keys ISBN and CategoryID  */ 
CREATE TABLE [dbo].[BooksCategories](
	[ISBN] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_BooksCategories] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Library_Books_Categories]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* This code creates the view for the BooksCategories table called Library_Books_Categories  */
CREATE VIEW [dbo].[Library_Books_Categories] AS
SELECT ISBN, CategoryID
FROM BooksCategories; 
GO
/****** Object:  Table [dbo].[BooksOutOnLoan]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*Below table creates the BooksOutOnLoan table. The only null value allowed is the DateReturned value. The primary key is ISBN and it has a foreign key CardID which is related to the Patrons table */
CREATE TABLE [dbo].[BooksOutOnLoan](
	[ISBN] [int] NOT NULL,
	[CardID] [int] NOT NULL,
	[DateCheckedOut] [date] NOT NULL,
	[DateReturned] [date] NULL,
 CONSTRAINT [PK_BooksOutOnLoan] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Loaned_Books]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* This code creates the view for the BooksOutOnLoan table called Loaned_Books  */
CREATE VIEW [dbo].[Loaned_Books] AS 
SELECT ISBN, CardID, DateCheckedOut, DateReturned
FROM BooksOutOnLoan;
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Below table creates the Categories table. The primary key is the CategoryID */
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Library_Categories]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* This code creates the view for the Categories table called Library_Categories */
CREATE VIEW [dbo].[Library_Categories] AS 
SELECT CategoryID, CategoryName
FROM Categories; 
GO
/****** Object:  View [dbo].[Book_AuthorName]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* This is the last table of the database. It is the Patrons table and the primary key is the CardID. The only null value allowed is the email address   */
CREATE TABLE [dbo].[Patrons](
	[CardID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[Zip] [varchar](10) NOT NULL,
	[PhoneNumber] [int] NOT NULL,
	[EmailAddress] [nvarchar](100) NULL,
 CONSTRAINT [PK_Patrons] PRIMARY KEY CLUSTERED 
(
	[CardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Library_Patrons]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* This creates the view for the Patrons table called Library_Patrons */
CREATE VIEW [dbo].[Library_Patrons] AS 
SELECT CardID, FirstName, LastName, Address, Zip, PhoneNumber, EmailAddress
FROM Patrons;
GO


/* The code below inserts the Author ID and Author First Name and Last Name into the Authors Table */
SET IDENTITY_INSERT [dbo].[Authors] ON 

INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (1, N'Julie', N'Garwood')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (2, N'Emily', N'Giffin')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (3, N'Stephen', N'King')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (4, N'Edward D.', N'Hess')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (5, N'Jon', N'Roberts')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (6, N'Hampton', N'Sides')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (7, N'Iris', N'Chang')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (8, N'Gregory', N'Maguire')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (9, N'Dan', N'Brown')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (10, N'T.H.', N'White')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (11, N'Patricia', N'Cornwell')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (12, N'James', N'Patterson')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (13, N'Peter', N'Straub')
INSERT [dbo].[Authors] ([AuthorID], [FirstName], [LastName]) VALUES (14, N'Katherine', N'Ludwig')

/* The following code inserts the ISBN, Book Title, Date Published into the Books table */

SET IDENTITY_INSERT [dbo].[Authors] OFF
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (1, N'The Rape of Nanking', CAST(N'1997-09-12' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (2, N'American Desperado', CAST(N'2011-05-31' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (3, N'Blood and Thunder', CAST(N'2006-06-21' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (4, N'Humility is Smart', CAST(N'2017-12-01' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (5, N'Something Blue', CAST(N'2005-02-20' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (6, N'The Talisman', CAST(N'1984-09-20' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (7, N'The Once and Future King', CAST(N'1966-07-01' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (8, N'Christine', CAST(N'1983-03-13' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (9, N'The Secret', CAST(N'1992-01-01' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (10, N'Wicked', CAST(N'1996-11-01' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (11, N'Son of a Witch', CAST(N'2008-10-31' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (12, N'Scarpetta', CAST(N'2008-12-22' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (13, N'Four Blind Mice', CAST(N'2002-09-13' AS Date))
INSERT [dbo].[Books] ([ISBN], [BookTitle], [DatePublished]) VALUES (14, N'The Lost Symbol', CAST(N'2009-01-01' AS Date))


/*The following code inserts the ISBN and AuthorID into the BooksAuthors table  */
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (1, 7)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (2, 5)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (3, 6)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (4, 4)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (4, 14)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (5, 2)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (6, 3)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (6, 13)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (7, 10)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (8, 3)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (9, 1)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (10, 8)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (11, 8)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (12, 11)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (13, 12)
INSERT [dbo].[BooksAuthors] ([ISBN], [AuthorID]) VALUES (14, 9)

/* The following code inserts the ISBN and CategoryID for the BooksCategories table */
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (1, 3)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (1, 4)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (2, 3)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (2, 6)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (3, 4)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (4, 3)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (5, 1)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (6, 2)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (7, 5)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (8, 2)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (9, 1)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (10, 5)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (11, 5)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (12, 6)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (13, 6)
INSERT [dbo].[BooksCategories] ([ISBN], [CategoryID]) VALUES (14, 5)

/*The following code inserts the ISBN, CardID, DateCheckedOut and DateReturned values to the BooksOutOnLoan table  */
INSERT [dbo].[BooksOutOnLoan] ([ISBN], [CardID], [DateCheckedOut], [DateReturned]) VALUES (2, 1, CAST(N'2019-11-15' AS Date), NULL)
INSERT [dbo].[BooksOutOnLoan] ([ISBN], [CardID], [DateCheckedOut], [DateReturned]) VALUES  (5, 2, CAST(N'2018-10-13' AS Date), CAST(N'2018-10-30' AS Date))
INSERT [dbo].[BooksOutOnLoan] ([ISBN], [CardID], [DateCheckedOut], [DateReturned]) VALUES (3, 3, CAST(N'2019-05-01' AS Date), NULL)
INSERT [dbo].[BooksOutOnLoan] ([ISBN], [CardID], [DateCheckedOut], [DateReturned]) VALUES (13, 8, CAST(N'2019-09-01' AS Date), NULL)
INSERT [dbo].[BooksOutOnLoan] ([ISBN], [CardID], [DateCheckedOut], [DateReturned]) VALUES (1, 4, CAST(N'2019-07-01' AS Date), NULL)
INSERT [dbo].[BooksOutOnLoan] ([ISBN], [CardID], [DateCheckedOut], [DateReturned]) VALUES (11, 4, CAST(N'2018-10-02' AS Date), CAST(N'2018-10-10' AS Date))
INSERT [dbo].[BooksOutOnLoan] ([ISBN], [CardID], [DateCheckedOut], [DateReturned]) VALUES (4, 7, CAST(N'2017-09-20' AS Date), CAST(N'2017-10-02' AS Date))

/*The following code enters the CategoryID and CategoryName into the Categories field. There is an identity inserted for Category Name so no category can be repeated */
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (1, N'Romance')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (2, N'Horror')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (3, N'Non-Fiction')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (4, N'History')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (5, N'Fantasy')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (6, N'Crime')
SET IDENTITY_INSERT [dbo].[Categories] OFF

/* The following code inserts the CardID, FirstName, LastName, Address, Zip, PhoneNumber and Email Address into the Patrons table. There is an identity set for CardID so that no CardID can be repeated */
SET IDENTITY_INSERT [dbo].[Patrons] ON 

INSERT [dbo].[Patrons] ([CardID], [FirstName], [LastName], [Address], [Zip], [PhoneNumber], [EmailAddress]) VALUES (1, N'Ashley', N'Music', N'3744 Home St', N'23453', 8985768, N'ashleymusic@hotmail.com')
INSERT [dbo].[Patrons] ([CardID], [FirstName], [LastName], [Address], [Zip], [PhoneNumber], [EmailAddress]) VALUES (2, N'Tony', N'Costanza', N'3744 Home St', N'23453', 9857847, N'tonycostanza@hotmail.com')
INSERT [dbo].[Patrons] ([CardID], [FirstName], [LastName], [Address], [Zip], [PhoneNumber], [EmailAddress]) VALUES (3, N'Candice', N'Shelton', N'7384 Merry St', N'23453', 7337938, N'candiceshelton@hotmail.com')
INSERT [dbo].[Patrons] ([CardID], [FirstName], [LastName], [Address], [Zip], [PhoneNumber], [EmailAddress]) VALUES (4, N'Gregg', N'Shelton', N'7384 Merry St', N'23453', 8746352, N'greggshelton@hotmail.com')
INSERT [dbo].[Patrons] ([CardID], [FirstName], [LastName], [Address], [Zip], [PhoneNumber], [EmailAddress]) VALUES (7, N'Marilyn', N'Jones', N'789 Crooked Mile Rd', N'23453', 8498372, N'marilynjones@hotmail.com')
INSERT [dbo].[Patrons] ([CardID], [FirstName], [LastName], [Address], [Zip], [PhoneNumber], [EmailAddress]) VALUES (8, N'Jon', N'Jones', N'789 Crooked Mile Rd.. ', N'23453', 9830292, N'jonjones@hotmail.com')
SET IDENTITY_INSERT [dbo].[Patrons] OFF

/*The code below creates a foreign key relationship between Books and Books Out On Loan by the ISBN */
ALTER TABLE [dbo].[Books]  WITH NOCHECK ADD  CONSTRAINT [FK_Books_BooksOutOnLoan] FOREIGN KEY([ISBN])
REFERENCES [dbo].[BooksOutOnLoan] ([ISBN])
GO

/* The following code creates a foreign key relationship between Books and Authors by the AuthorID, it is set to Cascade from the parent table to the child table on both Delete and Update */
ALTER TABLE [dbo].[Books] NOCHECK CONSTRAINT [FK_Books_BooksOutOnLoan]
GO

/* The following code creates a foreign key relationship between Books and Authors by the  ISBN , it is set to Cascade from the parent table to the child table on both Delete and Update */
ALTER TABLE [dbo].[BooksAuthors]  WITH CHECK ADD  CONSTRAINT [FK_BooksAuthors_Authors] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Authors] ([AuthorID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BooksAuthors] CHECK CONSTRAINT [FK_BooksAuthors_Authors]
GO

/* The following code creates a foreign key relationship between Books and Categories by the ISBN , it is set to Cascade from the parent table to the child table on both Delete and Update */
ALTER TABLE [dbo].[BooksAuthors]  WITH CHECK ADD  CONSTRAINT [FK_BooksAuthors_Books] FOREIGN KEY([ISBN])
REFERENCES [dbo].[Books] ([ISBN])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BooksAuthors] CHECK CONSTRAINT [FK_BooksAuthors_Books]
GO

/* The following code creates a foreign key relationship between Books and Categories by the CategoryID , it is set to Cascade from the parent table to the child table on both Delete and Update */
ALTER TABLE [dbo].[BooksCategories]  WITH CHECK ADD  CONSTRAINT [FK_BooksCategories_Books] FOREIGN KEY([ISBN])
REFERENCES [dbo].[Books] ([ISBN])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BooksCategories] CHECK CONSTRAINT [FK_BooksCategories_Books]
GO


ALTER TABLE [dbo].[BooksCategories]  WITH CHECK ADD  CONSTRAINT [FK_BooksCategories_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BooksCategories] CHECK CONSTRAINT [FK_BooksCategories_Categories]
GO

/* The following code creates a foreign key relationship between Books out on Loan with Patrons by the  CategoryID , it is set to Cascade from the parent table to the child table on both Delete and Update */
ALTER TABLE [dbo].[BooksOutOnLoan]  WITH CHECK ADD  CONSTRAINT [FK_BooksOutOnLoan_Patrons] FOREIGN KEY([CardID])
REFERENCES [dbo].[Patrons] ([CardID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BooksOutOnLoan] CHECK CONSTRAINT [FK_BooksOutOnLoan_Patrons]
GO
/****** Object:  StoredProcedure [dbo].[AllCheckedOutBooks]    Script Date: 11/25/2019 2:53:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*The following code creates a procedure to show all of the books checked out in the Books Out On Loan table */
CREATE PROCEDURE [dbo].[AllCheckedOutBooks1] AS 
SELECT * FROM BooksOutOnLoan 
WHERE DateCheckedOut IS NOT Null AND DateReturned is NULL; 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Books"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Library_Books'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Library_Books'
GO
USE [master]
GO
ALTER DATABASE [Music's Library Database] SET  READ_WRITE 
GO
