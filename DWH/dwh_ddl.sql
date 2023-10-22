USE [master]
GO
/****** Object:  Database [dwh]    Script Date: 10/22/2023 6:33:59 PM ******/
CREATE DATABASE [dwh]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dwh', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dwh.mdf' , SIZE = 3211264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [HISTORY] 
( NAME = N'dwh_history', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dwh_history.ndf' , SIZE = 1048576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [STAGING] 
( NAME = N'dhw_staging', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dhw_staging.ndf' , SIZE = 1048576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'dwh_staging_02', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dwh_staging_02.ndf' , SIZE = 1048576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dwh_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dwh_log.ldf' , SIZE = 4521984KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Schema [staging]    Script Date: 10/22/2023 6:33:59 PM ******/
CREATE SCHEMA [staging]
GO
/****** Object:  Table [dbo].[DimApplicants]    Script Date: 10/22/2023 6:33:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimApplicants](
	[ApplicantKey] [bigint] NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[DateOfBirth] [datetime2](7) NULL,
	[SexKey] [tinyint] NULL,
	[CustomerIdentifier] [varchar](25) NULL,
 CONSTRAINT [PK__DimAppli__8EE97FFB6F024C95] PRIMARY KEY CLUSTERED 
(
	[ApplicantKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimCardTypes]    Script Date: 10/22/2023 6:33:59 PM ******/
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
/****** Object:  Table [dbo].[DimOffices]    Script Date: 10/22/2023 6:33:59 PM ******/
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
/****** Object:  Table [dbo].[DimRequestSources]    Script Date: 10/22/2023 6:33:59 PM ******/
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
/****** Object:  Table [dbo].[DimReviewGates]    Script Date: 10/22/2023 6:33:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimReviewGates](
	[ReviewGateKey] [tinyint] NOT NULL,
	[GateName] [varchar](50) NULL,
	[Code] [varchar](20) NULL,
	[Description] [varchar](200) NULL,
 CONSTRAINT [PK__DimRevie__0E8C7388B80BCBBA] PRIMARY KEY CLUSTERED 
(
	[ReviewGateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSexes]    Script Date: 10/22/2023 6:33:59 PM ******/
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
/****** Object:  Table [dbo].[DimSources]    Script Date: 10/22/2023 6:33:59 PM ******/
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
/****** Object:  Table [dbo].[DimUsers]    Script Date: 10/22/2023 6:33:59 PM ******/
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
/****** Object:  Table [dbo].[FactRequestCards]    Script Date: 10/22/2023 6:33:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactRequestCards](
	[RequestCardKey] [int] NOT NULL,
	[RequestKey] [bigint] NULL,
	[ApplicantPortraitKey] [int] NULL,
	[ApplicantSignatureKey] [int] NULL,
	[CardStatusKey] [int] NULL,
	[CardTypeKey] [int] NULL,
	[ModelBaseKey] [int] NULL,
	[RequestCardStatusKey] [int] NULL,
 CONSTRAINT [PK__FactRequ__44650DBCE5096B30] PRIMARY KEY CLUSTERED 
(
	[RequestCardKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactRequests]    Script Date: 10/22/2023 6:33:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactRequests](
	[RequestKey] [bigint] NOT NULL,
	[ApplicantKey] [bigint] NULL,
	[RequestDate] [date] NULL,
	[CardTypeKey] [int] NULL,
	[OfficeKey] [int] NULL,
	[UserKey] [int] NULL,
	[ReviewGateKey] [tinyint] NULL,
	[SexKey] [tinyint] NULL,
	[SourceKey] [tinyint] NULL,
	[RequestSourceKey] [tinyint] NULL,
 CONSTRAINT [PK__FactRequ__F6AC419C60EC9027] PRIMARY KEY CLUSTERED 
(
	[RequestKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[Requests]    Script Date: 10/22/2023 6:33:59 PM ******/
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
 CONSTRAINT [PK_Requests] PRIMARY KEY CLUSTERED 
(
	[RequestKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [staging].[RequestsCards]    Script Date: 10/22/2023 6:33:59 PM ******/
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
 CONSTRAINT [PK_RequestsCards] PRIMARY KEY CLUSTERED 
(
	[RequestCardKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactRequestCards]  WITH CHECK ADD  CONSTRAINT [FK_FactRequestCards_FactRequests] FOREIGN KEY([RequestKey])
REFERENCES [dbo].[FactRequests] ([RequestKey])
GO
ALTER TABLE [dbo].[FactRequestCards] CHECK CONSTRAINT [FK_FactRequestCards_FactRequests]
GO
ALTER TABLE [dbo].[FactRequests]  WITH CHECK ADD  CONSTRAINT [FK_FactRequests_DimApplicants] FOREIGN KEY([ApplicantKey])
REFERENCES [dbo].[DimApplicants] ([ApplicantKey])
GO
ALTER TABLE [dbo].[FactRequests] CHECK CONSTRAINT [FK_FactRequests_DimApplicants]
GO
ALTER TABLE [dbo].[FactRequests]  WITH CHECK ADD  CONSTRAINT [FK_FactRequests_DimCardTypes] FOREIGN KEY([CardTypeKey])
REFERENCES [dbo].[DimCardTypes] ([CardTypeKey])
GO
ALTER TABLE [dbo].[FactRequests] CHECK CONSTRAINT [FK_FactRequests_DimCardTypes]
GO
ALTER TABLE [dbo].[FactRequests]  WITH CHECK ADD  CONSTRAINT [FK_FactRequests_DimOffices] FOREIGN KEY([OfficeKey])
REFERENCES [dbo].[DimOffices] ([OfficeKey])
GO
ALTER TABLE [dbo].[FactRequests] CHECK CONSTRAINT [FK_FactRequests_DimOffices]
GO
ALTER TABLE [dbo].[FactRequests]  WITH CHECK ADD  CONSTRAINT [FK_FactRequests_DimRequestSources] FOREIGN KEY([RequestSourceKey])
REFERENCES [dbo].[DimRequestSources] ([RequestSourceKey])
GO
ALTER TABLE [dbo].[FactRequests] CHECK CONSTRAINT [FK_FactRequests_DimRequestSources]
GO
ALTER TABLE [dbo].[FactRequests]  WITH CHECK ADD  CONSTRAINT [FK_FactRequests_DimReviewGates] FOREIGN KEY([ReviewGateKey])
REFERENCES [dbo].[DimReviewGates] ([ReviewGateKey])
GO
ALTER TABLE [dbo].[FactRequests] CHECK CONSTRAINT [FK_FactRequests_DimReviewGates]
GO
ALTER TABLE [dbo].[FactRequests]  WITH CHECK ADD  CONSTRAINT [FK_FactRequests_DimSexes] FOREIGN KEY([SexKey])
REFERENCES [dbo].[DimSexes] ([SexKey])
GO
ALTER TABLE [dbo].[FactRequests] CHECK CONSTRAINT [FK_FactRequests_DimSexes]
GO
ALTER TABLE [dbo].[FactRequests]  WITH CHECK ADD  CONSTRAINT [FK_FactRequests_DimSources] FOREIGN KEY([SourceKey])
REFERENCES [dbo].[DimSources] ([SourceKey])
GO
ALTER TABLE [dbo].[FactRequests] CHECK CONSTRAINT [FK_FactRequests_DimSources]
GO
ALTER TABLE [dbo].[FactRequests]  WITH CHECK ADD  CONSTRAINT [FK_FactRequests_DimUsers] FOREIGN KEY([UserKey])
REFERENCES [dbo].[DimUsers] ([UserKey])
GO
ALTER TABLE [dbo].[FactRequests] CHECK CONSTRAINT [FK_FactRequests_DimUsers]
GO
USE [master]
GO
ALTER DATABASE [dwh] SET  READ_WRITE 
GO
