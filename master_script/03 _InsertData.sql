USE [ZimmerSport]
GO


/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_PlzOrt
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_PlzOrt OFF
BEGIN
	BULK INSERT [dbo].[tb_PlzOrt] FROM 'D:\DB\PlzOrt_ANSI.csv'
	WITH (CODEPAGE = '1252', FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n', TABLOCK) 
END
SET IDENTITY_INSERT [dbo].[tb_PlzOrt] ON
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Person
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
BEGIN --tb_Person

	-- Hilftabelle bereits löschen
	IF EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Person_Hilfstabelle]') AND type in ('U'))
		DROP TABLE dbo.tb_Person_Hilfstabelle

	--Hilfstabelle wieder erstellen
	CREATE TABLE [dbo].[tb_Person_Hilfstabelle](
		[PersonID] int NOT NULL,
		[Vorname] nvarchar(50) NOT NULL,
		[Nachname] nvarchar(50) NOT NULL,
		[Strasse] nvarchar(50) NOT NULL,
		[Hausnummer] nvarchar(10) NOT NULL,
		[PLZ] nvarchar(5) NOT NULL,
		[Ort] nvarchar(50) NOT NULL,
		[Geburtsdatum] date NOT NULL,
		[Geschlecht] nvarchar(1) NOT NULL,--
		[EMail] nvarchar(50) NOT NULL
	) ON [PRIMARY]

	--BULK INSERT 
	SET IDENTITY_INSERT tb_PlzOrt OFF
	BEGIN
		BULK INSERT tb_Person_Hilfstabelle FROM 'D:\DB\Personendaten_ANSI.csv'  -- eigenen Pfad angeben
		WITH (CODEPAGE = '1252', FIRSTROW = 2, FIELDTERMINATOR = ';', ROWTERMINATOR = '\n', TABLOCK) 
	END
	--SET IDENTITY_INSERT dbo.tb_Person OFF

	/* 
		Übertragung der Personendaten aus tb_Person_Hilfstabelle nach tb_Person, wobei in tb_Person die PlzOrtID für die 
		entsprechende PLZ MIT Ort aus der tb_Person_Hilfstabelle hinterlegt werden muss --> über INNER JOIN ----------
	*/
	INSERT INTO tb_Person (Vorname, Nachname, Strasse, Hausnummer, PlzOrtID, Geburtsdatum, Geschlecht, Email)
		(SELECT Vorname, Nachname, Strasse, Hausnummer, tb_PlzOrt.PlzOrtID, Geburtsdatum, Geschlecht, Email
		 FROM tb_Person_Hilfstabelle LEFT JOIN tb_PlzOrt ON tb_PlzOrt.PLZ = tb_Person_Hilfstabelle.PLZ AND tb_PlzOrt.Ort = tb_Person_Hilfstabelle.Ort)

	-- Hilftabelle wieder löschen
	DROP TABLE dbo.tb_Person_Hilfstabelle

	--SET IDENTITY_INSERT dbo.tb_Person OFF
END
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Rolle
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Rolle ON
BEGIN
	INSERT INTO dbo.tb_Rolle (RolleID, Bezeichnung) VALUES 
		(1, 'Mitarbeiter'),
		(2, 'Freelancer'),
		(3, 'Zulieferer')	
END
SET IDENTITY_INSERT tb_Rolle OFF
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_PersonRolle
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_PersonRolle ON
BEGIN
	INSERT INTO  tb_PersonRolle(PersonRolleID,PersonID,RolleID, Beitrittsdatum)
	VALUES
	   (1,1,1,'2019-09-20'),
       (2,2,1,'2019-09-22'),
	   (3,3,2,'2019-10-01'),
	   (4,4,3,'2019-11-02'),
	   (5,5,3,'2019-11-22'),
	   (6,41,1,'2020-07-20'),
       (7,42,1,'2020-07-22'),
	   (8,43,2,'2020-08-01')
END
SET IDENTITY_INSERT tb_PersonRolle OFF
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Trainer
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Trainer ON
BEGIN
	INSERT INTO tb_Trainer 
		(TrainerID, PersonID, HonorarVereinbarung, SportBackground,  LeistungssportErfahrung, TrainerErfahrung, FunctionalTrainingErfahrung, Beitrittsdatum)
	VALUES 
		(1, 79, 20, 'Ju-Jutsu', 0, 4, 0, '2020-08-11'),
		(2, 94, 20, 'Eishockey, Inlinehockey, Ice Cross Downhill, Rugby', 14, 1, 1, '2020-03-15'),
		(3, 74, 20, 'Standard-Tanz', 0, 0, 0, '2020-07-27'),
		(4, 39, 20, 'Kung Fu Wushu', 9, 3, 7, '2020-06-30')
END
SET IDENTITY_INSERT tb_Trainer OFF
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Kurstyp
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Kurstyp ON
BEGIN
	INSERT INTO dbo.tb_Kurstyp (KurstypID, Bezeichnung, Beschreibung, Besonderheiten, Hilfsmittel) VALUES 
	   (1
		,'Wohn-ZimmerSport'
		,'Sie treiben gerne Sport, aber der Weg ins Sportstudio ist Ihnen zu weit? Dann trainieren Sie ganz einfach zuhause in Ihrem Wohnzimmer oder von jedem anderen Ort auf der Welt mit Ihrer persönlichen Sportgruppe unter live Anleitung Ihres Kurstrainers'	 
		,'Ein Training, das mit Hilfsmittel auskommt, die in jedem Haushalt zu finden sind.'
		,'Sportbekleidung, Trinkflasche, Unterlage (z.B. Isomatte, Handtuch oder Teppich), Handtuch, Malertape oder Klebezettel (z.B. Post-It''s)'
	   ),
	   (2
		,'Hotel-ZimmerSport'
		,'Sie sind beruflich viel unterwegs, eine Fitness-Studiommitgliedschaft oder Vereinsmitgliedschaft lohnt sich kaum, weil Sie nicht regelmäßig zuhause sind. Und selbst wenn Sie bei einer Fitness-Studio-Kette sind, die in mehreren Großstädten vertreten ist, müssen Sie sich jedes Mal erneut auf die Suche nach der nächstgelegenen Filiale machen. Das Resultat: Sie trainieren doch nicht regelmäßig und Ihre Fitness lässt zu wünschen übrig. Hotelzimmersport ist ein Trainingsprogramm, mit dem Sie immer und von jedem Ort aus an Ihrem vertrauten Sportkurs teilnehmen können - immer mit demselben Trainer und derselben Gruppe. Hotelzimmersport speziell auf die Durchführung in Hotelzimmern und Fremdenzimmern abgestimmt.'	 
		,'Hotelzimmersport ist ein spezielles Kurskonzept, das ohne Hilfsmittel und mit wenig Platz auskommt und so ruhig ist, dass die Zimmernachbarn nicht gestört werden.'
		,'Sportbekleidung, Trinken, ggf. ein Handtuch aus Ihrem Hotelzimmer'
	   ),
	   (3
		,'Büro-ZimmerSport'
		,'Corona hat uns gezeigt, dass remote arbeiten und verteilte Teams funktionieren. Immer mehr Teams sind über ganz Deutschland oder mehrere Länder verteilt. Im Team gemeinsam Sport treiben hält nicht nur fit, sondern stärkt auch den Teamgeist - zwei Fliegen mit einer Klappe! Doch wie kann das funktionieren, wenn Herbert im Home-Office sitzt, Juliane in Lissabon, Shane in England und Anna, Martin und Anton im Headquarter in München sind? Büro-ZimmerSport ist ein speziell auf Arbeitsteams abgestimmtes Kurskonzept, das über die Welt verstreute Team-Kollegen zusmamen bringt, um gemeinsam Sport zu treiben und als Team zusammen zu wachsen.'	 
		,'Arbeits-ZimmerSport ist speziell auf heterogene Teams im Arbeitsalltag abgestimmt: Es können alle mittrainieren, egal welches Fitness-Level; für jede Übung gibt es verschiedene Schwierigkeitsstufen, sodass niemand über- oder unterfordert ist - schließlich soll das gesamte Team mitmachen können und jeder Spaß und Erfolgserlebnisse haben. Die Kurseinheiten sind eher kurz, aber effektiv gehalten, um die Sporteinheiten gut in den Arbeitsalltag einbauen zu können.' 
		,'Trinken, ggf. Sportbekleidung - das hängt vom Wunsch des Teams ab, wie anstrengend das Training sein soll'
	   ),
	   (4
		,'Kinder-ZimmerSport'
		,'Kinder bewegen sich gerne, allerdings auch immer weniger. Gleichzeitig wachsen sie mit Digitalität auf, lernen diese aber selten für sinnvolle Zwecke zu nutzen (zum Beispiel Teamkollaboration und Sport). Häufig wird auf digitalen Medien nur gespielt, ein lebens- und gesundheitsförderlicher Umgang mit diesen Medien bleibt häufig aus. Kinder-ZimmerSport vereint vermehrte Bewegung für Kinder mit dem Lernen, wie digitalen Medien auch für Teams und Kommunikation sinnvoll genutzt werden können - eine Fähigkeit, die im zukünftigen Arbeitsleben immer wichtiger sein wird! Hier werden Kinder nicht nur körplich fit, sondern auch fit für die  digitale Zukunft der Arbeitswelt!' 
		,'Kinder-ZimmerSport ist ein speziell auf Kinder abgestimmtes Kurskonzept. Es vereint Bewegungsschule mit spielerischem Kommuniationstraining und kindergerechten Teamfähigkeits-Übungen. Die Trainer sind pädagogisch geschult und gehen auf die speziellen Bedürfnisse von Kindern ein."'
		,'Trinken, Sportbekleidung'
	   ) 
END
SET IDENTITY_INSERT tb_Kurstyp OFF
GO	

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Teilnehmer
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
 SET IDENTITY_INSERT tb_Teilnehmer ON
 BEGIN
	INSERT INTO  tb_Teilnehmer (TeilnehmerID, PersonID, Beitrittsdatum) VALUES 
	   (1,1,'2019-09-20'),
       (2,2,'2019-09-22'),
	   (3,3,'2019-10-01'),
	   (4,4,'2019-11-02'),
	   (5,5,'2019-11-22'),
	   (6,6,'2019-11-23'),
	   (7,7,'2019-11-23'),
	   (8,8,'2019-12-05'),
	   (9,9,'2019-12-05'),
	   (10,10,'2019-12-30'),
	   (11,11,'2020-01-02'),
	   (12,12,'2020-01-02'),
	   (13,13,'2020-01-08'),
	   (14,14,'2020-01-12'),
	   (15,15,'2020-02-01'),
	   (16,16,'2020-02-01'),
	   (17,17,'2020-06-22'),
	   (18,18,'2020-06-23'),
	   (19,19,'2020-08-01'),
	   (20,20,'2020-08-01'),
	   (21,21,'2020-08-03'),
	   (22,22,'2020-08-03'),
	   (23,23,'2020-08-04'),
	   (24,24,'2020-08-04'),
	   (25,25,'2020-08-05'),
	   (26,26,'2020-08-06'),
	   (27,27,'2020-08-07'),
	   (28,28,'2020-08-08'),
	   (29,29,'2020-08-08'),
	   (30,30,'2020-08-10'),
	   (31,31,'2020-08-11'),
	   (32,32,'2020-08-12'),
	   (33,33,'2020-08-13'),
	   (34,34,'2020-08-14'),
	   (35,35,'2020-08-15'),
	   (36,79,'2020-08-15'),
	   (37,74,'2020-08-15')
 END
 SET IDENTITY_INSERT tb_Teilnehmer OFF
 GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Sportlichkeit
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Sportlichkeit ON
BEGIN
	INSERT INTO dbo.tb_Sportlichkeit (SportlichkeitID, Bezeichnung) VALUES 
		(1, 'Bisher nie Sport'),
		(2, 'Weniger als 1x im Monat'),
		(3, '1 bis 3x im Monat'),
		(4, '1 bis 2x pro Woche'),
		(5, '3 bis 4x pro Woche'),
		(6, 'Mehr als 4x pro Woche')
END
SET IDENTITY_INSERT tb_Sportlichkeit OFF
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Erfahrung
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Erfahrung ON
BEGIN
	INSERT INTO dbo.tb_Erfahrung (ErfahrungID, Bezeichnung) VALUES 
		(1, 'Ja'),
		(2, 'Nein'),
		(3, 'Etwas')	
END
SET IDENTITY_INSERT tb_Erfahrung OFF
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Kontraindikation
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Kontraindikation ON
BEGIN
	INSERT INTO dbo.tb_Kontraindikation (KontraindikationID, Bezeichnung) VALUES 
		(1, 'Keine'),
		(2, 'Kniebeschwerden (z.B. Meniskus)'),
		(3, 'Oberschenkelbeschwerden (z.B. Zerrung)'),
		(4, 'Ischias-Beschwerden'),
		(5, 'Rückenbeschwerden'),
		(6, 'Bandscheibenvorfall'),
		(7, 'Genick-Beschwerden'),
		(8, 'Handbeschwerden'),
		(9, 'Schulterschmerzen'),
		(10, 'Schwangerschaft')
END
SET IDENTITY_INSERT tb_Kontraindikation OFF
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Kurs
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Kurs ON
BEGIN
	INSERT INTO tb_Kurs (KursID, KursTypID, TrainerID, Startdatum, Enddatum, MinTeilnehmerzahl, MaxTeilnehmerzahl, Preis) VALUES
		(1, 1, 1, '2020-09-01', '2020-10-31', 8, 30, 150),
		(2, 2, 2, '2020-10-01', '2020-10-31', 7, 16, 75),
		(3, 3, 3, '2020-08-15', '2020-10-15', 5, 8, 200),
		(4, 4, 4, '2020-08-15', '2020-10-15', 1, 1, 200),
		(5, 1, 1, '2020-10-01', '2020-11-30', 8, 12, 150),
		(6, 3, 2, '2020-11-01', '2020-12-31', 9, 11, 150)
END
SET IDENTITY_INSERT tb_Kurs OFF
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Kurseinheit
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Kurseinheit ON
INSERT INTO [dbo].[tb_Kurseinheit] (KurseinheitID, KursID, Datum, TrainerID, Stattgefunden)	VALUES 
	(1, 1, '2020-09-01', 1, 0),
	(2, 1, '2020-09-02', 1, 0),
	(3, 1, '2020-09-03', 1, 0),
	(4, 1, '2020-09-04', 1, 0),
	(5, 1, '2020-09-05', 1, 0),
	(6, 1, '2020-09-06', 1, 0),
	(7, 1, '2020-09-07', 1, 0),
	(8, 1, '2020-09-08', 1, 0),
	(9, 1, '2020-09-09', 1, 0),
	(10, 1, '2020-09-11', 1, 0),
	(11, 2, '2020-10-01', 2, 0),
	(12, 2, '2020-10-02', 2, 0),
	(13, 2, '2020-10-03', 2, 0),
	(14, 2, '2020-10-04', 2, 0),
	(15, 2, '2020-10-05', 2, 0),
	(16, 2, '2020-10-06', 2, 0),
	(17, 2, '2020-10-07', 2, 0),
	(18, 2, '2020-10-08', 2, 0),
	(19, 2, '2020-10-09', 2, 0),
	(20, 2, '2020-10-10', 2, 0),
	(21, 3, '2020-08-15', 3, 1),
	(22, 3, '2020-08-16', 3, 1),
	(23, 3, '2020-08-17', 3, 1),
	(24, 3, '2020-08-18', 3, 1),
	(25, 3, '2020-08-19', 3, 1),
	(26, 3, '2020-08-20', 3, 1),
	(27, 3, '2020-08-21', 3, 1),
	(28, 3, '2020-08-22', 3, 1),
	(29, 3, '2020-08-23', 3, 1),
	(30, 3, '2020-08-24', 3, 1),
	(31, 4, '2020-08-15', 4, 1),
	(32, 4, '2020-08-16', 4, 1),
	(33, 4, '2020-08-17', 4, 1),
	(34, 4, '2020-08-18', 4, 1),
	(35, 4, '2020-08-19', 4, 1),
	(36, 4, '2020-08-20', 4, 1),
	(37, 4, '2020-08-21', 4, 1),
	(38, 4, '2020-08-22', 4, 1),
	(39, 4, '2020-08-23', 4, 1),
	(40, 4, '2020-08-24', 4, 1),
	(41, 5, '2020-10-01', 1, 0),
	(42, 5, '2020-10-02', 1, 0),
	(43, 5, '2020-10-03', 1, 0),
	(44, 5, '2020-10-04', 1, 0),
	(45, 5, '2020-10-05', 1, 0),
	(46, 5, '2020-10-06', 1, 0),
	(47, 5, '2020-10-07', 1, 0),
	(48, 5, '2020-10-08', 1, 0),
	(49, 5, '2020-10-09', 1, 0),
	(50, 5, '2020-10-10', 1, 0),
	(51, 6, '2020-11-01', 2, 0),
	(52, 6, '2020-11-02', 2, 0),
	(53, 6, '2020-11-03', 2, 0),
	(54, 6, '2020-11-04', 2, 0),
	(55, 6, '2020-11-05', 2, 0),
	(56, 6, '2020-11-06', 2, 0),
	(57, 6, '2020-11-07', 2, 0),
	(58, 6, '2020-11-08', 2, 0),
	(59, 6, '2020-11-09', 2, 0),
	(60, 6, '2020-11-10', 2, 0)
SET IDENTITY_INSERT tb_Kurseinheit OFF
GO

/* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_TeilnehmerKurs
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_TeilnehmerKurs ON
INSERT INTO  tb_TeilnehmerKurs(TeilnehmerKursID,TeilnehmerID,KursID, Anmeldedatum,SportlichkeitID,ErfahrungID,KontraindikationID,Kursziel,KurszielErreicht)
VALUES
	(1,1,1,'2020-07-20',1,1,1,'',NULL),
	(2,2,1,'2020-08-10',2,2,1,'',NULL),
	(3,3,1,'2020-08-12',3,3,1,'',NULL),
	(4,4,1,'2020-08-12',4,1,1,'',NULL),
	(5,5,1,'2020-08-12',5,2,1,'',NULL),
	(6,6,1,'2020-08-12',5,2,1,'',NULL),
	(7,7,1,'2020-08-12',6,2,1,'',NULL),
	(8,8,1,'2020-08-12',6,2,1,'',NULL),
	(9,9,1,'2020-08-12',6,2,3,'',NULL),
	(10,10,1,'2020-08-12',6,2,2,'',NULL),
	(11,11,1,'2020-08-12',6,2,5,'',NULL),
	(12,12,1,'2020-08-12',6,2,7,'',NULL),
	(13,13,3,'2020-05-30',3,1,1,'Fitness aufbauen',NULL), 
	(14,14,3,'2020-06-30',1,2,2,'mehr Luft haben',NULL), 
	(15,15,3,'2020-02-01',4,3,1,'Kraftaufbau und Ausdauer',NULL), 
	(16,16,3,'2020-07-02',5,1,1,'Koordination und Balance verbessern',NULL), 
	(17,17,3,'2020-06-22',1,2,1,'Fitness aufbauen',NULL), 
	(18,18,3,'2020-06-23',3,3,4,'Armkraft verbessern',NULL), 
	(19,19,3,'2020-08-01',6,1,1,'noch fitter werden',NULL), 
	(20,20,3,'2020-08-02',1,2,5,'mich mehr bewegen',NULL), 
		   
	(21,21,4,'2020-08-18',3,3,1,'Mein Kind muss dringend abnehmen, um Gesundheitsprobleme zu vermeiden, aber ich kann es nicht motivieren. Ich hoffe, er macht bei Ihnen mit!',NULL)
SET IDENTITY_INSERT tb_TeilnehmerKurs OFF
GO

 /* ====================================================================================================
 Author:		Gruppe D
 CreateDate:	2020-08-17
 Tablename:		tb_Trainingsplan
 Description:	Um sicherzustellen, dass jeder dieselben Daten besitzt, wird beim INSERT der Autowert
				vorübergehend gestoppt 
 History
 2020-08-17 	Füllen der Tabelle mit Demodaten
 ====================================================================================================*/
SET IDENTITY_INSERT tb_Trainingsplan ON
BEGIN
	INSERT INTO tb_Trainingsplan(TrainingsplanID,Wochentag,Uhrzeit,Dauermin,kursid) VALUES
		(1,1,'14:00:00',10,1),
		(2,5,'14:00:00',10,1),
		(3,1,'14:00:00',10,2),
		(4,4,'14:00:00',10,2),
		(5,1,'14:00:00',10,3),
		(6,2,'14:00:00',10,3),
		(7,1,'14:00:00',10,4),
		(8,4,'14:00:00',10,4),
		(9,4,'14:00:00',10,5),
		(10,5,'14:00:00',10,5),
		(11,2,'14:00:00',10,6),
		(12,5,'14:00:00',10,6)
END
SET IDENTITY_INSERT tb_Trainingsplan OFF
GO
