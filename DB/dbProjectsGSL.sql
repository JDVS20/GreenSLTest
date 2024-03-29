USE [master]
GO
/****** Object:  Database [projectsGSL]    Script Date: 1/9/2019 2:27:12 p. m. ******/
CREATE DATABASE [projectsGSL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'projects', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\projectsGSL.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'projects_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\projectsGSL_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [projectsGSL] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [projectsGSL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [projectsGSL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [projectsGSL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [projectsGSL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [projectsGSL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [projectsGSL] SET ARITHABORT OFF 
GO
ALTER DATABASE [projectsGSL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [projectsGSL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [projectsGSL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [projectsGSL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [projectsGSL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [projectsGSL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [projectsGSL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [projectsGSL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [projectsGSL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [projectsGSL] SET  ENABLE_BROKER 
GO
ALTER DATABASE [projectsGSL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [projectsGSL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [projectsGSL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [projectsGSL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [projectsGSL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [projectsGSL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [projectsGSL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [projectsGSL] SET RECOVERY FULL 
GO
ALTER DATABASE [projectsGSL] SET  MULTI_USER 
GO
ALTER DATABASE [projectsGSL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [projectsGSL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [projectsGSL] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [projectsGSL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [projectsGSL] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'projectsGSL', N'ON'
GO
ALTER DATABASE [projectsGSL] SET QUERY_STORE = OFF
GO
USE [projectsGSL]
GO
/****** Object:  Table [dbo].[tb_UserProject]    Script Date: 1/9/2019 2:27:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_UserProject](
	[userId] [int] NOT NULL,
	[projectId] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[assignedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_User]    Script Date: 1/9/2019 2:27:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_User](
	[id] [int] NOT NULL,
	[firstName] [varchar](50) NOT NULL,
	[lastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK__tb_User__3213E83F772BE6E0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Project]    Script Date: 1/9/2019 2:27:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Project](
	[id] [int] NOT NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NOT NULL,
	[credits] [int] NOT NULL,
 CONSTRAINT [PK__tb_Proje__3213E83F0FF09570] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewUserProjects]    Script Date: 1/9/2019 2:27:13 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewUserProjects] AS 

SELECT usp.projectId
	, CONCAT(YEAR(p.startDate), '-', MONTH(p.startDate), '-' , DAY(p.startDate)) AS startDate
	, CASE WHEN DATEDIFF(DAY, p.startDate, usp.assignedDate) > 0 
		THEN CAST(DATEDIFF(DAY, p.startDate, usp.assignedDate) AS VARCHAR(10))  
		ELSE 'Started' END AS timestart
	, CONCAT(YEAR(p.endDate), '-', MONTH(p.endDate), '-' , DAY(p.endDate)) AS endDate
	, p.credits AS credits
	, CASE WHEN usp.isActive = 1 THEN 'Active' ELSE 'Inactive' END AS status	
	FROM tb_UserProject usp
	INNER JOIN tb_Project p ON p.id = usp.projectId 
	INNER JOIN tb_User u ON u.id = usp.userId
GO
INSERT [dbo].[tb_Project] ([id], [startDate], [endDate], [credits]) VALUES (7, CAST(N'2016-05-31T00:00:00.000' AS DateTime), CAST(N'2016-08-12T00:00:00.000' AS DateTime), 111)
INSERT [dbo].[tb_Project] ([id], [startDate], [endDate], [credits]) VALUES (9, CAST(N'2017-08-11T00:00:00.000' AS DateTime), CAST(N'2017-12-11T00:00:00.000' AS DateTime), 100)
INSERT [dbo].[tb_Project] ([id], [startDate], [endDate], [credits]) VALUES (15, CAST(N'2017-01-07T00:00:00.000' AS DateTime), CAST(N'2017-07-28T00:00:00.000' AS DateTime), 97)
INSERT [dbo].[tb_Project] ([id], [startDate], [endDate], [credits]) VALUES (21, CAST(N'2018-02-20T00:00:00.000' AS DateTime), CAST(N'2018-06-15T00:00:00.000' AS DateTime), 124)
INSERT [dbo].[tb_Project] ([id], [startDate], [endDate], [credits]) VALUES (32, CAST(N'2018-09-16T00:00:00.000' AS DateTime), CAST(N'2018-12-24T00:00:00.000' AS DateTime), 200)
INSERT [dbo].[tb_User] ([id], [firstName], [lastName]) VALUES (2, N'Maria', N'Perez')
INSERT [dbo].[tb_User] ([id], [firstName], [lastName]) VALUES (8, N'Juan', N'Mendoza')
INSERT [dbo].[tb_User] ([id], [firstName], [lastName]) VALUES (15, N'Pablo', N'Morera')
INSERT [dbo].[tb_UserProject] ([userId], [projectId], [isActive], [assignedDate]) VALUES (8, 15, 1, CAST(N'2017-01-04T00:00:00.000' AS DateTime))
INSERT [dbo].[tb_UserProject] ([userId], [projectId], [isActive], [assignedDate]) VALUES (2, 9, 1, CAST(N'2017-08-29T00:00:00.000' AS DateTime))
INSERT [dbo].[tb_UserProject] ([userId], [projectId], [isActive], [assignedDate]) VALUES (15, 32, 0, CAST(N'2018-10-10T00:00:00.000' AS DateTime))
INSERT [dbo].[tb_UserProject] ([userId], [projectId], [isActive], [assignedDate]) VALUES (15, 21, 0, CAST(N'2018-01-30T00:00:00.000' AS DateTime))
INSERT [dbo].[tb_UserProject] ([userId], [projectId], [isActive], [assignedDate]) VALUES (2, 7, 1, CAST(N'2016-04-17T00:00:00.000' AS DateTime))
ALTER TABLE [dbo].[tb_UserProject]  WITH CHECK ADD  CONSTRAINT [FK__tb_UserPr__proje__3A81B327] FOREIGN KEY([projectId])
REFERENCES [dbo].[tb_Project] ([id])
GO
ALTER TABLE [dbo].[tb_UserProject] CHECK CONSTRAINT [FK__tb_UserPr__proje__3A81B327]
GO
ALTER TABLE [dbo].[tb_UserProject]  WITH CHECK ADD  CONSTRAINT [FK__tb_UserPr__userI__3B75D760] FOREIGN KEY([userId])
REFERENCES [dbo].[tb_User] ([id])
GO
ALTER TABLE [dbo].[tb_UserProject] CHECK CONSTRAINT [FK__tb_UserPr__userI__3B75D760]
GO
USE [master]
GO
ALTER DATABASE [projectsGSL] SET  READ_WRITE 
GO
