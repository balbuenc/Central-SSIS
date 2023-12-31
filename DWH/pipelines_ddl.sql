USE [master]
GO
/****** Object:  Database [PipeLines]    Script Date: 09-Nov-23 7:51:45 PM ******/
CREATE DATABASE [PipeLines]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PipeLines', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PipeLines.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PipeLines_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PipeLines_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PipeLines] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PipeLines].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PipeLines] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PipeLines] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PipeLines] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PipeLines] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PipeLines] SET ARITHABORT OFF 
GO
ALTER DATABASE [PipeLines] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PipeLines] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PipeLines] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PipeLines] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PipeLines] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PipeLines] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PipeLines] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PipeLines] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PipeLines] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PipeLines] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PipeLines] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PipeLines] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PipeLines] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PipeLines] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PipeLines] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PipeLines] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PipeLines] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PipeLines] SET RECOVERY FULL 
GO
ALTER DATABASE [PipeLines] SET  MULTI_USER 
GO
ALTER DATABASE [PipeLines] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PipeLines] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PipeLines] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PipeLines] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PipeLines] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PipeLines] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PipeLines', N'ON'
GO
ALTER DATABASE [PipeLines] SET QUERY_STORE = ON
GO
ALTER DATABASE [PipeLines] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PipeLines]
GO
/****** Object:  Schema [translate]    Script Date: 09-Nov-23 7:51:45 PM ******/
CREATE SCHEMA [translate]
GO
/****** Object:  UserDefinedFunction [translate].[fn_get_ic_data]    Script Date: 09-Nov-23 7:51:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [translate].[fn_get_ic_data]
(
	@inputString NVARCHAR(MAX),
	@ix smallint = 0
)
RETURNS nvarchar(MAX)
AS
BEGIN

--DECLARE @inputString NVARCHAR(MAX) = '007-05321977-129-000-000';
DECLARE @separator NVARCHAR(MAX) = '-';
DECLARE @id  as int = 0;
DECLARE @value nvarchar(max) = null;

-- Split the string into parts using the separator.
DECLARE @parts TABLE (PartID int , Part NVARCHAR(MAX));

WHILE CHARINDEX(@separator, @inputString) > 0
BEGIN

	

	INSERT INTO @parts (PartID, Part) 
    SELECT @id, SUBSTRING(@inputString, 1, CHARINDEX(@separator, @inputString) - 1);

    SET @inputString = SUBSTRING(@inputString, CHARINDEX(@separator, @inputString) + 1, LEN(@inputString));
	SET @id = @id + 1;
END;

-- Add the remaining part (last part) to the table.
INSERT INTO @parts (PartID, Part) VALUES (@id, @inputString);



-- Select and display the extracted parts.
SELECT @value = Part
FROM @parts
where PartID = @ix;

return @value;

END
GO
/****** Object:  UserDefinedFunction [translate].[fn_get_nationality_original_code]    Script Date: 09-Nov-23 7:51:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
CREATE FUNCTION [translate].[fn_get_nationality_original_code]
(
	@thales_nationality_code int
)
RETURNS int
AS
BEGIN

	DECLARE @value int

	select @value = cod
	from translate.nationality
	where translate_key = @thales_nationality_code;


	RETURN @value;

END
GO
/****** Object:  UserDefinedFunction [translate].[fn_get_profession_original_code]    Script Date: 09-Nov-23 7:51:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
CREATE FUNCTION [translate].[fn_get_profession_original_code]
(
	@thales_profession_code int
)
RETURNS int
AS
BEGIN

	DECLARE @value int

	select @value = cod
	from translate.profession
	where translate_key = @thales_profession_code;


	RETURN @value;

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_get_applicants_transactions_by_date]    Script Date: 09-Nov-23 7:51:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- Author:		CHRISTIAN BALBUENA CAZZOLA | HEJE E.A.S.
-- Create date: 22/0/2023
-- Description:	FUNCION TIPO TABLE QUE DEVUELVE LOS REGISTROS PROCESADOS POR RANGO DE FECHAS EN LAS TRANSACCIONES
--				DE DOCUMENTOS ELECTRONICOS.
-- =============================================
CREATE FUNCTION [dbo].[fn_get_applicants_transactions_by_date] 
(	
	@p_start_date date,
	@p_end_date date
)
RETURNS TABLE 
AS
RETURN 
(


	SELECT left(a.CustomerIdentifier,60) [cedula]
      ,[translate].[fn_get_ic_data](IC.Value,0) [ic_ofnac]
      ,[translate].[fn_get_ic_data](IC.Value,1) [ic_feccar]
      ,[translate].[fn_get_ic_data](IC.Value,2) [ic_folio]
      ,[translate].[fn_get_ic_data](IC.Value,3) [ic_tomo]
      ,[translate].[fn_get_ic_data](IC.Value,4) [ic_acta]
      ,null [prontuario]
      ,left(a.FamilyName,60) [apellido]
      ,left(a.FirstName,60) [nombres]
      ,CONVERT(VARCHAR, CONVERT(DATETIME, a.BirthDate, 101), 25) [fech_nacim]
      ,left(BP.Value,40) [lugar_nacim]
      ,translate.fn_get_nationality_original_code (CN.value)	[nacional_actual]
      ,translate.fn_get_nationality_original_code (NN.Value)	[nacional_origen]
      ,s.Code [sexo]
      ,EI.Code [instruccion]
      ,PROF.Code [profesion]
      ,left(CS.Value,2) [estado_civil]
	  ,CONVERT(VARCHAR, CONVERT(DATETIME, MS.Value, 101), 25) [fech_ecivil]
      ,left(CSC.Value,30) [acto_ecivil]
      ,left(ADDR.Value,50) [domicilio]
      ,null [barrio_ciudad]
      ,left(a.PHONE,20) [telefono]
      ,left(MOB.Value,20) [celular]
      ,case R.OrganDonor 
			when 1 then 'V'
			else 'F'
			end as [donante_org]
      ,case D.Value
	  		when 1 then 'V'
			else 'F'
			end as [fallecido]
      ,C.CardTypeKey [tipo_docum]
      ,left(OFFICE.Code,16) [ubicacion]
      ,null [observaciones]
      ,left(FCIP.Value,15) [padre_cedul]
      ,left(FN.Value,60) [padre_nombre]
      ,left(FLN.Value,60) [padre_apelli]
      ,left(MCIP.Value,15) [madre_cedul]
      ,left(MN.Value,60) [madre_nombre]
      ,left(MLN.Value,60) [madre_apelli]
      ,left(SCIP.Value,15)  [conyu_cedul]
      ,left(SN.Value,60) [conyu_nombre]
      ,left(SLN.Value,60) [conyu_apelli]
      ,null [acomp_cedul]
      ,null [acomp_parent]
      ,null [acomp_nombre]
      ,null [acomp_apelli]
      ,CONVERT(VARCHAR, CONVERT(DATETIME, mb.CreatedDateUTC, 101), 25) [fech_autoriz]
      ,AU.Login [func_autoriz]
      ,CONVERT(VARCHAR, CONVERT(DATETIME, mb.ModifiedDateUTC, 101), 25) [fech_impresion]
      ,MU.Login[func_impresion]
      ,null [numero_soporte]
      ,CONVERT(VARCHAR, CONVERT(DATETIME, mb.ModifiedDateUTC, 101), 25) [fech_entrega]
      ,null [func_entrega]
      ,null [prontuario_s]
      ,null [retirado_por]
      ,getdate() [hora_insert]

FROM [EPEDPDBSQLCLU].[CentralServer2].[dbo].[RequestsCards] RC with (nolock)
inner join[EPEDPDBSQLCLU].[CentralServer2]. dbo.Requests R with (nolock) on  RC.RequestKey=R.RequestKey
inner join [EPEDPDBSQLCLU].[CentralServer2].base.ModelBase MB with (nolock) on  RC.ModelBaseKey=MB.ModelBaseKey and RecordTypeKey in (0,2)
inner join [EPEDPDBSQLCLU].[CentralServer2].dbo.Applicants A with (nolock) on  R.ApplicantKey=a.ApplicantKey
inner join [EPEDPDBSQLCLU].[CentralServer2].config.CardTypes C with (nolock) on  RC.CardTypeKey=C.CardTypeKey
inner join [EPEDPDBSQLCLU].[CentralServer2].app.Sexes s with (nolock) on  s.Sexkey = a.SexKey
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues BP with (nolock) on  RC.RequestKey=BP.RequestKey and BP.RequestPropertyKey = 39 -- BornPlace BP

left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues NN with (nolock) on  RC.RequestKey=NN.RequestKey and NN.RequestPropertyKey = 5	--NativeNationalityKey --//55 -- NativeNationality NN
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues CN with (nolock) on  RC.RequestKey=CN.RequestKey and CN.RequestPropertyKey = 23	--CurrentNationalityKey --//56 -- CurrentNationality CN

left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues ELK with (nolock) on  RC.RequestKey=ELK.RequestKey and ELK.RequestPropertyKey = 16 -- EducationLevelKey ELK
left outer join [EPEDPDBSQLCLU].[CentralServer2].paraguay.EscolarInstruction EI with (nolock) on  EI.EscolarinstructionKey = ELK.Value -- EscolarInstruction EI


left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues PROFKEY with (nolock) on  RC.RequestKey=PROFKEY.RequestKey and PROFKEY.RequestPropertyKey = 10 -- ProfessionKey PROFKY
left outer join [EPEDPDBSQLCLU].[CentralServer2].paraguay.Professions PROF with (nolock) on  PROF.ProfessionsKey = PROFKEY.Value -- Profession PROF

left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues CIVILSTATUSKEY with (nolock) on  RC.RequestKey=CIVILSTATUSKEY.RequestKey and CIVILSTATUSKEY.RequestPropertyKey = 19 -- CivilStatusKey CIVILSTATUSKEY
left outer join [EPEDPDBSQLCLU].[CentralServer2].paraguay.CivilStatus CS with (nolock) on  CS.CivilStatusKey = CIVILSTATUSKEY.Value -- CivilStatus CS

--9	DateChangeMaritalStatus
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues MS with (nolock) on  RC.RequestKey=MS.RequestKey and MS.RequestPropertyKey = 9 -- DateChangeMaritalStatus MS

--13 CivilStatusCertificate
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues CSC with (nolock) on  RC.RequestKey=CSC.RequestKey and CSC.RequestPropertyKey = 13 -- CivilStatusCertificate CSC

--45 Addresses1
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues ADDR with (nolock) on  RC.RequestKey=ADDR.RequestKey and ADDR.RequestPropertyKey = 45 -- Addresses1 ADDR

--1		Mobile
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues MOB with (nolock) on  RC.RequestKey=MOB.RequestKey and MOB.RequestPropertyKey = 1 -- Mobile MOB

--3	Dead
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues D with (nolock) on  RC.RequestKey=D.RequestKey and D.RequestPropertyKey = 3 -- Dead MOB

--31 OfficceKey
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues OFFKEY with (nolock) on  RC.RequestKey=OFFKEY.RequestKey and OFFKEY.RequestPropertyKey = 31 -- OfficeKey OFFKEY
left outer join [EPEDPDBSQLCLU].[CentralServer2].config.Offices OFFICE with (nolock) on  OFFICE.OfficeKey = OFFKEY.Value -- Code OFFICE


--52 FatherNumberID
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues FCIP with (nolock) on  RC.RequestKey=FCIP.RequestKey and FCIP.RequestPropertyKey = 52 -- FatherNumberID FCIP

--36 FatherName
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues FN with (nolock) on  RC.RequestKey=FN.RequestKey and fn.RequestPropertyKey = 36 -- FatherName FN

--50 FatherLastName
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues FLN with (nolock) on RC.RequestKey=FLN.RequestKey and FLN.RequestPropertyKey = 50 -- FatherLastName FLN 


--37 MotherNumberID
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues MCIP with (nolock) on  RC.RequestKey=MCIP.RequestKey and MCIP.RequestPropertyKey = 37 -- MotherNumberID MCIP

--47 MotherName
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues MN with (nolock) on  RC.RequestKey=MN.RequestKey and MN.RequestPropertyKey = 47 -- MotherName MN

--41 MotherLastName
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues MLN with (nolock) on RC.RequestKey=MLN.RequestKey and MLN.RequestPropertyKey = 41 -- MotherLastName MLN 

--21	SpouseNumberID
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues SCIP with (nolock) on RC.RequestKey=SCIP.RequestKey and SCIP.RequestPropertyKey = 21 -- SpouseNumberID SCIP 

--27	SpouseName
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues SN with (nolock) on  RC.RequestKey=SN.RequestKey and SN.RequestPropertyKey = 27 -- SpouseName SN

--43	SpouseLastName
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues SLN with (nolock) on RC.RequestKey=SLN.RequestKey and SLN.RequestPropertyKey = 43 -- SpouseLastName SLN 

--48	IC	
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.RequestsValues IC with (nolock) on RC.RequestKey=IC.RequestKey and IC.RequestPropertyKey = 48 -- IC IC 

--Users
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.Users AU with (nolock) on AU.UserKey = mb.CreatedByUserKey
left outer join [EPEDPDBSQLCLU].[CentralServer2].dbo.Users MU with (nolock) on MU.UserKey = mb.ModifiedByUserKey

where rc.IssueDate between cast(@p_start_date as datetime) and dateadd(second, -1, dateadd(day,1,cast(@p_end_date as datetime)))
)




GO
/****** Object:  Table [dbo].[mitic_imported_data]    Script Date: 09-Nov-23 7:51:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mitic_imported_data](
	[id_process] [bigint] NOT NULL,
	[cedula] [varchar](128) NULL,
	[ic_ofnac] [nvarchar](50) NULL,
	[ic_feccar] [nvarchar](50) NULL,
	[ic_folio] [nvarchar](50) NULL,
	[ic_tomo] [nvarchar](50) NULL,
	[ic_acta] [nvarchar](50) NULL,
	[prontuario] [bigint] NULL,
	[apellido] [varchar](128) NULL,
	[nombres] [varchar](128) NULL,
	[fech_nacim] [datetime] NULL,
	[lugar_nacim] [varchar](128) NULL,
	[nacional_actual] [int] NULL,
	[nacional_origen] [int] NULL,
	[sexo] [varchar](50) NULL,
	[instruccion] [varchar](128) NULL,
	[profesion] [varchar](128) NULL,
	[estado_civil] [varchar](128) NULL,
	[fech_ecivil] [datetime] NULL,
	[acto_ecivil] [varchar](128) NULL,
	[domicilio] [varchar](128) NULL,
	[barrio_ciudad] [varchar](128) NULL,
	[telefono] [varchar](128) NULL,
	[celular] [varchar](128) NULL,
	[donante_org] [varchar](50) NULL,
	[fallecido] [varchar](128) NULL,
	[tipo_docum] [varchar](50) NULL,
	[ubicacion] [varchar](128) NULL,
	[observaciones] [varchar](128) NULL,
	[padre_cedul] [varchar](128) NULL,
	[padre_nombre] [varchar](128) NULL,
	[padre_apelli] [varchar](128) NULL,
	[madre_cedul] [varchar](128) NULL,
	[madre_nombre] [varchar](128) NULL,
	[madre_apelli] [varchar](128) NULL,
	[conyu_cedul] [varchar](128) NULL,
	[conyu_nombre] [varchar](128) NULL,
	[conyu_apelli] [varchar](128) NULL,
	[acomp_cedul] [varchar](128) NULL,
	[acomp_parent] [varchar](128) NULL,
	[acomp_nombre] [varchar](128) NULL,
	[acomp_apelli] [varchar](128) NULL,
	[fech_autoriz] [datetime] NULL,
	[func_autoriz] [varchar](128) NULL,
	[fech_impresion] [datetime] NULL,
	[func_impresion] [varchar](128) NULL,
	[numero_soporte] [varchar](128) NULL,
	[fech_entrega] [datetime] NULL,
	[func_entrega] [varchar](128) NULL,
	[prontuario_s] [varchar](128) NULL,
	[retirado_por] [varchar](128) NULL,
	[hora_insert] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[process]    Script Date: 09-Nov-23 7:51:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[process](
	[id_process] [bigint] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
 CONSTRAINT [PK_process] PRIMARY KEY CLUSTERED 
(
	[id_process] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [translate].[nationality]    Script Date: 09-Nov-23 7:51:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [translate].[nationality](
	[cod] [int] NOT NULL,
	[descri] [varchar](128) NULL,
	[pais] [varchar](128) NULL,
	[translate_key] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [translate].[profession]    Script Date: 09-Nov-23 7:51:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [translate].[profession](
	[cod] [int] NOT NULL,
	[descri] [varchar](128) NULL,
	[translate_key] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_nationality_description]    Script Date: 09-Nov-23 7:51:46 PM ******/
CREATE NONCLUSTERED INDEX [ix_nationality_description] ON [translate].[nationality]
(
	[descri] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ix_translate_key]    Script Date: 09-Nov-23 7:51:46 PM ******/
CREATE NONCLUSTERED INDEX [ix_translate_key] ON [translate].[nationality]
(
	[translate_key] ASC
)
INCLUDE([cod]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[process] ADD  CONSTRAINT [DF_process_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[mitic_imported_data]  WITH CHECK ADD  CONSTRAINT [FK_mitic_imported_data_mitic_imported_data] FOREIGN KEY([id_process])
REFERENCES [dbo].[process] ([id_process])
GO
ALTER TABLE [dbo].[mitic_imported_data] CHECK CONSTRAINT [FK_mitic_imported_data_mitic_imported_data]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_applicants_data]    Script Date: 09-Nov-23 7:51:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- ======================================================================================================================
-- Author:		CHRISTIAN BALBUENA CAZZOLA | HEJE E.A.S.
-- Create date: 22/0/2023
-- Description:	PROCEDIMIENTO ALMACENADO QUE IMPORTA LOS REGSTROS DE PERSONAS QUE HAN SOLICITADO 
--				DOCUMENTOS ELECTRONICOS POR RANGO DE FECHAS.
-- Parametros:
--				@p_start_date:	Fecha inicio de rango.
--				@p_end_date:	Fecha final de rango.
-- ======================================================================================================================
CREATE proc [dbo].[sp_get_applicants_data]
(
	@p_start_date date,
	@p_end_date date
)
as
begin

--Variable declarations
declare @id_process bigint;

--Crete de PROCESS ID
INSERT INTO [dbo].[process]
           ([date])
     VALUES
           (getdate());



select @id_process = @@IDENTITY; 


--Import The transacctions by the dates ranges.
truncate table [dbo].[mitic_imported_data];

insert into [dbo].[mitic_imported_data]
select	@id_process as id_process, 
		* 
FROM [dbo].[fn_get_applicants_transactions_by_date] (@p_start_date,@p_end_date);


--select * from [dbo].[mitic_imported_data];

end
GO
USE [master]
GO
ALTER DATABASE [PipeLines] SET  READ_WRITE 
GO
