/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-20
 Backup:		Backup der 
 Description:	Sichert die Datenbank Zimmersport mit einem Zeitstempel als bak-Datei. Durch den 
				Aufruf dieses Scripts kann z.B. mittels Windows-Aufgabenplanung immer zu einem
				betimmten Zeitpunkt automatisch Backups erstellt werden.
 Info:			state			=> 0 bedeutet, dass die Datenbank online ist
				is_in_standby	=> Datenbank ist nicht readonly (wg. log)
 History
 2020-08-19 ok	Lorem ipsum...
 ====================================================================================================*/
USE [master]
GO

declare @database	varchar(256) = 'Zimmersport'					  -- Dateiname des Backups
declare @path		varchar(max) = 'D:\DB\'							  -- Pfad
declare @filedate	varchar(20)	 = CONVERT(VARCHAR(20),GETDATE(),112) -- Datum
declare @pathfile	varchar(max)

-- Prüft, ob Datenbank gesichert werden kann 
IF((SELECT name FROM master.sys.databases WHERE name = @database AND state = 0 AND is_in_standby = 0) = @database)
BEGIN
	SET @pathfile = @path + @fileDate + '_' + @database + '.bak' 
	BACKUP DATABASE @database TO DISK = @pathfile
END
GO
