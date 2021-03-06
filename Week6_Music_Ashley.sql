USE [master]
GO
/****** Object:  Database [EmployeeDW]    Script Date: 6/14/2020 12:34:59 PM ******/
CREATE DATABASE [EmployeeDW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeDW', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EmployeeDW.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EmployeeDW_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EmployeeDW_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EmployeeDW] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeDW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeDW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeDW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeDW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeDW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeDW] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeDW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeeDW] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeDW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeDW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeDW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeDW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeDW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeDW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeDW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeDW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeDW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeeDW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeDW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeDW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeDW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeDW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeDW] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeDW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeDW] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmployeeDW] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeDW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeDW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeDW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeDW] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EmployeeDW]
GO
/****** Object:  Table [dbo].[Dim - Date]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dim - Date](
	[DateKey] [int] NOT NULL,
	[FullDateDescription] [nvarchar](max) NOT NULL,
	[DayofWeek] [nvarchar](50) NOT NULL,
	[Day#inCalendarYear] [int] NOT NULL,
	[MonthKey] [int] NOT NULL,
	[Quarter] [int] NOT NULL,
	[HolidayIndicator] [char](10) NOT NULL,
	[WeekdayIndicator] [char](10) NOT NULL,
 CONSTRAINT [PK_Dim - Date] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Dim - Department Dimension]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim - Department Dimension](
	[DepartmentKey] [int] NOT NULL,
	[DepartmentName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Dim - Department Dimension] PRIMARY KEY CLUSTERED 
(
	[DepartmentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dim - Employee Dimension]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim - Employee Dimension](
	[EmployeeKey] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ManagerKey] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[BirthDateKey] [datetime] NOT NULL,
	[Gender] [nchar](10) NULL,
	[DepartmentKey] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Salary] [money] NOT NULL,
	[OriginalHireDateKey] [int] NOT NULL,
	[ChangeReasonCode] [nvarchar](50) NULL,
	[ChangeReasonDescription] [nvarchar](max) NULL,
	[RowEffectiveDateKey] [int] NOT NULL,
	[RowExpirationDateKey] [int] NULL,
	[CurrentRowIndicator] [int] NOT NULL,
 CONSTRAINT [PK_Dim - Employee Dimension] PRIMARY KEY CLUSTERED 
(
	[EmployeeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dim - Month Dimension]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dim - Month Dimension](
	[MonthKey] [int] NOT NULL,
	[CalendarMonthName] [varchar](50) NOT NULL,
	[CalendarMonthNumber] [int] NOT NULL,
	[CalendarYYYYMM] [int] NOT NULL,
	[CalendarYear] [int] NOT NULL,
 CONSTRAINT [PK_Dim - Month Dimension] PRIMARY KEY CLUSTERED 
(
	[MonthKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Dim- Manager Dimension]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim- Manager Dimension](
	[ManagerKey] [int] NOT NULL,
	[ManagerEmployeeID] [int] NOT NULL,
	[DepartmentKey] [int] NOT NULL,
	[RowEffectiveDateKey] [int] NOT NULL,
	[RowExpirationDateKey] [int] NULL,
	[CurrentRowIndicator] [int] NOT NULL,
 CONSTRAINT [PK_Dim- Manager Dimension] PRIMARY KEY CLUSTERED 
(
	[ManagerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Fact - Employee Headcount Snapshot]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact - Employee Headcount Snapshot](
	[MonthKey] [int] NOT NULL,
	[DepartmentKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[NewHireCount] [int] NOT NULL,
	[TransferCount] [int] NOT NULL,
	[SalaryPaid] [money] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Fact - Employee Separation]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact - Employee Separation](
	[DateKey] [int] NOT NULL,
	[DepartmentKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[SeparationProfileKey] [int] NOT NULL,
	[SeparationCount] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Fact - Employee Separation Fact]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact - Employee Separation Fact](
	[DateKey] [int] NOT NULL,
	[DeparmentKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[SeparationProfileKey] [int] NOT NULL,
	[SeparationCount] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Management Hierarchy Bridge]    Script Date: 6/14/2020 12:34:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Management Hierarchy Bridge](
	[ManagerKey] [int] NOT NULL,
	[EmployeeKey] [int] NOT NULL,
	[BottomFlag] [nvarchar](50) NULL,
	[TopFlag] [nvarchar](50) NULL,
	[EffectiveDateTimeKey] [int] NOT NULL,
	[ExpirationDateTimeKey] [int] NULL,
 CONSTRAINT [PK_Management Hierarchy Bridge] PRIMARY KEY CLUSTERED 
(
	[ManagerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Dim - Date]  WITH CHECK ADD  CONSTRAINT [FK_Dim - Date_Dim - Month Dimension] FOREIGN KEY([MonthKey])
REFERENCES [dbo].[Dim - Month Dimension] ([MonthKey])
GO
ALTER TABLE [dbo].[Dim - Date] CHECK CONSTRAINT [FK_Dim - Date_Dim - Month Dimension]
GO
ALTER TABLE [dbo].[Dim - Employee Dimension]  WITH CHECK ADD  CONSTRAINT [FK_Dim - Employee Dimension_Dim - Date] FOREIGN KEY([OriginalHireDateKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Dim - Employee Dimension] CHECK CONSTRAINT [FK_Dim - Employee Dimension_Dim - Date]
GO
ALTER TABLE [dbo].[Dim - Employee Dimension]  WITH CHECK ADD  CONSTRAINT [FK_Dim - Employee Dimension_Dim - Date1] FOREIGN KEY([RowEffectiveDateKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Dim - Employee Dimension] CHECK CONSTRAINT [FK_Dim - Employee Dimension_Dim - Date1]
GO
ALTER TABLE [dbo].[Dim - Employee Dimension]  WITH CHECK ADD  CONSTRAINT [FK_Dim - Employee Dimension_Dim - Date2] FOREIGN KEY([RowExpirationDateKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Dim - Employee Dimension] CHECK CONSTRAINT [FK_Dim - Employee Dimension_Dim - Date2]
GO
ALTER TABLE [dbo].[Dim - Employee Dimension]  WITH CHECK ADD  CONSTRAINT [FK_Dim - Employee Dimension_Dim - Department Dimension] FOREIGN KEY([DepartmentKey])
REFERENCES [dbo].[Dim - Department Dimension] ([DepartmentKey])
GO
ALTER TABLE [dbo].[Dim - Employee Dimension] CHECK CONSTRAINT [FK_Dim - Employee Dimension_Dim - Department Dimension]
GO
ALTER TABLE [dbo].[Dim - Employee Dimension]  WITH CHECK ADD  CONSTRAINT [FK_Dim - Employee Dimension_Dim- Manager Dimension] FOREIGN KEY([ManagerKey])
REFERENCES [dbo].[Dim- Manager Dimension] ([ManagerKey])
GO
ALTER TABLE [dbo].[Dim - Employee Dimension] CHECK CONSTRAINT [FK_Dim - Employee Dimension_Dim- Manager Dimension]
GO
ALTER TABLE [dbo].[Dim- Manager Dimension]  WITH CHECK ADD  CONSTRAINT [FK_Dim- Manager Dimension_Dim - Date] FOREIGN KEY([RowEffectiveDateKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Dim- Manager Dimension] CHECK CONSTRAINT [FK_Dim- Manager Dimension_Dim - Date]
GO
ALTER TABLE [dbo].[Dim- Manager Dimension]  WITH CHECK ADD  CONSTRAINT [FK_Dim- Manager Dimension_Dim - Date1] FOREIGN KEY([RowExpirationDateKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Dim- Manager Dimension] CHECK CONSTRAINT [FK_Dim- Manager Dimension_Dim - Date1]
GO
ALTER TABLE [dbo].[Dim- Manager Dimension]  WITH CHECK ADD  CONSTRAINT [FK_Dim- Manager Dimension_Dim - Department Dimension] FOREIGN KEY([DepartmentKey])
REFERENCES [dbo].[Dim - Department Dimension] ([DepartmentKey])
GO
ALTER TABLE [dbo].[Dim- Manager Dimension] CHECK CONSTRAINT [FK_Dim- Manager Dimension_Dim - Department Dimension]
GO
ALTER TABLE [dbo].[Fact - Employee Headcount Snapshot]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Headcount Snapshot_Dim - Department Dimension] FOREIGN KEY([DepartmentKey])
REFERENCES [dbo].[Dim - Department Dimension] ([DepartmentKey])
GO
ALTER TABLE [dbo].[Fact - Employee Headcount Snapshot] CHECK CONSTRAINT [FK_Fact - Employee Headcount Snapshot_Dim - Department Dimension]
GO
ALTER TABLE [dbo].[Fact - Employee Headcount Snapshot]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Headcount Snapshot_Dim - Employee Dimension] FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[Dim - Employee Dimension] ([EmployeeKey])
GO
ALTER TABLE [dbo].[Fact - Employee Headcount Snapshot] CHECK CONSTRAINT [FK_Fact - Employee Headcount Snapshot_Dim - Employee Dimension]
GO
ALTER TABLE [dbo].[Fact - Employee Headcount Snapshot]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Headcount Snapshot_Dim - Month Dimension] FOREIGN KEY([MonthKey])
REFERENCES [dbo].[Dim - Month Dimension] ([MonthKey])
GO
ALTER TABLE [dbo].[Fact - Employee Headcount Snapshot] CHECK CONSTRAINT [FK_Fact - Employee Headcount Snapshot_Dim - Month Dimension]
GO
ALTER TABLE [dbo].[Fact - Employee Separation]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Separation_Dim - Date] FOREIGN KEY([DateKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Fact - Employee Separation] CHECK CONSTRAINT [FK_Fact - Employee Separation_Dim - Date]
GO
ALTER TABLE [dbo].[Fact - Employee Separation]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Separation_Dim - Employee Dimension] FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[Dim - Employee Dimension] ([EmployeeKey])
GO
ALTER TABLE [dbo].[Fact - Employee Separation] CHECK CONSTRAINT [FK_Fact - Employee Separation_Dim - Employee Dimension]
GO
ALTER TABLE [dbo].[Fact - Employee Separation]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Separation_Dim - Employee Dimension1] FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[Dim - Employee Dimension] ([EmployeeKey])
GO
ALTER TABLE [dbo].[Fact - Employee Separation] CHECK CONSTRAINT [FK_Fact - Employee Separation_Dim - Employee Dimension1]
GO
ALTER TABLE [dbo].[Fact - Employee Separation Fact]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Separation Fact_Dim - Date] FOREIGN KEY([DateKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Fact - Employee Separation Fact] CHECK CONSTRAINT [FK_Fact - Employee Separation Fact_Dim - Date]
GO
ALTER TABLE [dbo].[Fact - Employee Separation Fact]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Separation Fact_Dim - Department Dimension] FOREIGN KEY([DeparmentKey])
REFERENCES [dbo].[Dim - Department Dimension] ([DepartmentKey])
GO
ALTER TABLE [dbo].[Fact - Employee Separation Fact] CHECK CONSTRAINT [FK_Fact - Employee Separation Fact_Dim - Department Dimension]
GO
ALTER TABLE [dbo].[Fact - Employee Separation Fact]  WITH CHECK ADD  CONSTRAINT [FK_Fact - Employee Separation Fact_Dim - Employee Dimension] FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[Dim - Employee Dimension] ([EmployeeKey])
GO
ALTER TABLE [dbo].[Fact - Employee Separation Fact] CHECK CONSTRAINT [FK_Fact - Employee Separation Fact_Dim - Employee Dimension]
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge]  WITH CHECK ADD  CONSTRAINT [FK_Management Hierarchy Bridge_Dim - Date] FOREIGN KEY([EffectiveDateTimeKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge] CHECK CONSTRAINT [FK_Management Hierarchy Bridge_Dim - Date]
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge]  WITH CHECK ADD  CONSTRAINT [FK_Management Hierarchy Bridge_Dim - Date1] FOREIGN KEY([ExpirationDateTimeKey])
REFERENCES [dbo].[Dim - Date] ([DateKey])
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge] CHECK CONSTRAINT [FK_Management Hierarchy Bridge_Dim - Date1]
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge]  WITH CHECK ADD  CONSTRAINT [FK_Management Hierarchy Bridge_Dim - Employee Dimension] FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[Dim - Employee Dimension] ([EmployeeKey])
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge] CHECK CONSTRAINT [FK_Management Hierarchy Bridge_Dim - Employee Dimension]
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge]  WITH CHECK ADD  CONSTRAINT [FK_Management Hierarchy Bridge_Dim - Employee Dimension1] FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[Dim - Employee Dimension] ([EmployeeKey])
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge] CHECK CONSTRAINT [FK_Management Hierarchy Bridge_Dim - Employee Dimension1]
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge]  WITH CHECK ADD  CONSTRAINT [FK_Management Hierarchy Bridge_Dim- Manager Dimension] FOREIGN KEY([ManagerKey])
REFERENCES [dbo].[Dim- Manager Dimension] ([ManagerKey])
GO
ALTER TABLE [dbo].[Management Hierarchy Bridge] CHECK CONSTRAINT [FK_Management Hierarchy Bridge_Dim- Manager Dimension]
GO
USE [master]
GO
ALTER DATABASE [EmployeeDW] SET  READ_WRITE 
GO
