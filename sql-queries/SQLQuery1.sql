USE [sample]
GO

/****** Object:  Table [dbo].[works_on]    Script Date: 5/18/2023 9:16:18 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[works_on]') AND type in (N'U'))
DROP TABLE [dbo].[works_on]
GO


