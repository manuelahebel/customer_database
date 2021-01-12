USE [ZimmerSport]
GO


/* ====================================================================================================
 Author:		Olga Kornienko
 CreateDate:	2020-08-19
 Funktion:		tf_Uebersicht_TeilnehmerGeburtstag
 Description:	Gibt eine Liste aller Teilnehmer und Personendaten zurück, welche in einem bestimmten 
				Monat Geburtstag haben
 Parameter:		@monat = Monat
 History
 2020-08-19 ok	Funktion erstellt
 ====================================================================================================*/
DROP FUNCTION IF EXISTS tf_Uebersicht_TeilnehmerGeburtstag
GO
CREATE FUNCTION tf_Uebersicht_TeilnehmerGeburtstag (
	@Monat int
)
RETURNS TABLE 
AS
	RETURN 
	(
		-- Add the SELECT statement with parameter references here
		SELECT 
			tb_Teilnehmer.TeilnehmerID, 
			Vorname, 
			Nachname, 
			Strasse, 
			tb_PlzOrt.PLZ, 
			tb_PlzOrt.Ort, 
			Geburtsdatum, 
			Geschlecht, 
			EMail, 
			Beitrittsdatum
		FROM 
			tb_Person
			INNER JOIN tb_Teilnehmer 
				ON tb_Person.PersonID = tb_Teilnehmer.PersonID
			LEFT JOIN tb_PlzOrt 
				ON tb_Person.PlzOrtID = tb_PlzOrt.PlzOrtID
		WHERE        
			(Month(dbo.tb_Person.Geburtsdatum) = @Monat)
)
GO

/* ====================================================================================================
 Author:		Martin Poledniok
 CreateDate:	2020-08-19
 Funktion:		tf_KurseEinesTrainersUsersicht
 Description:	Gibt eine Liste aller Kurse eines Trainers wieder inkl. Beschreibung und Trainerdaten
 Parameter:		@nachname = Nachname des Trainers
 History
 2020-08-19 ok	Funktion erstellt
 ====================================================================================================*/
IF EXISTS(SELECT * FROM sys.objects WHERE NAME = 'tf_KurseEinesTrainersUsersicht' AND TYPE = 'IF')
	DROP FUNCTION [dbo].[tf_KurseEinesTrainersUsersicht] 
GO
CREATE FUNCTION tf_KurseEinesTrainersUsersicht(	
	@Nachname nvarchar(50) 
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT 
	     dbo.tb_Trainer.TrainerID
		,dbo.tb_Person.Vorname
		,dbo.tb_Person.Nachname
		,dbo.tb_Kurs.KursID
		,dbo.tb_Kurstyp.Beschreibung
	FROM   
		dbo.tb_Trainer
		INNER JOIN dbo.tb_Person 
			ON dbo.tb_Trainer.PersonID = dbo.tb_Person.PersonID
		INNER JOIN dbo.tb_Kurs 
			ON dbo.tb_Kurs.TrainerID = dbo.tb_Trainer.TrainerID
		INNER JOIN dbo.tb_Kurstyp 
			ON dbo.tb_Kurstyp.KursTypID = dbo.tb_Kurs.KursTypID
	WHERE 
		dbo.tb_Trainer.PersonID = dbo.tb_Person.PersonID AND dbo.tb_Person.Nachname = @Nachname
)
GO

/* ====================================================================================================
 Author:		Kornienko, Olga
 CreateDate:	2020-08-19
 Funktion:		sf_GetAge
 Description:	Ermittelt das Alter anhand eines Geburtsdatum und liefert diesen zurück
 Parameter:		@Geburtsdatum date
 History
 2020-08-19 ok	Funktion erstellt
 ====================================================================================================*/
IF EXISTS(SELECT * FROM sys.objects WHERE NAME = 'sf_GetAge' AND TYPE = 'FN')
	DROP FUNCTION [dbo].[sf_GetAge] 
GO
CREATE FUNCTION sf_GetAge (
	@Geburtsdatum date
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Age int;

	SET @Age=floor(DATEDIFF(day,@Geburtsdatum,CURRENT_TIMESTAMP)/365.25); --@Age=10; ---

	-- Return the result of the function
	IF (@Age IS NULL) SET @Age=-1
	RETURN @Age
END
GO

/* ====================================================================================================
 Author:		Manuela Hebel
 CreateDate:	2020-08-19
 Funktion:		tf_KurseEinesTrainersManagementsichtInputVornameNachname
 Description:	Übersicht aller Kurse mit zugehörigen Daten, die das Management interessieren.
 Parameter:		@Vorname 
				@Nachname 
 History
 2020-08-19 mh	Funktion erstellt
====================================================================================================*/
DROP FUNCTION IF EXISTS tf_KurseEinesTrainersManagementsichtInputVornameNachname
GO
CREATE FUNCTION tf_KurseEinesTrainersManagementsichtInputVornameNachname(
	@VornameTrainer nvarchar(50), 
	@NachnameTrainer nvarchar(50)
)
RETURNS TABLE
AS
RETURN (
	SELECT 
		Vorname, 
		Nachname, 
		tb_Kurs.TrainerID, 
		KursID, 
		Startdatum, 
		Enddatum, 
		MinTeilnehmerzahl, 
		MaxTeilnehmerzahl, 
		Preis, 
		tb_KursTyp.KursTypID, 
		Bezeichnung, 
		Hilfsmittel
	FROM 
		tb_Kurs
		LEFT JOIN tb_Kurstyp
			ON tb_Kurstyp.KursTypID = tb_Kurs.KursTypID
		LEFT JOIN tb_Trainer
			ON tb_Trainer.TrainerID = tb_Kurs.TrainerID
		INNER JOIN tb_Person
			ON tb_Person.PersonID = tb_Trainer.PersonID
	WHERE 
		Vorname = @VornameTrainer AND Nachname = @NachnameTrainer
)
GO

/* ====================================================================================================
 Author:		Manuela Hebel
 CreateDate:	2020-08-19
 Funktion:		tf_KurseEinesTrainersManagementsichtInputTrainerID
 Description:	Übersicht aller Kurse mit zugehörigen Daten, die das Management interessieren.
 Parameter:		@TrainerID
 History
 2020-08-19 mh	Funktion erstellt
 2020-08-19 dj	Funktion geändert, Vorname+Nachname ermitteln und danach wird die andere Funktion 
				tf_KurseEinesTrainersManagementsichtInputVornameNachname aufgerufen, so dass die 
				Logik nur in einer der beiden Funktionen hinterlegt wird
====================================================================================================*/
DROP FUNCTION IF EXISTS tf_KurseEinesTrainersManagementsichtInputTrainerID
GO
CREATE FUNCTION tf_KurseEinesTrainersManagementsichtInputTrainerID(
	@TrainerID int
)
RETURNS TABLE
AS
RETURN (

	SELECT
		TrainerID, 
		KursID, 
		Startdatum, 
		Enddatum, 
		MinTeilnehmerzahl, 
		MaxTeilnehmerzahl, 
		Preis, 
		KursTypID, 
		Bezeichnung, 
		Hilfsmittel
	FROM
		tf_KurseEinesTrainersManagementsichtInputVornameNachname(
			(select vorname  from tb_Trainer a inner join tb_Person b on a.personid=b.PersonID where TrainerID=@TrainerID),
			(select nachname from tb_Trainer a inner join tb_Person b on a.personid=b.PersonID where TrainerID=@TrainerID)
	)
)
GO
