/* ====================================================================================================
Author:			xxx
CreateDate:		2020-08-18
Tablename:		vw_AllePersonen
Description:	Liste über alle Personen inklusiver aller zugehöriger Attribute

ACHTUNG:		bei allen SQL-Server möglich
				IF EXISTS(SELECT * FROM sys.views WHERE name= 'vw_KurseMitPlatz' AND type = 'v')
					DROP...

				erst ab SQL-Version 2016 möglich
				DROP VIEW IF EXISTS  

History
2020-08-18 View erstellt
2020-08-18 View geprüft: OK
====================================================================================================*/
DROP VIEW IF EXISTS dbo.vw_AllePersonen	
GO
CREATE VIEW vw_AllePersonen 
AS
	SELECT 
		 tb_Person.PersonID
		,IIF(TrainerID IS NULL, '', 'Trainer') IstTrainer				--IIF(Bedingung erfüllt, dann wahr, dann falsch)
		,IIF(TeilnehmerID IS NULL, '', 'Teilnehmer') IstTeilnehmer
		,IIF(PersonRolleID IS NULL, '', tb_Rolle.Bezeichnung) IstWasAnderes
		,Vorname
		,Nachname
		,Strasse
		,Hausnummer
		,tb_Person.PlzOrtID	--da die Spalte PlzOrtID in mehreren Tabellen vorkommt, muss man diese voranstellen
		,PLZ
		,Ort
		,Bundesland
		,Geburtsdatum
		,dbo.sf_GetAge(tb_Person.Geburtsdatum) AS 'Alter'
		,Geschlecht
		,EMail
		,TrainerID
		,HonorarVereinbarung
		,SportBackground
		,LeistungssportErfahrung
		,TrainerErfahrung
		,FunctionalTrainingErfahrung
		,tb_Trainer.Beitrittsdatum		AS BeitrittsdatumAlsTrainer		--Alias für den Spaltennamen
		,TeilnehmerID
		,tb_Teilnehmer.Beitrittsdatum	AS BeitrittsdatumAlsTeilnehmer
		,tb_Rolle.RolleID 
		,tb_Rolle.Bezeichnung
		,tb_PersonRolle.Beitrittsdatum	AS BeitrittsdatumAlsAndereRolle
	FROM tb_Person
		LEFT JOIN tb_PlzOrt
			ON tb_PlzOrt.PlzOrtID = tb_Person.PlzOrtID
		LEFT JOIN tb_Trainer
			ON tb_Trainer.PersonID = tb_Person.PersonID
		LEFT JOIN tb_Teilnehmer
			ON tb_Teilnehmer.PersonID = tb_Person.PersonID
		LEFT JOIN tb_PersonRolle
			ON tb_PersonRolle.PersonID = tb_Person.PersonID
		LEFT JOIN tb_Rolle
			ON tb_Rolle.RolleID = tb_PersonRolle.RolleID
GO


/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-18
 Sicht:			vw_TrainerTeilnehmer
 Description:	Erstellung einer Sicht, die eine Übersicht aller Personen ausgibt, die sowohl Trainer
				als auch Teilnehmer sind

 ACHTUNG:		Create View muss die erste Anweisung in einem Batch sein (nach einem GO)

 History
 2020-08-18 mp	Sicht erstellen
 2020-08-19 dj	Abfrage über von vw_AllePersonen, da hier bereits alle Informationen enthalten sind
 ====================================================================================================*/
IF EXISTS(SELECT * FROM sys.views WHERE name= 'vw_TrainerTeilnehmer' AND type = 'v')
	DROP VIEW [dbo].[vw_TrainerTeilnehmer] 
GO
CREATE VIEW [dbo].[vw_TrainerTeilnehmer]
AS
	SELECT 
		 PersonID
		,Vorname
		,Nachname
		,Geburtsdatum
		,Geschlecht
	FROM 
		vw_AllePersonen 
	WHERE 
		IstTeilnehmer <> ''and IstTrainer <> ''
GO

/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-18
 Sicht:			vw_Trainer
 Description:	Erstellung einer Sicht, die eine Übersicht aller Trainer erstellt
 History
 2020-08-18mp	Sicht erstellen
 ====================================================================================================*/
IF EXISTS(SELECT * FROM sys.views WHERE name= 'vw_Trainer' AND type = 'v')
	DROP VIEW [dbo].[vw_Trainer] 
GO
CREATE VIEW [dbo].[vw_Trainer]
AS
	SELECT        
 		 dbo.tb_Trainer.PersonID
		,dbo.tb_Person.Vorname
		,dbo.tb_Person.Nachname
		,dbo.tb_Person.Strasse
		,dbo.tb_Person.Hausnummer
		,dbo.tb_Person.Geburtsdatum
		,dbo.sf_GetAge(dbo.tb_Person.Geburtsdatum)[Alter]
	FROM            
		dbo.tb_Person 
		INNER JOIN dbo.tb_Trainer ON dbo.tb_Person.PersonID = dbo.tb_Trainer.PersonID
GO

/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-18
 Sicht:			vw_KurseMitPlatz
 Description:	Erstellung einer Sicht die prüft, ob noch Plätze im den Kursen vorhanden sind
 History
 2020-08-18mp	Sicht erstellen
 ====================================================================================================*/
IF EXISTS(SELECT * FROM sys.views WHERE name= 'vw_KurseMitPlatz' AND type = 'v')
	DROP VIEW [dbo].[vw_KurseMitPlatz] 
GO
CREATE VIEW [dbo].[vw_KurseMitPlatz]
AS
	SELECT        
		 dbo.tb_Kurs.KursID
		,dbo.tb_Kurs.MaxTeilnehmerzahl
		,COUNT(dbo.tb_TeilnehmerKurs.TeilnehmerID) AS AktuelleTeilnehmerzahl
	FROM			
		dbo.tb_Kurs 
		INNER JOIN dbo.tb_TeilnehmerKurs ON dbo.tb_Kurs.KursID = dbo.tb_TeilnehmerKurs.KursID
	GROUP BY	  
			dbo.tb_Kurs.KursID
		,dbo.tb_Kurs.MaxTeilnehmerzahl 
	HAVING		  
		dbo.tb_Kurs.MaxTeilnehmerzahl > COUNT(dbo.tb_TeilnehmerKurs.TeilnehmerID)
GO

/* ====================================================================================================
Author:			Dieter Jäger
CreateDate:		2020-08-19
Tablename:		vw_AlleTeilnehmer
Description:	Auflistung belegter Kurse sowie ihrer Teilnehmer und ihrer Personendaten
History
2020-08-19 View erstellt
====================================================================================================*/
IF EXISTS(SELECT * FROM sys.views WHERE name= 'vw_AlleTeilnehmer' AND type = 'v')
	DROP VIEW [dbo].[vw_AlleTeilnehmer] 
GO
CREATE VIEW vw_AlleTeilnehmer 
AS
	SELECT 
		 b.KursID
		,d.Bezeichnung
		,a.Vorname
		,a.Nachname
		,a.Strasse
		,a.Plz
		,a.Ort
		,a.Geburtsdatum
		,a.[Alter]
		,a.Geschlecht
		,a.Email
		,a.BeitrittsdatumAlsTeilnehmer Beitrittsdatum
	FROM
		vw_AllePersonen a
		RIGHT JOIN tb_TeilnehmerKurs b on a.TeilnehmerID=b.TeilnehmerID
		INNER JOIN tb_Kurs c on b.KursID = c.KursID
		INNER JOIN tb_KursTyp d on c.KursTypID = d.KursTypID
GO



/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-20
 Tablename:		vw_Kurse
 Description:	Auflistung aller Kurse mit inkl. Information zum Trainer und der Belegung
 History
 2020-08-20 mh	View erstellt
====================================================================================================*/
IF EXISTS(SELECT * FROM sys.views WHERE name= 'vw_Kurse' AND type = 'v')
	DROP VIEW [dbo].vw_Kurse 
GO
CREATE VIEW [dbo].[vw_Kurse]
AS
	SELECT
		tb_Kurs.KursID
		, tb_Kurstyp.KursTypID
		, tb_Kurstyp.Bezeichnung
		, (SELECT COUNT(*) FROM tb_TeilnehmerKurs WHERE tb_TeilnehmerKurs.KursID = tb_Kurs.KursID) AS AnzahlAngemeldeteTN
		, tb_Kurs.MinTeilnehmerzahl
		, tb_Kurs.MaxTeilnehmerzahl
		, tb_Kurs.Startdatum
		, tb_Kurs.Enddatum
		, tb_Person.Vorname AS TrainerVorname
		, tb_Person.Nachname AS TrainerNachname
		, tb_Kurstyp.Beschreibung
		, tb_Kurstyp.Besonderheiten
		, tb_Kurstyp.Hilfsmittel
		, tb_Kurs.Preis
	FROM tb_Kurs
		INNER JOIN tb_Kurstyp
			ON tb_Kurstyp.KursTypID = tb_Kurs.KursTypID
		INNER JOIN tb_Trainer
			ON tb_Trainer.TrainerID = tb_Kurs.TrainerID
		INNER JOIN tb_Person
			ON tb_Person.PersonID = tb_Trainer.PersonID
GO



