USE [master]
GO
/****** Object:  Database [SphagettiDB]    Script Date: 4/6/2022 9:11:09 PM ******/
CREATE DATABASE [SphagettiDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SphagettiDB', FILENAME = N'D:\SQLDATA\SphagettiDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SphagettiDB_log', FILENAME = N'F:\SQL2LOGS\SphagettiDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SphagettiDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SphagettiDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SphagettiDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SphagettiDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SphagettiDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SphagettiDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SphagettiDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SphagettiDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SphagettiDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SphagettiDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SphagettiDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SphagettiDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SphagettiDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SphagettiDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SphagettiDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SphagettiDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SphagettiDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SphagettiDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SphagettiDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SphagettiDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SphagettiDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SphagettiDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SphagettiDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SphagettiDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SphagettiDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SphagettiDB] SET  MULTI_USER 
GO
ALTER DATABASE [SphagettiDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SphagettiDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SphagettiDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SphagettiDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SphagettiDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SphagettiDB', N'ON'
GO
ALTER DATABASE [SphagettiDB] SET QUERY_STORE = OFF
GO
USE [SphagettiDB]
GO
/****** Object:  User [appdbowner]    Script Date: 4/6/2022 9:11:09 PM ******/

/****** Object:  UserDefinedTableType [dbo].[schedulemenu]    Script Date: 4/6/2022 9:11:09 PM ******/
CREATE TYPE [dbo].[schedulemenu] AS TABLE(
	[MenuId] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[WeekID] [int] NOT NULL
)
GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] NOT NULL,
	[Category] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[MenuItem] [nvarchar](100) NOT NULL,
	[MenuItemUrl] [nvarchar](1000) NOT NULL,
	[Description] [nvarchar](4000) NOT NULL,
	[Price] [smallmoney] NULL,
	[Diet] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
	[Calories] [int] NULL,
	[Charecterstic] [nvarchar](300) NULL,
	[UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuWeek]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuWeek](
	[WeekID] [int] NOT NULL,
	[WeekDay] [nvarchar](100) NULL,
 CONSTRAINT [PK_Week] PRIMARY KEY CLUSTERED 
(
	[WeekID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[MenuId] [int] NOT NULL,
	[WeekID] [int] NOT NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[test]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[test] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[RoleName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Category] ([CategoryID], [Category]) VALUES (1, N'Appetizer')
GO
INSERT [dbo].[Category] ([CategoryID], [Category]) VALUES (2, N'Salad')
GO
INSERT [dbo].[Category] ([CategoryID], [Category]) VALUES (3, N'MainCourse')
GO
INSERT [dbo].[Category] ([CategoryID], [Category]) VALUES (4, N'Dessert')
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (2, N'Grilled Vegetable Bruschetta', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F200707-r-xl-grilled-vegetable-bruschetta.jpg%3Fitok%3DkP4cvjXP&w=1600&q=70', N'What could be more summery than grilled peppers and squash heaped on toasted country bread that''s slathered with fresh basil pesto?', 15.0000, N'V', 1, 200, N'Spicy', CAST(N'2022-04-03T11:01:26.227' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (3, N'Zucchini-and-Pepper Gratin with Herbs and Cheese', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2F200907-r-zucchini-gratin.jpg&w=1600&q=70', N'Pleasantly salty Sbrinz to top a gratin made with a ratatouille, bell peppers and tomato.', 10.0000, N'V', 1, 250, N'Mild', CAST(N'2022-04-03T11:01:26.227' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (4, N'Scallop Ceviche with Aguachile', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201305-xl-scallop-ceviche-with-aguachile.jpg%3Fitok%3DRoCrD6i6&w=1600&q=70', N'Aguachile (chile water) is a vibrant sauce made with fresh chiles, herbs and cucumbers that’s fantastic on any type of fish or shellfish. ', 14.0000, N'NV', 1, 300, N'Spicy', CAST(N'2022-04-03T11:01:26.227' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (5, N'Classic Caesar Salad', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201206-xl-classic-caesar-salad.jpg%3Fitok%3DGbtQ427B&w=1600&q=70', N'Vietnamese summer rolls are often filled with  shrimp or  roast beef from the deli.', 15.0000, N'v', 1, 150, N'Mild', CAST(N'2022-04-04T01:44:19.543' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (6, N'Grilled Tomato Crostini', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201006-r-xl-grilled-tomato-crostini.jpg%3Fitok%3DNCOaJFQW&w=1600&q=70', N'Lightly golden brown toast with tomato.', 11.0000, N'V', 1, 500, N'Sweet', CAST(N'2022-04-04T01:44:03.967' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (7, N'Pickled Shrimp with Creamy Spinach Dip', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201106-xl-pickled-shrimp.jpg%3Fitok%3DIkKE-_0Z&w=1600&q=70', N' fresh-tasting tomato soup : tops it with tomatoes, olives, honeyed cucumbers and feta.', 11.0000, N'NV', 1, 150, N'Spicy', CAST(N'2022-04-04T00:23:43.433' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (8, N'Miso Soup with Turmeric and Tofu', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201403-xl-miso-soup-with-turmeric-and-tofu.jpg%3Fitok%3DU3Ca3Ky4&w=1600&q=70', N'Miso soup gets re-imagined by blogger Heidi Swanson, with brilliant yellow turmeric for additional flavor and color.', 16.0000, N'V', 1, 100, N'Spicy', CAST(N'2022-04-03T11:01:26.227' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (9, N'Mint and Pea Soup', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2F1492007865%2Fmint-and-pea-soup-great-dixter-cookbook-XL-SS0417.jpg&w=1600&q=70', N'Mint gives this soup a wonderfully fresh taste, and it makes a perfect lunch with some bread and cheese on the side.', 13.0000, N'V', 1, 200, N'Mild', CAST(N'2022-04-03T11:01:26.227' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (10, N'Strawberry Almond Cheesecake with Matzoh Crust', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F1522077914%2Fstrawberry-almond-cheesecake-with-matzo-crust-FT-RECIPE2018.jpg%3Fitok%3DznBmOoO5&w=1600&q=70,', N'This silky cheesecake gets sweetness and tang from a blend of cream cheese and sour cream.', 15.0000, N'V', 1, 250, N'Mild', CAST(N'2022-04-04T01:44:35.860' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (11, N'Apple Tart with Apricot Glaze', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2F1535553436%2Fapple-tart-with-apricot-glaze-XL-RECIPE1018.jpg&w=1600&q=70', N'This tart is the final dish in a dinner party menu designed by Stitt and inspired by Olney’s love of seasonal produce and great wine.', 34.0000, N'V', 1, 500, N'Spicy', CAST(N'2022-04-06T13:31:47.923' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (12, N'Roast Beef Summer Rolls', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2F200909-xl-roast-beef-summer-rolls_0.jpg&w=1600&q=70', N'Aguachile (chile water) is a vibrant sauce made with fresh chiles, herbs and cucumbers that’s fantastic on any type of fish or shellfish. ', 20.0000, N'NV', 1, 500, N'Mild', CAST(N'2022-04-04T11:34:26.390' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (13, N'Grilled Tomato Crostini', N' https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201006-r-xl-grilled-tomato-crostini.jpg%3Fitok%3DNCOaJFQW&w=1600&q=70', N'Lightly golden brown toast with tomato.', 15.0000, N'V', 1, 300, N'Mild', CAST(N'2022-04-04T11:34:30.013' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (14, N'Pickled Shrimp with Creamy Spinach Dip', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201106-xl-pickled-shrimp.jpg%3Fitok%3DIkKE-_0Z&w=1600&q=70', N'James Holmes grew up in Texas but didn''t learn how to make pickled shrimp, a Gulf specialty, until he took a job at a New York City restaurant', 15.0000, N'NV', 1, 400, N'Spicy', CAST(N'2022-04-04T11:34:33.187' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (15, N'Tomato Soup with Feta, Olives and Cucumbers', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201409-xl-tomato-soup-with-feta-olives-and-cucumber.jpg%3Fitok%3DwVUbCG-4&w=1600&q=70', N'This pretty, fresh-tasting tomato soup is David Chang’s riff on Greek salad: He tops it with tomatoes, olives, honeyed cucumbers and feta.', 25.0000, N'V', 1, 200, N'Spicy', CAST(N'2022-04-04T11:34:36.670' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (16, N'Miso Soup with Turmeric and Tofu', N'https://imagesvc.timeincapp.com/v3/mm/image?url=https%3A%2F%2Fcdn-image.foodandwine.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F201403-xl-miso-soup-with-turmeric-and-tofu.jpg%3Fitok%3DU3Ca3Ky4&w=1600&q=70', N'Miso soup gets re-imagined by blogger Heidi Swanson, who adds earthy, brilliant yellow turmeric for additional flavor and color.', 12.0000, N'V', 1, 400, N'Mild', CAST(N'2022-04-04T11:34:40.610' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (17, N'Masala Dosa', N'https://b.zmtcdn.com/data/pictures/7/18896837/9bfc04732beb60e473f1833848447d5f.jpg?output-format=webp', N'Made with rice and lentils fermented naturally', 14.0000, N'V', 1, 200, N'Spicy', CAST(N'2022-04-04T13:33:52.603' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (18, N'Poori', N'https://b.zmtcdn.com/data/dish_photos/256/26af11a74ea045de9df8d93bf72af256.jpg?output-format=webp', N'Made with fresh wheat rolled to thin crepes and potato curry', 25.0000, N'V', 1, 400, N'Spicy', CAST(N'2022-04-06T20:44:27.577' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (19, N'Mangalore Bajji', N'https://b.zmtcdn.com/data/dish_photos/018/4579df5213425055e304fda66f173018.jpg?output-format=webp', N'Made with fresh wheat batter with tasty peanut chutney  ', 13.0000, N'V', 1, 400, N'Spicy', CAST(N'2022-04-04T13:33:48.510' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (20, N'South Indian Thali', N'https://b.zmtcdn.com/data/dish_photos/424/3a19dd93fb46a3bb8bfd662c988a9424.jpg?fit=around|130:130&crop=130:130;*,*', N'course of meals with curries and tasty snacks', 14.0000, N'V', 1, 600, N'Spicy', CAST(N'2022-04-04T13:33:46.993' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (21, N'Mushroom Hot Dog', N'https://www.connoisseurusveg.com/wp-content/uploads/2017/06/portobello-mushroom-hot-dogs.jpg', N'hot dof with veg ', 14.0000, N'V', 1, 600, N'Spicy', CAST(N'2022-04-04T13:33:45.133' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (22, N'Caramel Pecan Cheesecake', N'https://sugarspunrun.com/wp-content/uploads/2019/01/Best-Cheesecake-Recipe-2-1-of-1-4.jpg', N'Caramel Pecan Cheesecake', 20.0000, N'V', 1, 500, N'Mild', CAST(N'2022-04-04T14:44:20.790' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (23, N'Vanilla Cupcake with Chocolate Buttercream - Pack of Two', N'https://natashaskitchen.com/wp-content/uploads/2020/05/Vanilla-Cupcakes-3.jpg', N'Vanilla Cupcake with Chocolate Buttercream - Pack of Two', 20.0000, N'V', 1, 500, N'Mild', CAST(N'2022-04-04T14:44:53.760' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (24, N'Strawberry Sour Cream Coffee Cake', N'https://sugargeekshow.com/wp-content/uploads/2019/07/fresh-strawberry-cake-5.jpg', N'Strawberry Sour Cream Coffee Cake', 20.0000, N'V', 1, 500, N'Mild', CAST(N'2022-04-04T14:45:26.903' AS DateTime))
GO
INSERT [dbo].[Menu] ([MenuID], [MenuItem], [MenuItemUrl], [Description], [Price], [Diet], [IsActive], [Calories], [Charecterstic], [UpdateDate]) VALUES (25, N'Vanilla Ice Cream', N'https://images.media-allrecipes.com/userphotos/1293054.jpg', N'Vanilla Ice Cream', 20.0000, N'V', 1, 500, N'Mild', CAST(N'2022-04-04T14:51:00.177' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
INSERT [dbo].[MenuWeek] ([WeekID], [WeekDay]) VALUES (1, N'Sunday')
GO
INSERT [dbo].[MenuWeek] ([WeekID], [WeekDay]) VALUES (2, N'Monday')
GO
INSERT [dbo].[MenuWeek] ([WeekID], [WeekDay]) VALUES (3, N'Tuesday')
GO
INSERT [dbo].[MenuWeek] ([WeekID], [WeekDay]) VALUES (4, N'Wednesday')
GO
INSERT [dbo].[MenuWeek] ([WeekID], [WeekDay]) VALUES (5, N'Thursday')
GO
INSERT [dbo].[MenuWeek] ([WeekID], [WeekDay]) VALUES (6, N'Friday')
GO
INSERT [dbo].[MenuWeek] ([WeekID], [WeekDay]) VALUES (7, N'Saturday')
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (1, 1, 2, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (2, 1, 2, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (3, 1, 2, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (4, 1, 2, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (5, 1, 2, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (6, 1, 2, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (7, 1, 2, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (8, 1, 3, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (9, 1, 3, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (10, 1, 3, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (11, 1, 3, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (12, 1, 3, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (13, 1, 3, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (14, 1, 3, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (15, 2, 3, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (16, 2, 3, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (17, 2, 3, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (18, 2, 3, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (19, 2, 3, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (20, 2, 3, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (21, 2, 3, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (22, 1, 4, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (23, 1, 4, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (24, 1, 4, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (25, 1, 4, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (26, 1, 4, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (27, 1, 4, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (28, 1, 4, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (29, 2, 5, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (30, 2, 5, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (31, 2, 5, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (32, 2, 5, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (33, 2, 5, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (34, 2, 5, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (35, 2, 5, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (36, 1, 6, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (37, 1, 6, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (38, 1, 6, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (39, 1, 6, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (40, 1, 6, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (41, 1, 6, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (42, 1, 6, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (43, 2, 6, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (44, 2, 6, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (45, 2, 6, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (46, 2, 6, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (47, 2, 6, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (48, 2, 6, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (49, 2, 6, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (50, 3, 7, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (51, 3, 7, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (52, 3, 7, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (53, 3, 7, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (54, 3, 7, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (55, 3, 7, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (56, 3, 7, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (57, 1, 8, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (58, 1, 8, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (59, 1, 8, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (60, 1, 8, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (61, 1, 8, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (62, 1, 8, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (63, 1, 8, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (64, 4, 10, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (65, 4, 10, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (66, 4, 10, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (67, 4, 10, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (68, 4, 10, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (69, 4, 10, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (70, 4, 10, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (71, 3, 12, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (72, 3, 12, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (73, 3, 12, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (74, 3, 12, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (75, 3, 12, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (76, 3, 12, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (77, 3, 12, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (78, 4, 22, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (79, 4, 22, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (80, 4, 22, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (81, 4, 22, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (82, 4, 22, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (83, 4, 22, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (84, 4, 22, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (85, 1, 9, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (86, 1, 9, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (87, 1, 9, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (88, 1, 9, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (89, 1, 9, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (90, 1, 9, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (91, 1, 9, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (92, 4, 11, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (93, 4, 11, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (94, 4, 11, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (95, 4, 11, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (96, 4, 11, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (97, 4, 11, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (98, 4, 11, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (99, 2, 13, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (100, 2, 13, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (101, 2, 13, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (102, 2, 13, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (103, 2, 13, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (104, 2, 13, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (105, 2, 13, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (106, 3, 14, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (107, 3, 14, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (108, 3, 14, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (109, 3, 14, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (110, 3, 14, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (111, 3, 14, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (112, 3, 14, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (113, 1, 15, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (114, 1, 15, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (115, 1, 15, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (116, 1, 15, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (117, 1, 15, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (118, 1, 15, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (119, 1, 15, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (120, 1, 16, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (121, 1, 16, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (122, 1, 16, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (123, 1, 16, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (124, 1, 16, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (125, 1, 16, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (126, 1, 16, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (127, 3, 17, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (128, 3, 17, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (129, 3, 17, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (130, 3, 17, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (131, 3, 17, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (132, 3, 17, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (133, 3, 17, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (134, 3, 18, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (135, 3, 18, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (136, 3, 18, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (137, 3, 18, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (138, 3, 18, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (139, 3, 18, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (140, 3, 18, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (141, 1, 19, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (142, 1, 19, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (143, 1, 19, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (144, 1, 19, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (145, 1, 19, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (146, 1, 19, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (147, 1, 19, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (148, 3, 20, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (149, 3, 20, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (150, 3, 20, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (151, 3, 20, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (152, 3, 20, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (153, 3, 20, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (154, 3, 20, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (155, 2, 21, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (156, 2, 21, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (157, 2, 21, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (158, 2, 21, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (159, 2, 21, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (160, 2, 21, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (161, 2, 21, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (162, 4, 23, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (163, 4, 23, 2)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (164, 4, 23, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (165, 4, 23, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (166, 4, 23, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (167, 4, 23, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (168, 4, 23, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (169, 4, 24, 1)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (170, 4, 24, 3)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (171, 4, 24, 5)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (172, 4, 24, 7)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (173, 4, 24, 6)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (174, 4, 24, 4)
GO
INSERT [dbo].[Schedule] ([ScheduleID], [CategoryID], [MenuId], [WeekID]) VALUES (175, 4, 24, 2)
GO
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
INSERT [dbo].[test] ([test]) VALUES (100)
GO
INSERT [dbo].[test] ([test]) VALUES (100)
GO
INSERT [dbo].[test] ([test]) VALUES (100)
GO
INSERT [dbo].[test] ([test]) VALUES (100)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[test] ([test]) VALUES (200)
GO
INSERT [dbo].[Users] ([Id], [UserName], [RoleName]) VALUES (1, N'buyer', N'Customer')
GO
INSERT [dbo].[Users] ([Id], [UserName], [RoleName]) VALUES (2, N'cook', N'chef')
GO
INSERT [dbo].[Users] ([Id], [UserName], [RoleName]) VALUES (3, N'adam', N'Manager')
GO
ALTER TABLE [dbo].[Menu] ADD  CONSTRAINT [DF_Menu_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Menu] ADD  CONSTRAINT [DF_Menu_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO
/****** Object:  StoredProcedure [dbo].[get_Schedule_menu]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE      PROCEDURE [dbo].[get_Schedule_menu]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select distinct mn.MenuID,mn.MenuItem, mn.[Charecterstic],mn.[Calories], mn.[IsActive],mn.[Diet],mn.[Price],mn.[Description], mn.[MenuItemUrl],
wk.[WeekID],ca.[Category] into #temp

from [dbo].[Schedule] sc
join [dbo].[Category] ca on sc.[CategoryID]=ca.[CategoryID]
 join dbo.menu mn on sc.[MenuID]=mn.[MenuID]
join [dbo].[MenuWeek] wk on wk.[WeekID]=sc.[WeekID]
where  mn.[MenuID] in (select MenuID from dbo.menu) and mn.[IsActive]=1







 Select A.*,
     Min(Case  A.[Category] When 'Appetizer' Then  A.WeekID End) Appetizer,
     Min(Case  A.[Category] When 'Salad' Then  A.WeekID End) Salad,
          Min(Case  A.[Category] When 'MainCourse' Then  A.WeekID End) [MainCourse],
              Min(Case  A.[Category] When 'Dessert' Then  A.WeekID End) Dessert


   into #temp2
   From #temp A
  Group By  A.MenuID,A.MenuItem, A.[Charecterstic],A.[Calories], A.[IsActive],A.[Diet],A.[Price],A.[Description], A.[MenuItemUrl],A.[Category],A.WeekID




  SELECT distinct SS.MenuID,SS.MenuItem, SS.[Charecterstic],SS.[Calories], SS.[IsActive],SS.[Diet],SS.[Price],SS.[Description], SS.[MenuItemUrl],
   STUFF((SELECT ',' + trim(str (US.Appetizer)) 
          FROM #temp2 US
          WHERE US.MenuID = SS.MenuID
          FOR XML PATH('')), 1, 1, '') [Appetizer],


		   STUFF((SELECT ',' + trim(str( US.Salad ))
          FROM #temp2 US
          WHERE US.MenuID = SS.MenuID
          FOR XML PATH('')), 1, 1, '') [Salad],


          
		   STUFF((SELECT ',' + trim(str( US.[MainCourse] ))
          FROM #temp2 US
          WHERE US.MenuID = SS.MenuID
          FOR XML PATH('')), 1, 1, '') [MainCourse],

          
		   STUFF((SELECT ',' + trim(str( US.[Dessert] ))
          FROM #temp2 US
          WHERE US.MenuID = SS.MenuID
          FOR XML PATH('')), 1, 1, '') [Dessert]





FROM #temp2 SS
GROUP BY SS.MenuID,SS.MenuItem, SS.[Charecterstic],SS.[Calories], SS.[IsActive],SS.[Diet],SS.[Price],SS.[Description], SS.[MenuItemUrl]

union 

  SELECT distinct SS.MenuID,SS.MenuItem, SS.[Charecterstic],SS.[Calories], SS.[IsActive],SS.[Diet],SS.[Price],SS.[Description], SS.[MenuItemUrl],
  null as [Appetizer]  ,null as [Salad] ,null as [MainCourse],null as  [Dessert]
from dbo.menu ss
where ss.MenuID not in (select MenuID from #temp2)

ORDER BY 1
 drop table #temp
  drop table #temp2


END
GO
/****** Object:  StoredProcedure [dbo].[GetItemsForDay]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetItemsForDay]
AS
BEGIN


SELECT distinct  cat.CategoryID,cat.Category ,mn.MenuID,mn.MenuItem,mn.MenuItemUrl,mn.Price,mn.Charecterstic,mn.[Description],mn.diet,mn.Calories   from dbo.Category cat 
join dbo.Schedule sc on cat.CategoryID=sc.CategoryID
join Menu mn on mn.MenuID=sc.MenuId and mn.IsActive=1
and sc.WeekID=(SELECT datepart(WEEKDAY, GETDATE()+1))
--FOR JSON auto, INCLUDE_NULL_VALUES



  
  END
GO
/****** Object:  StoredProcedure [dbo].[GetMenuitems]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetMenuitems]
	
AS
BEGIN
SELECT *
  FROM [dbo].[Menu]
  order by [UpdateDate]desc
  
  END
GO
/****** Object:  StoredProcedure [dbo].[GetuserRole]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetuserRole]
	@username nvarchar(100)
AS
BEGIN
	select [RoleName] from [dbo].[Users] where UserName=@username
END
GO
/****** Object:  StoredProcedure [dbo].[insert_menu]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[insert_menu]
	@MenuItem  nvarchar(100) null
      ,@MenuItemUrl nvarchar(1000) null
      ,@Description nvarchar(4000) null
      ,@Price smallmoney null
      ,@Diet nvarchar(500) null
    ,@IsActive bit =1
      ,@Calories int null
      ,@Charecterstic nvarchar(300) null
AS
BEGIN


INSERT INTO [dbo].[Menu]
           ([MenuItem]
           ,[MenuItemUrl]
           ,[Description]
           ,[Price]
           ,[Diet]
           ,[IsActive]
           ,[Calories]
           ,[Charecterstic],[UpdateDate])
     VALUES
           (@MenuItem
           ,@MenuItemUrl
           ,@Description
           ,@Price
           ,@Diet
           ,1
           ,@Calories
           ,@Charecterstic,getdate())




END


select 'Success'
GO
/****** Object:  StoredProcedure [dbo].[insertschedule]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   PROCEDURE [dbo].[insertschedule](
  
  @tabledata dbo.schedulemenu READONLY
 
) 
AS
	BEGIN
	truncate table [dbo].[Schedule]


            if( (Select count(*) from @tabledata) > 0)

            begin 

            INSERT INTO dbo.schedule ([CategoryID],
                [MenuId],[WeekID])
                
                
                select [CategoryID],
                [MenuId],[WeekID] from @tabledata
                END
            end 


select 'Success'
GO
/****** Object:  StoredProcedure [dbo].[update_menu]    Script Date: 4/6/2022 9:11:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[update_menu]
@MenuId int
	,@MenuItem  nvarchar(100) null
      ,@MenuItemUrl nvarchar(1000) null
      ,@Description nvarchar(4000) null
      ,@Price smallmoney null
      ,@Diet nvarchar(500) null
    ,@IsActive bit =1
      ,@Calories int null
      ,@Charecterstic nvarchar(300) null
AS
BEGIN


UPDATE [dbo].[Menu]
   SET 
   [MenuItem] =@MenuItem
      ,[MenuItemUrl] = @MenuItemUrl
      ,[Description] = @Description
      ,[Price] = @Price
     
       ,[Diet] = @Diet
     
      ,[Calories] = @Calories
      ,[Charecterstic] = @Charecterstic
      ,IsActive=@IsActive
	  ,[UpdateDate]=GETDATE()
 WHERE Menuid=@MenuId

END


select 'Success'
GO
USE [master]
GO
ALTER DATABASE [SphagettiDB] SET  READ_WRITE 
GO
