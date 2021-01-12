USE ZimmerSport
GO

/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-20
 Tablename:		-
 Description:	Löscht den komplettem Inhlt der Datenbank OHNE Benutzer und Berechtigungen
 
 Hinweise:		Sobald ForeignKeys erstellt wurden, ist die Reihenfolge des Löschens wichtig. Die 
				Tabellen müssen in der Reihenfolge der ForeignKeys, die auf sie verweisen gelöscht 
				werden. Um dies zu umgehen, werden vorher alle ForeignKeys gelöscht!

				IF EXISTS funktioniert erst ab SQL-Server-Version 2016!
				Bitte nur verwenden, wenn man sicher ausschliessen kann, dass dieses Script nicht 
				auf älteren Versionen verwendet werden muss.
 History
 2020-08-20 dj	Löschscript erstellt und getestet
 ====================================================================================================*/


 --ForeignKeys
BEGIN
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_PersonRolle_tb_Person' AND parent_object_id = OBJECT_ID(N'dbo.tb_PersonRolle'))
		ALTER TABLE dbo.tb_PersonRolle DROP CONSTRAINT FK_tb_PersonRolle_tb_Person
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_PersonRolle_tb_Rolle' AND parent_object_id = OBJECT_ID(N'dbo.tb_PersonRolle'))
		ALTER TABLE dbo.tb_PersonRolle DROP CONSTRAINT FK_tb_PersonRolle_tb_Rolle
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Person_tb_PlzOrt' AND parent_object_id = OBJECT_ID(N'dbo.tb_Person'))
		ALTER TABLE dbo.tb_Person DROP CONSTRAINT FK_tb_Person_tb_PlzOrt
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Kontraindikation' AND parent_object_id = OBJECT_ID(N'dbo.tb_TeilnehmerKurs'))
		ALTER TABLE dbo.tb_TeilnehmerKurs DROP CONSTRAINT FK_tb_TeilnehmerKurs_tb_Kontraindikation
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Sportlichkeit' AND parent_object_id = OBJECT_ID(N'dbo.tb_TeilnehmerKurs'))
		ALTER TABLE dbo.tb_TeilnehmerKurs DROP CONSTRAINT FK_tb_TeilnehmerKurs_tb_Sportlichkeit
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Kurs' AND parent_object_id = OBJECT_ID(N'dbo.tb_TeilnehmerKurs'))
		ALTER TABLE dbo.tb_TeilnehmerKurs DROP CONSTRAINT FK_tb_TeilnehmerKurs_tb_Kurs
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Teilnehmer' AND parent_object_id = OBJECT_ID(N'dbo.tb_TeilnehmerKurs'))
		ALTER TABLE dbo.tb_TeilnehmerKurs DROP CONSTRAINT FK_tb_TeilnehmerKurs_tb_Teilnehmer
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Erfahrung' AND parent_object_id = OBJECT_ID(N'dbo.tb_TeilnehmerKurs'))
		ALTER TABLE dbo.tb_TeilnehmerKurs DROP CONSTRAINT FK_tb_TeilnehmerKurs_tb_Erfahrung
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Kurs_tb_Trainer' AND parent_object_id = OBJECT_ID(N'dbo.tb_Kurs'))
		ALTER TABLE dbo.tb_Kurs DROP CONSTRAINT FK_tb_Kurs_tb_Trainer
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Kurs_tb_KursTyp' AND parent_object_id = OBJECT_ID(N'dbo.tb_Kurs'))
		ALTER TABLE dbo.tb_Kurs DROP CONSTRAINT FK_tb_Kurs_tb_KursTyp
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Kurseinheit_tb_Kurs' AND parent_object_id = OBJECT_ID(N'dbo.tb_Kurseinheit'))
		ALTER TABLE dbo.tb_Kurseinheit DROP CONSTRAINT FK_tb_Kurseinheit_tb_Kurs
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Kurseinheit_tb_Trainer' AND parent_object_id = OBJECT_ID(N'dbo.tb_Kurseinheit'))
		ALTER TABLE dbo.tb_Kurseinheit DROP CONSTRAINT FK_tb_Kurseinheit_tb_Trainer
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Teilnehmer_tb_Person' AND parent_object_id = OBJECT_ID(N'dbo.tb_Teilnehmer'))
		ALTER TABLE dbo.tb_Teilnehmer DROP CONSTRAINT FK_tb_Teilnehmer_tb_Person
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Person_tb_Trainer' AND parent_object_id = OBJECT_ID(N'dbo.tb_Person'))
		ALTER TABLE dbo.tb_Person DROP CONSTRAINT FK_tb_Person_tb_Trainer
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Traingsplan_tb_Kurs' AND parent_object_id = OBJECT_ID(N'dbo.tb_Traingsplan'))
		ALTER TABLE dbo.tb_Traingsplan DROP CONSTRAINT FK_tb_Traingsplan_tb_Kurs
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Trainingsplan_tb_Kurs' AND parent_object_id = OBJECT_ID(N'dbo.tb_Trainingsplan'))
		ALTER TABLE dbo.tb_Trainingsplan DROP CONSTRAINT FK_tb_Trainingsplan_tb_Kurs
	IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Person_tb_Trainer' AND parent_object_id = OBJECT_ID(N'dbo.tb_Trainer'))
		ALTER TABLE dbo.tb_Trainer DROP CONSTRAINT FK_tb_Person_tb_Trainer
END
GO

--Proeduren
DROP PROCEDURE IF EXISTS sp_AddTeilnehmerKursIFSportlich

--Trigger
DROP TRIGGER IF EXISTS tr_KurseinheitTestDatum

--Funktionen
BEGIN
	DROP FUNCTION IF EXISTS  tf_KurseEinesTrainersManagementsichtInputTrainerID
	DROP FUNCTION IF EXISTS  tf_KurseEinesTrainersManagementsichtInputVornameNachname
	DROP FUNCTION IF EXISTS  tf_KurseEinesTrainersUsersicht
	DROP FUNCTION IF EXISTS  tf_Uebersicht_TeilnehmerGeburtstag
	DROP FUNCTION IF EXISTS  sf_GetAge
	DROP FUNCTION IF EXISTS  sf_AlterVonTeilnehmer
END
GO

--Views
BEGIN
	DROP VIEW IF EXISTS  vw_AllePersonen
	DROP VIEW IF EXISTS  vw_KurseMitPlatz
	DROP VIEW IF EXISTS  vw_Trainer
	DROP VIEW IF EXISTS  vw_TrainerTeilnehmer
	DROP VIEW IF EXISTS  vw_AlleTeilnehmer
END
GO


--Tabellen
BEGIN
	DROP TABLE IF EXISTS  tb_TeilnehmerKurs
	DROP TABLE IF EXISTS  tb_Teilnehmer
	DROP TABLE IF EXISTS  tb_Traingsplan
	DROP TABLE IF EXISTS  tb_Kurs
	DROP TABLE IF EXISTS  tb_Trainer
	DROP TABLE IF EXISTS  tb_Rolle
	DROP TABLE IF EXISTS  tb_PersonRolle
	DROP TABLE IF EXISTS  tb_PlzOrt
	DROP TABLE IF EXISTS  tb_Person
	DROP TABLE IF EXISTS  tb_Sportlichkeit
	DROP TABLE IF EXISTS  tb_Erfahrung
	DROP TABLE IF EXISTS  tb_Kontraindikation
	DROP TABLE IF EXISTS  tb_KursTyp
	DROP TABLE IF EXISTS  tb_Trainingsplan
	DROP TABLE IF EXISTS  tb_Person_Hilfstabelle
	DROP TABLE IF EXISTS  tb_Kurseinheit
END
GO
