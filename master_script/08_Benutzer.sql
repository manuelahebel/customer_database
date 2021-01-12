USE [master]
GO

/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-19
 Anmeldung:		20200819_Reader1, 20200819_Reader2, 20200819_Writer, 20200819_Exec
 Description:	Erstellung von Anmeldungen für 4 Benuter in der DB ZimmerSport
 History
 2020-08-19 	Anmeldung erstellt
 2020-08-20 dj	Erweiterung, damit Script immer ohne Fehler ausgeführt werden kann
====================================================================================================*/
BEGIN
	IF NOT EXISTS(select * from sys.server_principals where name='20200819_Reader1' AND type='S')
		CREATE LOGIN [20200819_Reader1] WITH PASSWORD=N'123', DEFAULT_DATABASE=[ZimmerSport], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
	IF NOT EXISTS(select * from sys.server_principals where name='20200819_Reader2' AND type='S')
		CREATE LOGIN [20200819_Reader2] WITH PASSWORD=N'123', DEFAULT_DATABASE=[ZimmerSport], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
	IF NOT EXISTS(select * from sys.server_principals where name='20200819_Writer' AND type='S')
		CREATE LOGIN [20200819_Writer]  WITH PASSWORD=N'123', DEFAULT_DATABASE=[ZimmerSport], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
	IF NOT EXISTS(select * from sys.server_principals where name='20200819_Exec' AND type='S')
		CREATE LOGIN [20200819_Exec]    WITH PASSWORD=N'123', DEFAULT_DATABASE=[ZimmerSport], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
END
GO


/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-19
 Benutzer:		20200819_Reader1
 Description:	Erstellung eines Benutzers für die DB ZimmerSport mit Leseberechtigungen
				Zuweisung der einzelnen Leseberechtigung zum Benutzer
 History
 2020-08-19 mp	Benutzer erstellen und Leseberechtigungen erteilen
 2020-08-20 dj	Erweiterung, damit Script immer ohne Fehler ausgeführt werden kann
====================================================================================================*/
USE [ZimmerSport]
GO
IF NOT EXISTS(select * from sys.database_principals WHERE name='20200819_Reader1' AND type='S')
	CREATE USER [20200819_Reader1] FOR LOGIN [20200819_Reader1]
GO

BEGIN
	GRANT SELECT ON [dbo].[tb_Person] ([Vorname]) TO [20200819_Reader1]
	GRANT SELECT ON [dbo].[tb_Kurs]	([Enddatum]) TO [20200819_Reader1]
	GRANT SELECT ON [dbo].[tb_Kurs] ([MinTeilnehmerzahl]) TO [20200819_Reader1]
	GRANT SELECT ON [dbo].[tb_Person] ([Geburtsdatum]) TO [20200819_Reader1]
	GRANT SELECT ON [dbo].[tb_Kurs] ([Startdatum]) TO [20200819_Reader1]
	GRANT SELECT ON [dbo].[tb_Person] ([Geschlecht]) TO [20200819_Reader1]
	GRANT SELECT ON [dbo].[vw_KurseMitPlatz] ([AktuelleTeilnehmerzahl]) TO [20200819_Reader1]
	GRANT SELECT ON [dbo].[tb_Kurs]	([Preis]) TO [20200819_Reader1]
	GRANT SELECT ON [dbo].[tb_Kurs]	([MaxTeilnehmerzahl]) TO [20200819_Reader1]
END
GO


/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-19
 Benutzer:		20200819_Writer
 Description:	Erstellung eines Benutzers für die DB ZimmerSport mit Schreibberechtigungen
				Zuweisung der einzelnen Schreibberechtigungen zum Benutzer
 History
 2020-08-19 mp	Benutzer erstellen und Leseberechtigungen sowie Schreibberechtigungen erteilen
 2020-08-20 dj	Erweiterung, damit Script immer ohne Fehler ausgeführt werden kann
====================================================================================================*/
USE [ZimmerSport]
GO
IF NOT EXISTS(select * from sys.database_principals WHERE name='20200819_Writer' AND type='S')
	CREATE USER [20200819_Writer] FOR LOGIN [20200819_Writer]
GO

BEGIN
	GRANT SELECT ON [dbo].[tb_Person] TO [20200819_Writer]
	GRANT INSERT ON [dbo].[tb_Person] TO [20200819_Writer]
	GRANT SELECT ON [dbo].[vw_AllePersonen] TO [20200819_Writer]
	GRANT SELECT ON [dbo].[vw_TrainerTeilnehmer] TO [20200819_Writer]
	GRANT SELECT ON [dbo].[tb_TeilnehmerKurs] TO [20200819_Writer]
	GRANT INSERT ON [dbo].[tb_TeilnehmerKurs] TO [20200819_Writer]
	GRANT SELECT ON [dbo].[vw_KurseMitPlatz] TO [20200819_Writer]
	GRANT SELECT ON [dbo].[vw_Trainer] TO [20200819_Writer]
END
GO


/* ====================================================================================================
 Author:			 xxx
 CreateDate:		 2020-08-19
 Anmeldung/Benutzer: 20200819_Reader2
 Description:		 Erstellung eines Benutzers für die DB ZimmerSport mit Leseberechtigungen
					 Zuweisung der einzelnen Leseberechtigung zum Benutzer
 History
 2020-08-19	mh		 erstellt
 2020-08-20 dj		 Erweiterung, damit Script immer ohne Fehler ausgeführt werden kann
====================================================================================================*/
USE [ZimmerSport]
GO
IF NOT EXISTS(select * from sys.database_principals WHERE name='20200819_Reader2' AND type='S')
	CREATE USER [20200819_Reader2] FOR LOGIN [20200819_Reader2]
GO

ALTER ROLE [db_datareader] ADD MEMBER [20200819_Reader2]
GO

BEGIN
	GRANT SELECT ON [dbo].[tb_Rolle] ([Bezeichnung]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_PlzOrt] ([Bundesland]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Person] ([Strasse]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Person] ([Nachname]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Trainer] ([Beitrittsdatum]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Teilnehmer] ([Beitrittsdatum]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Person] ([Geschlecht]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[vw_AllePersonen] TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Trainer] ([LeistungssportErfahrung]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Person] ([Vorname]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Person] ([EMail]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_PlzOrt] ([Ort]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_PersonRolle] ([Beitrittsdatum]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Trainer] ([HonorarVereinbarung]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Person] ([Geburtsdatum]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Erfahrung] ([Bezeichnung]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Trainer] ([SportBackground]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Sportlichkeit] ([Bezeichnung]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Trainer] ([TrainerErfahrung]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_PlzOrt] ([PLZ]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Trainer] ([FunctionalTrainingErfahrung]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Kontraindikation] ([Bezeichnung]) TO [20200819_Reader2]
	GRANT SELECT ON [dbo].[tb_Person] ([Hausnummer]) TO [20200819_Reader2]
END
GO


/* ====================================================================================================
 Author:				xxx
 CreateDate:			2020-08-19
 Benutzer: 				20200819_Exec
 Description:			Erstellung eines Benutzers für die DB ZimmerSport mit Ausführrechten
						Zuweisung der einzelnen Ausführrechten zum Benutzer
 History
 2020-08-19				mh	erstellt
 2020-08-20 dj		    Erweiterung, damit Script immer ohne Fehler ausgeführt werden kann
====================================================================================================*/
USE [ZimmerSport]
GO
IF NOT EXISTS(select * from sys.database_principals WHERE name='20200819_Exec' AND type='S')
	CREATE USER [20200819_Exec] FOR LOGIN [20200819_Exec]
GO

BEGIN
	GRANT UPDATE ON [dbo].[tb_Teilnehmer] TO [20200819_Exec]
	GRANT ALTER ON [dbo].[tb_Teilnehmer] TO [20200819_Exec]
	GRANT VIEW CHANGE TRACKING ON [dbo].[tb_Teilnehmer] TO [20200819_Exec]
	GRANT SELECT ON [dbo].[tb_Teilnehmer] TO [20200819_Exec]
	GRANT VIEW DEFINITION ON [dbo].[tb_Teilnehmer] TO [20200819_Exec]
	GRANT INSERT ON [dbo].[tb_Teilnehmer] TO [20200819_Exec]
	GRANT DELETE ON [dbo].[tb_Teilnehmer] TO [20200819_Exec]
	GRANT UPDATE ON [dbo].[tb_Person] TO [20200819_Exec]
	GRANT ALTER ON [dbo].[tb_Person] TO [20200819_Exec]
	GRANT VIEW CHANGE TRACKING ON [dbo].[tb_Person] TO [20200819_Exec]
	GRANT SELECT ON [dbo].[tb_Person] TO [20200819_Exec]
	GRANT VIEW DEFINITION ON [dbo].[tb_Person] TO [20200819_Exec]
	GRANT INSERT ON [dbo].[tb_Person] TO [20200819_Exec]
	GRANT DELETE ON [dbo].[tb_Person] TO [20200819_Exec]
	GRANT UPDATE ON [dbo].[tb_Trainer] TO [20200819_Exec]
	GRANT ALTER ON [dbo].[tb_Trainer] TO [20200819_Exec]
	GRANT VIEW CHANGE TRACKING ON [dbo].[tb_Trainer] TO [20200819_Exec]
	GRANT SELECT ON [dbo].[tb_Trainer] TO [20200819_Exec]
	GRANT VIEW DEFINITION ON [dbo].[tb_Trainer] TO [20200819_Exec]
	GRANT INSERT ON [dbo].[tb_Trainer] TO [20200819_Exec]
	GRANT DELETE ON [dbo].[tb_Trainer] TO [20200819_Exec]
	GRANT ALTER ON [dbo].[sf_GetAge] TO [20200819_Exec]
	GRANT EXECUTE ON [dbo].[sf_GetAge] TO [20200819_Exec]
	GRANT VIEW DEFINITION ON [dbo].[sf_GetAge] TO [20200819_Exec]
END
GO
