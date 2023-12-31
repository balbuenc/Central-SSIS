USE [master]
GO
/****** Object:  Database [dwh]    Script Date: 03-Dec-23 11:25:42 AM ******/
CREATE DATABASE [dwh]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dwh', FILENAME = N'F:\DATA\dwh.mdf' , SIZE = 1048576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [HISTORY] 
( NAME = N'dwh_history', FILENAME = N'G:\DATA\dwh_history.ndf' , SIZE = 1048576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [STAGING] 
( NAME = N'dhw_staging', FILENAME = N'F:\DATA\dhw_staging.ndf' , SIZE = 1048576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'dwh_staging_02', FILENAME = N'G:\DATA\dwh_staging_02.ndf' , SIZE = 1441792KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dwh_log', FILENAME = N'I:\LOGS\dwh_log.ldf' , SIZE = 10100736KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO




ALTER DATABASE [dwh] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dwh].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dwh] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dwh] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dwh] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dwh] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dwh] SET ARITHABORT OFF 
GO
ALTER DATABASE [dwh] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dwh] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dwh] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dwh] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dwh] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dwh] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dwh] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dwh] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dwh] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dwh] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dwh] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dwh] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dwh] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dwh] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dwh] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dwh] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dwh] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dwh] SET RECOVERY FULL 
GO
ALTER DATABASE [dwh] SET  MULTI_USER 
GO
ALTER DATABASE [dwh] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dwh] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dwh] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dwh] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dwh] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dwh] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dwh', N'ON'
GO
ALTER DATABASE [dwh] SET QUERY_STORE = ON
GO
ALTER DATABASE [dwh] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO


USE [dwh]
GO
/****** Object:  Schema [fact]    Script Date: 03-Dec-23 11:25:43 AM ******/
CREATE SCHEMA [fact]
GO
/****** Object:  Schema [pm]    Script Date: 03-Dec-23 11:25:43 AM ******/
CREATE SCHEMA [pm]
GO
/****** Object:  Schema [staging]    Script Date: 03-Dec-23 11:25:43 AM ******/
CREATE SCHEMA [staging]
GO
/****** Object:  Table [dbo].[DimCardStatuses]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCardStatuses](
	[CardStatusKey] [tinyint] NOT NULL,
	[Value] [varchar](50) NOT NULL,
	[Code] [varchar](20) NOT NULL,
	[Description] [varchar](100) NULL,
 CONSTRAINT [PK_CardStatuses] PRIMARY KEY CLUSTERED 
(
	[CardStatusKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimCardTypes]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCardTypes](
	[CardTypeKey] [int] NOT NULL,
	[CardTypeName] [varchar](50) NULL,
	[Code] [varchar](20) NULL,
	[Price] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[CardTypeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimDate]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDate](
	[DateKey] [int] NOT NULL,
	[Date] [datetime] NULL,
	[FullDate] [char](10) NULL,
	[DayOfMonth] [varchar](2) NULL,
	[DaySuffix] [varchar](4) NULL,
	[DayName] [varchar](9) NULL,
	[DayOfWeek] [char](1) NULL,
	[DayOfWeekInMonth] [varchar](2) NULL,
	[DayOfWeekInYear] [varchar](2) NULL,
	[DayOfQuarter] [varchar](3) NULL,
	[DayOfYear] [varchar](3) NULL,
	[WeekOfMonth] [varchar](1) NULL,
	[WeekOfQuarter] [varchar](2) NULL,
	[WeekOfYear] [varchar](2) NULL,
	[Month] [varchar](2) NULL,
	[MonthName] [varchar](9) NULL,
	[MonthOfQuarter] [varchar](2) NULL,
	[Quarter] [char](1) NULL,
	[QuarterName] [varchar](9) NULL,
	[Year] [char](4) NULL,
	[YearName] [char](7) NULL,
	[MonthYear] [char](10) NULL,
	[MMYYYY] [char](6) NULL,
	[FirstDayOfMonth] [date] NULL,
	[LastDayOfMonth] [date] NULL,
	[FirstDayOfQuarter] [date] NULL,
	[LastDayOfQuarter] [date] NULL,
	[FirstDayOfYear] [date] NULL,
	[LastDayOfYear] [date] NULL,
	[IsHoliday] [bit] NULL,
	[IsWeekday] [bit] NULL,
	[HolidayName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimOffices]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimOffices](
	[OfficeKey] [int] NOT NULL,
	[OfficeName] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
 CONSTRAINT [PK__DimOffic__C651ED9A8AC3AEAD] PRIMARY KEY CLUSTERED 
(
	[OfficeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimRequestSources]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimRequestSources](
	[RequestSourceKey] [tinyint] NOT NULL,
	[Value] [varchar](20) NULL,
 CONSTRAINT [PK_DimRequestSources] PRIMARY KEY CLUSTERED 
(
	[RequestSourceKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimRequestsProperties]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimRequestsProperties](
	[RequestPropertyKey] [int] NOT NULL,
	[ModelBaseKey] [bigint] NULL,
	[Name] [varchar](50) NOT NULL,
	[Class] [varchar](250) NOT NULL,
	[JurisdictionProviderKey] [int] NULL,
	[PropertyType] [varchar](500) NULL,
 CONSTRAINT [PK_RequestsProperties] PRIMARY KEY CLUSTERED 
(
	[RequestPropertyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSexes]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSexes](
	[SexKey] [tinyint] NOT NULL,
	[Value] [varchar](10) NOT NULL,
	[Code] [char](1) NOT NULL,
 CONSTRAINT [PK_Sexes] PRIMARY KEY CLUSTERED 
(
	[SexKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSources]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSources](
	[SourceKey] [tinyint] NOT NULL,
	[Code] [varchar](50) NULL,
	[Value] [varchar](100) NULL,
 CONSTRAINT [PK__DimSourc__F0C8A67EB8817A65] PRIMARY KEY CLUSTERED 
(
	[SourceKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimUsers]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimUsers](
	[UserKey] [int] NOT NULL,
	[Login] [varchar](50) NULL,
	[Name] [nvarchar](250) NULL,
	[OfficeKey] [int] NULL,
 CONSTRAINT [PK__DimUsers__296ADCF1706769D6] PRIMARY KEY CLUSTERED 
(
	[UserKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [fact].[FactRequestsCards]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [fact].[FactRequestsCards](
	[RequestCardKey] [bigint] NOT NULL,
	[RequestKey] [bigint] NULL,
	[CardStatusKey] [tinyint] NULL,
	[CardTypeKey] [int] NULL,
	[RequestCardStatusKey] [int] NULL,
	[ApplicantKey] [bigint] NULL,
	[Price] [decimal](10, 2) NULL,
	[IssueDateKey] [int] NULL,
	[ExpiryDateKey] [int] NULL,
	[CustomerIdentifier] [varchar](25) NULL,
	[ProviderState] [varchar](50) NULL,
	[PreviusProviderState] [varchar](50) NULL,
	[CreatedByUserKey] [int] NULL,
	[CreatedDateKey] [int] NULL,
	[ModifiedByUserKey] [int] NULL,
	[ModifiedDateKey] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [pm].[batch_report]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pm].[batch_report](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[printed_date] [datetime] NOT NULL,
	[user] [varchar](128) NULL,
	[p_fecha] [datetime] NULL,
	[p_producto] [int] NULL,
	[p_impresion] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [pm].[batch_report_details]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pm].[batch_report_details](
	[id] [int] NOT NULL,
	[request_id] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Applicants]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Applicants](
	[ApplicantKey] [bigint] NOT NULL,
	[ModelBaseKey] [bigint] NOT NULL,
	[BirthDate] [datetime2](7) NULL,
	[FamilyName] [nvarchar](80) NOT NULL,
	[FirstName] [nvarchar](80) NULL,
	[MiddleName] [nvarchar](80) NULL,
	[SexKey] [tinyint] NOT NULL,
	[SuffixKey] [tinyint] NULL,
	[EyeColorKey] [int] NOT NULL,
	[HairColorKey] [int] NOT NULL,
	[Email] [varchar](250) NULL,
	[Phone] [varchar](20) NULL,
	[SSN] [char](4) NULL,
	[VIP] [bit] NOT NULL,
	[ApplicantPortraitKey] [bigint] NULL,
	[ApplicantSignatureKey] [bigint] NULL,
	[Fraud] [bit] NOT NULL,
	[FraudUserKey] [int] NULL,
	[FraudDateUtc] [datetime] NULL,
	[Watch] [bit] NOT NULL,
	[WatchUserkey] [int] NULL,
	[WatchDateUtc] [datetime] NULL,
	[FamilyNameSoundKey] [varchar](30) NULL,
	[FirstNameSoundKey] [varchar](30) NULL,
	[MiddleNameSoundKey] [varchar](30) NULL,
	[FullNameSoundKey] [varchar](100) NULL,
	[MatchNameSoundKey] [varchar](100) NULL,
	[RaceKey] [int] NULL,
	[CustomerIdentifier] [varchar](25) NULL,
 CONSTRAINT [PK_Applicants] PRIMARY KEY CLUSTERED 
(
	[ApplicantKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [STAGING]
) ON [STAGING]
GO
/****** Object:  Table [staging].[ModelBase]    Script Date: 03-Dec-23 11:25:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[ModelBase](
	[ModelBaseKey] [bigint] NOT NULL,
	[RecordStatusKey] [tinyint] NOT NULL,
	[CreatedByUserKey] [int] NOT NULL,
	[CreatedDateUtc] [datetime2](7) NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[ModifiedByUserKey] [int] NOT NULL,
	[ModifiedDateUtc] [datetime2](7) NOT NULL,
	[ModifiedDate] [datetime2](7) NULL,
	[SqlUsername] [varchar](50) NOT NULL,
	[RecordTypeKey] [tinyint] NOT NULL,
	[ModelClassType] [varchar](50) NULL,
	[ExternalId] [varchar](128) NULL,
	[ExternalSystemId] [varchar](50) NULL,
	[MigrationId] [varchar](150) NULL,
	[Comment] [nvarchar](max) NULL,
	[HelpText] [nvarchar](1000) NULL,
	[MachineId] [varchar](50) NULL,
 CONSTRAINT [PK_ModelBase] PRIMARY KEY CLUSTERED 
(
	[ModelBaseKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = ROW) ON [STAGING]
) ON [STAGING] TEXTIMAGE_ON [STAGING]
GO
/****** Object:  Table [staging].[Requests]    Script Date: 03-Dec-23 11:25:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[Requests](
	[RequestKey] [bigint] NOT NULL,
	[ModelBaseKey] [bigint] NOT NULL,
	[ApplicantKey] [bigint] NOT NULL,
	[CardAddressKey] [bigint] NULL,
	[MailingAddressKey] [bigint] NULL,
	[ReturnAddressKey] [bigint] NULL,
	[Veteran] [bit] NOT NULL,
	[OrganDonor] [bit] NOT NULL,
	[Weight] [smallint] NOT NULL,
	[Height] [tinyint] NOT NULL,
	[ProviderState] [varchar](50) NOT NULL,
	[ProviderStateId] [tinyint] NOT NULL,
	[MedicalText] [varchar](255) NULL,
	[AllergyText] [varchar](255) NULL,
	[RequestSourceKey] [tinyint] NOT NULL,
	[EyeColorKey] [int] NOT NULL,
	[HairColorKey] [int] NOT NULL,
	[ApplicantPortraitKey] [bigint] NULL,
	[ApplicantSignatureKey] [bigint] NULL,
	[JurisdictionProviderKey] [int] NOT NULL,
	[Cancelled] [bit] NOT NULL,
	[Hold] [bit] NOT NULL,
	[HoldUserKey] [int] NULL,
	[HoldDateUtc] [datetime] NULL,
	[Fraud] [bit] NOT NULL,
	[FraudUserKey] [int] NULL,
	[FraudDateUtc] [datetime] NULL,
	[Handicap] [bit] NOT NULL,
	[LimitedTerm] [bit] NOT NULL,
	[OfficeKey] [int] NULL,
	[VoterRegistered] [bit] NOT NULL,
	[PortraitSourceKey] [tinyint] NOT NULL,
	[SignatureSourceKey] [tinyint] NOT NULL,
	[PreviousProviderState] [varchar](50) NULL,
	[PreviousProviderStateId] [tinyint] NULL,
	[Renewal] [bit] NOT NULL,
	[ForeignOfficeKey] [int] NULL,
	[CreatedByUserKey] [int] NULL,
	[CreatedDateUtc] [datetime2](7) NULL,
	[ModifiedByUserKey] [int] NULL,
	[ModifiedDateUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_Requests] PRIMARY KEY CLUSTERED 
(
	[RequestKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [STAGING]
) ON [STAGING]
GO
/****** Object:  Table [staging].[RequestsCards]    Script Date: 03-Dec-23 11:25:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[RequestsCards](
	[RequestCardKey] [bigint] NOT NULL,
	[ModelBaseKey] [bigint] NOT NULL,
	[RequestKey] [bigint] NOT NULL,
	[CardTypeKey] [int] NOT NULL,
	[CardStatusKey] [tinyint] NOT NULL,
	[CustomerIdentifier] [varchar](25) NOT NULL,
	[Price] [decimal](10, 2) NULL,
	[IssueDate] [date] NULL,
	[ExpiryDate] [date] NOT NULL,
	[AvailableIssuanceDateUtc] [date] NULL,
	[DeliveredIssuanceDateUtc] [date] NULL,
	[RealId] [bit] NOT NULL,
	[DocumentDiscriminator] [varchar](25) NOT NULL,
	[Expedite] [bit] NOT NULL,
	[ApplicantPortraitKey] [bigint] NULL,
	[ApplicantSignatureKey] [bigint] NULL,
	[RequestCardStatusKey] [tinyint] NOT NULL,
	[DDLAccountId] [uniqueidentifier] NULL,
	[GivenNamesLine1] [nvarchar](80) NULL,
	[GivenNamesLine2] [nvarchar](80) NULL,
	[GivenNamesLine3] [nvarchar](80) NULL,
	[MailDate] [date] NULL,
	[ExpiryYears] [int] NOT NULL,
	[CreatedByUserKey] [int] NULL,
	[CreatedDateUtc] [datetime2](7) NULL,
	[ModifiedByUserKey] [int] NULL,
	[ModifiedDateUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_RequestsCards] PRIMARY KEY CLUSTERED 
(
	[RequestCardKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, DATA_COMPRESSION = PAGE) ON [STAGING]
) ON [STAGING]
GO
/****** Object:  Table [staging].[RequestsValues]    Script Date: 03-Dec-23 11:25:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [staging].[RequestsValues](
	[RequestValueKey] [bigint] NOT NULL,
	[ModelBaseKey] [bigint] NOT NULL,
	[RequestKey] [bigint] NOT NULL,
	[RequestPropertyKey] [int] NOT NULL,
	[Value] [nvarchar](1000) NULL,
	[CreatedByUserKey] [int] NULL,
	[CreatedDateUtc] [datetime2](7) NULL,
	[ModifiedByUserKey] [int] NULL,
	[ModifiedDateUtc] [datetime2](7) NULL,
 CONSTRAINT [PK_RequestsValues] PRIMARY KEY CLUSTERED 
(
	[RequestValueKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [STAGING]
) ON [STAGING]
GO
ALTER TABLE [pm].[batch_report] ADD  DEFAULT (getdate()) FOR [printed_date]
GO
ALTER TABLE [fact].[FactRequestsCards]  WITH CHECK ADD  CONSTRAINT [FK_FactRequestCards_Applicants] FOREIGN KEY([ApplicantKey])
REFERENCES [staging].[Applicants] ([ApplicantKey])
GO
ALTER TABLE [fact].[FactRequestsCards] CHECK CONSTRAINT [FK_FactRequestCards_Applicants]
GO
ALTER TABLE [fact].[FactRequestsCards]  WITH CHECK ADD  CONSTRAINT [FK_FactRequestCards_DimCardStatuses] FOREIGN KEY([CardStatusKey])
REFERENCES [dbo].[DimCardStatuses] ([CardStatusKey])
GO
ALTER TABLE [fact].[FactRequestsCards] CHECK CONSTRAINT [FK_FactRequestCards_DimCardStatuses]
GO
ALTER TABLE [fact].[FactRequestsCards]  WITH CHECK ADD  CONSTRAINT [FK_FactRequestCards_DimCardTypes] FOREIGN KEY([CardTypeKey])
REFERENCES [dbo].[DimCardTypes] ([CardTypeKey])
GO
ALTER TABLE [fact].[FactRequestsCards] CHECK CONSTRAINT [FK_FactRequestCards_DimCardTypes]
GO
ALTER TABLE [fact].[FactRequestsCards]  WITH CHECK ADD  CONSTRAINT [FK_FactRequestCards_DimDate] FOREIGN KEY([IssueDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [fact].[FactRequestsCards] CHECK CONSTRAINT [FK_FactRequestCards_DimDate]
GO
ALTER TABLE [fact].[FactRequestsCards]  WITH CHECK ADD  CONSTRAINT [FK_FactRequestCards_DimDate1] FOREIGN KEY([ExpiryDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO
ALTER TABLE [fact].[FactRequestsCards] CHECK CONSTRAINT [FK_FactRequestCards_DimDate1]
GO
ALTER TABLE [fact].[FactRequestsCards]  WITH CHECK ADD  CONSTRAINT [FK_FactRequestCards_Requests] FOREIGN KEY([RequestKey])
REFERENCES [staging].[Requests] ([RequestKey])
GO
ALTER TABLE [fact].[FactRequestsCards] CHECK CONSTRAINT [FK_FactRequestCards_Requests]
GO
ALTER TABLE [fact].[FactRequestsCards]  WITH CHECK ADD  CONSTRAINT [FK_FactRequestCards_RequestsCards] FOREIGN KEY([RequestCardKey])
REFERENCES [staging].[RequestsCards] ([RequestCardKey])
GO
ALTER TABLE [fact].[FactRequestsCards] CHECK CONSTRAINT [FK_FactRequestCards_RequestsCards]
GO
ALTER TABLE [staging].[Applicants]  WITH CHECK ADD  CONSTRAINT [FK_Applicants_DimSexes] FOREIGN KEY([SexKey])
REFERENCES [dbo].[DimSexes] ([SexKey])
GO
ALTER TABLE [staging].[Applicants] CHECK CONSTRAINT [FK_Applicants_DimSexes]
GO
ALTER TABLE [staging].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_DimOffices] FOREIGN KEY([OfficeKey])
REFERENCES [dbo].[DimOffices] ([OfficeKey])
GO
ALTER TABLE [staging].[Requests] CHECK CONSTRAINT [FK_Requests_DimOffices]
GO
ALTER TABLE [staging].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_DimRequestSources] FOREIGN KEY([RequestSourceKey])
REFERENCES [dbo].[DimRequestSources] ([RequestSourceKey])
GO
ALTER TABLE [staging].[Requests] CHECK CONSTRAINT [FK_Requests_DimRequestSources]
GO
ALTER TABLE [staging].[Requests]  WITH CHECK ADD  CONSTRAINT [FK_Requests_DimSources] FOREIGN KEY([RequestSourceKey])
REFERENCES [dbo].[DimSources] ([SourceKey])
GO
ALTER TABLE [staging].[Requests] CHECK CONSTRAINT [FK_Requests_DimSources]
GO
ALTER TABLE [staging].[RequestsValues]  WITH CHECK ADD  CONSTRAINT [FK_RequestsValues_DimRequestsProperties] FOREIGN KEY([RequestPropertyKey])
REFERENCES [dbo].[DimRequestsProperties] ([RequestPropertyKey])
GO
ALTER TABLE [staging].[RequestsValues] CHECK CONSTRAINT [FK_RequestsValues_DimRequestsProperties]
GO
ALTER TABLE [staging].[RequestsValues]  WITH CHECK ADD  CONSTRAINT [FK_RequestsValues_Requests] FOREIGN KEY([RequestKey])
REFERENCES [staging].[Requests] ([RequestKey])
GO
ALTER TABLE [staging].[RequestsValues] CHECK CONSTRAINT [FK_RequestsValues_Requests]
GO
/****** Object:  StoredProcedure [pm].[sp_generate_batch_report]    Script Date: 03-Dec-23 11:25:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [pm].[sp_generate_batch_report]
(
	@p_fecha datetime,
	@p_estado varchar(128),
	@p_producto int,
	@p_impresion int,
	@p_usuario varchar(128),
	@p_destino int,
	@p_documentos varchar(MAX)
)
as
begin

declare @v_id bigint;
declare @v_documentos as table (value varchar(128));

insert into @v_documentos 
select value from STRING_SPLIT(@p_documentos,',')


insert into [pm].[batch_report] (printed_date, 
								[user],
								p_fecha,
								p_producto,
								p_impresion) 
values (getdate(), 
		@p_usuario,
		@p_fecha,
		@p_producto,
		@p_impresion);


set @v_id = @@IDENTITY; 


--Verify if a new impresion
if (@p_impresion is not null)
begin
	delete from pm.batch_report_details
	where id =@p_impresion;

	delete from [pm].[batch_report]
	where id = @p_impresion;
end

--Generate Temp table with not printed documents
SELECT		r.ID,
			r.PHYSICAL_STATE as REQUEST_STATE, 
			r.HOLDER_LASTNAME, 
			r.HOLDER_FIRSTNAME, 
			r.HOLDER_ID, 
			r.HOLDER_GENDER, 
			r.DATE_VALIDATION, 
			r.DATE_PREPARATION, 
			r.DATE_INPRODUCTION, 
			r.DATE_PRODUCTION, 
			r.DATE_REJECTION, 
			r.DOCUMENT_NUMBER, 
			r.DATE_COMPLETED, 
			r.DATE_PURGED, 
			r.DOCUMENT_ID, 
			r.DATE_RECEPTION, 
			--BATCH DATA
			b.ID AS BATCH_ID, 
			b.PHYSICAL_STATE AS BATCH_STATE, 
			b.ORIGINAL_REQUEST_COUNT, 
			b.DELIVERY_SITE_ID, 
			p.NAME as PRODUCT,
			es.NAME as ENROLLMENT,
			@v_id as GUIA
INTO #temp
FROM		[EPEDPDBSQLCLU].[EPEDSQLPM].dbo.REQUEST AS r with (nolock)  INNER JOIN
			[EPEDPDBSQLCLU].[EPEDSQLPM].dbo.BATCH  AS b  with (nolock) ON b.ID = r.BATCH_ID LEFT OUTER JOIN
			[EPEDPDBSQLCLU].[EPEDSQLPM].dbo.PRODUCT AS P  with (nolock)  ON r.PRODUCT_ID = p.ID LEFT OUTER JOIN
			[EPEDPDBSQLCLU].[EPEDSQLPM].dbo.ENROLLMENT_SITE AS es  with (nolock)  on es.ID = r.ENROLLMENT_SITE_ID
		
WHERE  cast(r.DATE_RECEPTION as date) = @p_fecha
and b.PHYSICAL_STATE = @p_estado
and r.product_id = @p_producto
and r.ENROLLMENT_SITE_ID = @p_destino
--and r.id not in (	select d.request_id 
--					from [pm].[batch_report_details] d)
and r.id in (select value from @v_documentos)
order by r.HOLDER_LASTNAME;



--Insert the printed documments to the log
insert into [pm].[batch_report_details]
SELECT		@v_id,
			t.ID
FROM		#temp t;


--Get the resisters for the parameters
select *
from #temp
order by 3;

drop table #temp;


END
GO
USE [master]
GO
ALTER DATABASE [dwh] SET  READ_WRITE 
GO
