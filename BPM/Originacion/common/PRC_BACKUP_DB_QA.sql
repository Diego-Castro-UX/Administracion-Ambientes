-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE PRC_BACKUP_DB_QA
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @NombreArchivo varchar(200)

	SELECT @NombreArchivo = 'I:\Backup\PichinchaBPMExt_' + REPLACE(convert(nvarchar(20),GetDate(),120),':','-') + '.bak'

	BACKUP DATABASE [PichinchaBPMExt]
	TO  DISK = @NombreArchivo
	WITH CHECKSUM;

END
GO
