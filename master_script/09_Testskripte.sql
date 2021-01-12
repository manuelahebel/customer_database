/* ====================================================================================================
Author:			Gruppe D
CreateDate:		2020-08-20
Description:	Testkripte für alle Views
====================================================================================================*/


-- vw_TrainerTeilnehmer
------------------------------------------------------------------------------
SELECT *
FROM vw_TrainerTeilnehmer
ORDER BY Geburtsdatum


-- vw_Trainer
------------------------------------------------------------------------------
SELECT *
FROM vw_Trainer
WHERE Geburtsdatum < '2000-01-01' --Zusätzliche Bedingung eingefügt, Trainer muss vor dem Jahr 2000 geboren sein
ORDER BY Geburtsdatum


-- vw_KurseMitPlatz
------------------------------------------------------------------------------
-- Sicht gibt eine Übersicht über alle Kurse und verfügbare Plätze aus
SELECT *
FROM vw_KurseMitPlatz

-- Sicht zeigt nach Auswahl eines bestimmten Kurses, dass kein Platz mehr verfügbar ist
SELECT *
FROM vw_KurseMitPlatz
WHERE KursID = 2


-- vw_AllePersonen
------------------------------------------------------------------------------
-- Anzeige aller Spalten aus Sicht
SELECT * FROM vw_AllePersonen

-- Anzeigen bestimmter Spalten, geordnet nach Nachname
SELECT PersonID, Nachname, Vorname, Geschlecht, [Alter], IstTrainer, IstTeilnehmer, IstWasAnderes
FROM vw_AllePersonen
ORDER BY Nachname

-- Anzeigen bestimmter Spalten, geordnet nach Nachname, nur für die Teilnehmer
SELECT PersonID, Nachname, Vorname, Geschlecht, [Alter], IstTrainer, IstWasAnderes
FROM vw_AllePersonen
WHERE IstTeilnehmer = 'Teilnehmer'
ORDER BY Nachname

-- Anzeigen bestimmter Spalten, geordnet nach Nachname, nur für die Personen sind, die Trainer UND Teilnehmer sind
SELECT PersonID, Nachname, Vorname, Geschlecht, [Alter], IstWasAnderes
FROM vw_AllePersonen
WHERE IstTeilnehmer = 'Teilnehmer' AND IstTrainer = 'Trainer'
ORDER BY Nachname


-- vw_AlleTeilnehmer
------------------------------------------------------------------------------
SELECT * FROM vw_AlleTeilnehmer


-- vw_Kurse
------------------------------------------------------------------------------
SELECT * FROM vw_Kurse


/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-20
 Description:	Testkripte für alle Skalarfunktionen
 ====================================================================================================*/

 -- sf_GetAge
 --------------------------------------------------------------------
 -- Alter einer Person mit bestimmten Geburtsdatum
 	DECLARE @Geburtsdatum date
	SET	@Geburtsdatum = '1946-07-04'
	
	SELECT dbo.sf_GetAge(@Geburtsdatum) 


/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-20
 Description:	Testkripte für alle Tabellenwertunktionen
 ====================================================================================================*/ 
-- tf_Uebersicht_TeilnehmerGeburtstag
---------------------------------------------------------------------
-- Daten von allen Teilnehmern, die im August Geburtstag haben
SELECT *
FROM tf_Uebersicht_TeilnehmerGeburtstag(08)

-- Daten von allen Teilnehmern, die im September Geburtstag haben
SELECT *
FROM tf_Uebersicht_TeilnehmerGeburtstag(09)


-- tf_KurseEinesTrainersUebersicht
---------------------------------------------------------------------
SELECT * FROM tf_KurseEinesTrainersUsersicht('Hebel') -- OK
GO


-- tf_KurseEinesTrainersManagementsichtInputVornameNachname
---------------------------------------------------------------------
-- Alle Kurse des Trainers mit Vorname und Nachname
SELECT * FROM tf_KurseEinesTrainersManagementsichtInputVornameNachname('Manuela','Hebel') -- OK
GO

SELECT * FROM tf_KurseEinesTrainersManagementsichtInputVornameNachname('Dieter','Jäger') -- OK
GO

SELECT * FROM tf_KurseEinesTrainersManagementsichtInputVornameNachname('Martin','Poledniok') -- OK
GO

SELECT * FROM tf_KurseEinesTrainersManagementsichtInputVornameNachname('Olga','Kornienko') -- OK
GO

 -- tf_KurseEinesTrainersManagementsichtInputTrainerID
 ---------------------------------------------------------------------
 -- Alle Kurse des Trainers mit einer bestimmten TrainerID
 SELECT * FROM tf_KurseEinesTrainersManagementsichtInputTrainerID(1)
GO

SELECT * FROM tf_KurseEinesTrainersManagementsichtInputTrainerID(2)
GO

SELECT * FROM tf_KurseEinesTrainersManagementsichtInputTrainerID(3)
GO

SELECT * FROM tf_KurseEinesTrainersManagementsichtInputTrainerID(4)
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-20
 Description:	Testkripte für alle Trigger
 ====================================================================================================*/

 -- tr_KurseinheitTestDatum
----------------------------------------------------------------------
--- Kurseinheit liegt in der Zukunft und hat stattgefunden, 
UPDATE tb_Kurseinheit
SET tb_Kurseinheit.Stattgefunden = 1
WHERE KurseinheitID =  11;

SELECT * FROM tb_Kurseinheit
WHERE KurseinheitID =  11;
-----------------------------------------------------------------
--- Kurseinheit liegt in der Vergangenheit und hat stattgefunden
UPDATE tb_Kurseinheit
SET tb_Kurseinheit.Stattgefunden = 1
WHERE KurseinheitID =  21;

SELECT * FROM tb_Kurseinheit
WHERE KurseinheitID =  21;

----------------------------------------------------------------------
--- Kurseinheit liegt in der Vergangenheit und hat NICHT stattgefunden
UPDATE tb_Kurseinheit
SET tb_Kurseinheit.Stattgefunden = 0
WHERE KurseinheitID =  21;

SELECT * FROM tb_Kurseinheit
WHERE KurseinheitID =  21;


/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-20
 Description:	Testkripte für alle Prozeduren
 ====================================================================================================*/
-- sp_AddTeilnehmerKursIFSportlich
------------------------------------------------------------
DECLARE @Erfolg AS bit;
DECLARE @Feedback AS VARCHAR(MAX);

-- Test 1 - Teilnehmer richtige Altersgruppe und Sportlichkeit
EXEC [dbo].[sp_AddTeilnehmerKursIFSportlich] 
	1,-- KurstID
	'1950-10-01', --Geburtsdatum
	6, --Sportlichkeit 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;
SELECT @Erfolg [Hat Anmeldung geklappt?], @Feedback [Meldung];


-- Test 2 - Teilnehmer zu Jung, aber richtige Sportlichkeit
EXEC [dbo].[sp_AddTeilnehmerKursIFSportlich] 
	1,-- KurstID
	'1990-10-01', --Geburtsdatum
	6, --Sportlichkeit 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;
SELECT @Erfolg [Hat Anmeldung geklappt?], @Feedback [Meldung];

-- Test 3 - Teilnehmer zu Alt, aber richtige Sportlichkeit
EXEC [dbo].[sp_AddTeilnehmerKursIFSportlich] 
	1,-- KurstID
	'1890-10-01', --Geburtsdatum
	6, --Sportlichkeit 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;
SELECT @Erfolg [Hat Anmeldung geklappt?], @Feedback [Meldung];


 --Test 4 -Teilnehmer ist in der richtigen Altersgruppe, aber hat zu geringe Sportlichkeit
EXEC [dbo].[sp_AddTeilnehmerKursIFSportlich] 
	1,-- KurstID
	'1950-10-01', --Geburtsdatum
	0, --Sportlichkeit 
	@Erfolg OUTPUT,
	@Feedback OUTPUT;
SELECT @Erfolg [Hat Anmeldung geklappt?], @Feedback [Meldung];

