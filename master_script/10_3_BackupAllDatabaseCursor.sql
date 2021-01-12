/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-21
 Description:	Sichert ALLE Datenbanken ausser dem Systemdatenbanken. Die Sicherung wird mittels einem
				CURSOR realisiert.
				Das Script immr wiederum z.B. mittels Windows-Aufgabenplanung immer zu einem bestimmten 
				immer Zeitpunkt aufgerufen werden um Sicherungen der DB durchzuführen
 History
 2020-08-19 dj	Lorem ipsum...
 ====================================================================================================*/
USE [master]
GO

declare @database	varchar(256)									  -- Dateiname des Backups
declare @path		varchar(max) = 'D:\DB\'							  -- Pfad
declare @filedate	varchar(20)	 = CONVERT(VARCHAR(20),GETDATE(),112) -- Datum
declare @pathfile	varchar(max)


DECLARE cursor1 CURSOR 
FOR 
	SELECT 
		name FROM master.sys.databases 
	WHERE 
		name NOT IN ('master','model','msdb','tempdb')  --ohne Sytemdatenbanken
	AND 
		state = 0 AND is_in_standby = 0

OPEN cursor1
	
	FETCH NEXT FROM cusor1 INTO @database
	WHILE @@FETCH_STATUS=0
	BEGIN
		SET @pathfile = @path + @fileDate + '_' + @database + '.bak' 
		BACKUP DATABASE @database TO DISK = @pathfile
	
		--noch DB zum sichern da
		FETCH NEXT FROM cusor1 INTO @database
	END

CLOSE cursor1
DEALLOCATE cursor1


