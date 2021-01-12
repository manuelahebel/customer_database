USE [ZimmerSport]
GO

/* ====================================================================================================
 Author:		Dieter J. Jäger
 CreateDate:	2020-08-13
 Tablename:		tb_Kontraindikation
 Description:	Referenztabelle mit allen Kontraindikatoren
				  > Die Kontraindikation oder Gegenanzeige ist ein Umstand, der die Anwendung eines 
				  > diagnostischen oder therapeutischen Verfahrens bei an sich gegebener Indikation 
				  > in jedem Fall verbietet oder nur unter strenger Abwägung sich dadurch ergebender 
				  > Risiken zulässt.
 ForeignKeys:	-

 History
 2020-08-13 dj	Tabelle erstellt
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt
				werden, falls die Tabelle bereits existiert
				Hinzufügen der Einschränkungen
 ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_Kontraindikation
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Kontraindikation]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Kontraindikation](
				[KontraindikationID] [int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung] [nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_Kontraindikation] PRIMARY KEY CLUSTERED 
				(
					[KontraindikationID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Kontraindikation_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Kontraindikation_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Kontraindikation]'))
			DROP INDEX [IX_tb_Kontraindikation_Bezeichnung] ON [dbo].[tb_Kontraindikation]
		
		CREATE UNIQUE NONCLUSTERED INDEX IX_tb_Kontraindikation_Bezeichnung ON [dbo].[tb_Kontraindikation]
		(
			Bezeichnung ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO

/* ====================================================================================================
 Author:		Dieter J. Jäger
 CreateDate:	2020-08-13
 Tablename:		tb_Leistungslevel
 Description:	Referenztabelle mit allen Leistungslevel. Diese kennzeichnet, ob die Übeung für 
				Anfänger, Forgeschrittene oder Profis... bestimmt ist
 ForeignKeys:	-

 History
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt
				werden, falls die Tabelle bereits existiert
 ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_Traingsteil
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Leistungslevel]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Leistungslevel](
				[LeistungslevelID] [int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung] [nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_Leistungslevel] PRIMARY KEY CLUSTERED 
				(
					[LeistungslevelID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Leistungslevel_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Leistungslevel_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Leistungslevel]'))
			DROP INDEX [IX_tb_Leistungslevel_Bezeichnung] ON [dbo].[tb_Leistungslevel]
		
		CREATE UNIQUE NONCLUSTERED INDEX IX_tb_Leistungslevel_Bezeichnung ON [dbo].[tb_Leistungslevel]
		(
			Bezeichnung ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO

/* ====================================================================================================
 Author:		Dieter J. Jäger
 CreateDate:	2020-08-13
 Tablename:		tb_Traingsteil
 Description:	Referenztabelle mit allen Trainigsteilen zu einer Übung, die wiederum Teil einer
				Kurseinheit ist. Unter Trainigsteil/Trainingsabschitt versteht man üblicherweise
				ob es sich um das WartUp, die eigentliche Trainingseinheit oder Cooldown handelt
 ForeignKeys:	-

 History
 2020-08-13 dj	Tabelle erstellt
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt
				werden, falls die Tabelle bereits existiert
 ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_Traingsteil
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Trainingsteil]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Trainingsteil](
					[TrainingsteilID] [int] IDENTITY(1,1) NOT NULL,
					[Bezeichnung] [nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_Trainingsteil] PRIMARY KEY CLUSTERED 
				(
					[TrainingsteilID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Trainingsteil_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Trainingsteil_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Trainingsteil]'))
			DROP INDEX [IX_tb_Trainingsteil_Bezeichnung] ON [dbo].[tb_Trainingsteil]
		
		CREATE UNIQUE NONCLUSTERED INDEX IX_tb_Trainingsteil_Bezeichnung ON [dbo].[tb_Trainingsteil]
		(
			Bezeichnung ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO

/* ====================================================================================================
 Author:		Dieter J. Jäger
 CreateDate:	2020-08-13
 Tablename:		tb_KursTyp
 Description:	Referenztabelle aller möglichen Kurstypen eines Kurses
 ForeignKeys:	-

 History
 2020-08-13 dj	Tabelle erstellt
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt
				werden, falls die Tabelle bereits existiert
				Hinzufügen der Einschränkungen
 ====================================================================================================*/
BEGIN
	BEGIN --Tabelle: tb_KursTyp
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Kurstyp]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Kurstyp](
				[KursTypID]			[int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung]		[varchar](50)  NOT NULL,
				[Beschreibung]		[varchar](max) NULL,
				[Besonderheiten]	[varchar](max) NULL,	
				[Hilfsmittel]		[varchar](max) NULL,			
				CONSTRAINT [PK_tb_Kurstyp] PRIMARY KEY CLUSTERED 
				(
					[KursTypID] ASC
				)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN --Index:	 IX_KursTyp_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_KursTyp_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Kurstyp]'))
			DROP INDEX [IX_tb_KursTyp_Bezeichnung] ON [dbo].[tb_Kurstyp]

		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_KursTyp_Bezeichnung] ON [dbo].[tb_Kurstyp]
		(
			Bezeichnung ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO

/* ====================================================================================================
 Author:		Dieter J. Jäger
 CreateDate:	2020-08-13
 Tablename:		tb_Kurs
 Description:	Stammtabelle eines Kurs mit weiteren Informationen
 ForeignKeys:	KurstypID		->  Verweis auf den Kurstyp 1:n
				PersonRolleID	->  Verweis auf den Trainer 1:n

 History
 2020-08-13 dj	Tabelle erstellt
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
====================================================================================================*/
BEGIN
	BEGIN  --Tabelle:		tb_Kurs
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Kurs]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Kurs]
			(
				[KursID]			[int]  IDENTITY(1,1) NOT NULL,
				[KursTypID]			[int]  NOT NULL,
				[TrainerID]			[int]  NULL,
				[Startdatum]		[date] NOT NULL,
				[Enddatum]			[date] NOT NULL,
				[MinTeilnehmerzahl] [int]  NOT NULL,
				[MaxTeilnehmerzahl] [int]  NOT NULL,
				[Preis]				[money] NOT NULL,
				CONSTRAINT [PK_tb_Kurs] PRIMARY KEY CLUSTERED 
				(
					[KursID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN  --Einschränkung: MinTeilnehmerzahl <= [MaxTeilnehmerzahl AND MinTeilnehmerzahl > 0
		IF EXISTS(SELECT * FROM sys.check_constraints WHERE name='CK_tb_Kurs_MinTeilnehmerzahl' and parent_object_id=OBJECT_ID('[dbo].[tb_Kurs]'))	
			ALTER TABLE [dbo].[tb_Kurs] DROP CONSTRAINT [CK_tb_Kurs_MinTeilnehmerzahl]

		ALTER TABLE [dbo].[tb_Kurs]  
		WITH CHECK 
			ADD CONSTRAINT [CK_tb_Kurs_MinTeilnehmerzahl] 
			CHECK ([MinTeilnehmerzahl] <= [MaxTeilnehmerzahl] AND [MinTeilnehmerzahl] > 0)
		ALTER TABLE [dbo].[tb_Kurs] CHECK CONSTRAINT [CK_tb_Kurs_MinTeilnehmerzahl]
	END
	BEGIN  --Einschränkung: StartDatum <= EndDatum]
		IF EXISTS(SELECT * FROM sys.check_constraints WHERE name='CK_tb_Kurs_Startdatum' and parent_object_id=OBJECT_ID('[dbo].[tb_Kurs]'))	
			ALTER TABLE [dbo].[tb_Kurs] DROP CONSTRAINT [CK_tb_Kurs_Startdatum]

		ALTER TABLE [dbo].[tb_Kurs]  
		WITH CHECK 
			ADD CONSTRAINT [CK_tb_Kurs_Startdatum] 
			CHECK ([StartDatum] <= [EndDatum])
		ALTER TABLE [dbo].[tb_Kurs] CHECK CONSTRAINT [CK_tb_Kurs_MinTeilnehmerzahl]
	END
END
GO


/* ====================================================================================================
 Author:		Olga Kornienko
 CreateDate:	2020-08-13
 Tablename:		tb_Sportlichkeit
 Description:	Referenztabelle aller Sportlichkeitwerte
 ForeignKeys:	-
 History
 2020-08-13 ok	Tabelle erstellt
 2020-08-15 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_Sportlichkeit
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Sportlichkeit]') AND type in (N'U'))
			CREATE TABLE [dbo].[tb_Sportlichkeit](
				[SportlichkeitID]	[int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung]		[nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_Sportlichkeit] PRIMARY KEY CLUSTERED 
				(
					[SportlichkeitID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Sportlichkeit_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Sportlichkeit_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Sportlichkeit]'))
			DROP INDEX [IX_tb_Sportlichkeit_Bezeichnung] ON [dbo].[tb_Sportlichkeit]

		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Sportlichkeit_Bezeichnung] ON [dbo].[tb_Sportlichkeit]
		(
			[Bezeichnung] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Olga Kornienko
 CreateDate:	2020-08-13
 Tablename:		tb_Erfahrung
 Description:	Referenztabelle aller Erfahrungswerte
 ForeignKeys:	-

 History
 2020-08-13 ok	Tabelle erstellt
 2020-08-15 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_Erfahrung
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Erfahrung]') AND type in (N'U'))
			CREATE TABLE [dbo].[tb_Erfahrung](
				[ErfahrungID] [int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung] [nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_Erfahrung] PRIMARY KEY CLUSTERED 
				(
					[ErfahrungID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Uebung_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Erfahrung_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Erfahrung]'))
			DROP INDEX [IX_tb_Erfahrung_Bezeichnung] ON [dbo].[tb_Erfahrung]
		
		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Erfahrung_Bezeichnung] ON [dbo].[tb_Erfahrung]
		(
			[Bezeichnung] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Olga Kornienko
 CreateDate:	2020-08-13
 Tablename:		tb_Rolle
 Description:	Referenztabelle aller Rollen
 ForeignKeys:	-
 History
 2020-08-13 ok	Tabelle erstellt
 2020-08-15 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
 ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_Rolle
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Rolle]') AND type in (N'U'))
			CREATE TABLE [dbo].[tb_Rolle](
				[RolleID]		[int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung]	[nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_Rolle] PRIMARY KEY CLUSTERED 
				(
					[RolleID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_tb_Rolle_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Rolle_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Rolle]'))
			DROP INDEX [IX_tb_Rolle_Bezeichnung] ON [dbo].[tb_Rolle]
		
		CREATE UNIQUE NONCLUSTERED INDEX IX_tb_Rolle_Bezeichnung ON [dbo].[tb_Rolle]
		(
			Bezeichnung ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Olga Kornienko
 CreateDate:	2020-08-13
 Table:			tb_PersonRolle
 Description:	Gibt an welche Rollen einer Person zugeordnet sein können. Da eine Person mehrere 
				Rollen und umgekehrt haben kann, handelt es sich um eine Zuordnungtabelle m:n
 ForeignKeys:	PersonID verweist auf Stammtabelle tb_Person  1:n 
				RolleID verweist auf Referenztabelle tb_Rolle 1:n
 History
 2020-08-13 ok	Tabelle erstellt
 2020-08-15 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
 ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_PersonRolle
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_PersonRolle]') AND type in (N'U'))
			CREATE TABLE [dbo].[tb_PersonRolle](
				[PersonRolleID] [int] IDENTITY(1,1) NOT NULL,
				[PersonID]		[int] NOT NULL,
				[RolleID]		[int] NOT NULL,
				[Beitrittsdatum][date] NOT NULL,
				 CONSTRAINT [PK_tb_PersonRolle] PRIMARY KEY CLUSTERED 
				(
					[PersonRolleID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Muskelgruppe_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_PersonRolle_PersonIDRolleID' and object_id=OBJECT_ID('[dbo].[tb_PersonRolle]'))
			DROP INDEX [IX_tb_PersonRolle_PersonIDRolleID] ON [dbo].[tb_PersonRolle]
		
		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_PersonRolle_PersonIDRolleID] ON [dbo].[tb_PersonRolle]
		(
			[PersonID] ASC,
			[RolleID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Olga Kornienko
 CreateDate:	2020-08-13
 Table:			tb_TeilnehmerKurs
 Description:	Zuordungstabelle mit allen Teilnehmern die für einen Kurs angemeldet sind
 ForeignKeys:	Teilnehmer verweist auf Zuordnungstabelle tb_Teilnehmer 1:n
				KursID verweist auf Zuordnungstabelle tb_Kurse	1:n
				SportlichkeitID verweist auf Referenztabelle tb_Sportlichkeit 1:n
				ErfahrungID verweist auf Referenztabelle tb_Erfahrung 1:n
				KontraindikationID verweist auf Referenztabelle tb_Kontraindikation 1:n
 History
 2020-08-13 ok	Tabelle erstellt
 2020-08-15 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
 ====================================================================================================*/
 BEGIN
	BEGIN	--Tabelle:	tb_TeilnehmerKurs
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_TeilnehmerKurs]') AND type in (N'U'))
			CREATE TABLE [dbo].[tb_TeilnehmerKurs](
				[TeilnehmerKursID]	[int] IDENTITY(1,1) NOT NULL,
				[TeilnehmerID]		[int]NOT NULL,
				[KursID]			[int] NOT NULL,
				[Anmeldedatum]		[date] NOT NULL,
				[SportlichkeitID]	[int] NOT NULL,
				[ErfahrungID]		[int] NOT NULL,
				[KontraindikationID][int] NOT NULL,
				[Kursziel]			[nvarchar](max) NULL,
				[KurszielErreicht]	[bit] NULL,
				CONSTRAINT [PK_tb_TeilnehmerKurs] PRIMARY KEY CLUSTERED 
				(
					[TeilnehmerKursID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_TeilnehmerKurs_TeilnehmerIDKursID
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_TeilnehmerKurs_TeilnehmerIDKursID' and object_id=OBJECT_ID('[dbo].[tb_TeilnehmerKurs]'))
			DROP INDEX [IX_tb_TeilnehmerKurs_TeilnehmerIDKursID] ON [dbo].[tb_TeilnehmerKurs]
		
		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_TeilnehmerKurs_TeilnehmerIDKursID] ON [dbo].[tb_TeilnehmerKurs]
		(
			[TeilnehmerID] ASC,
			[KursID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Martin Poledniok
 CreateDate:	2020-08-15
 Tablename:		tb_Person
 Description:	Stammtabelle Person mit weiteren Informationen
 ForeignKeys:	PlzOrt_ID	->  Verweis auf die Plz 1:n

 History		
 2020-08-15 mp	Tabelle erstellt
				Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt werden, 
				falls die Tabelle bereits existiert 
				Hinzufügen der Einschränkungen
  ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:		 tb_Person
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tb_Person' AND type in ('U'))
			CREATE TABLE [dbo].[tb_Person](
				[PersonID]		[int] IDENTITY(1,1) NOT NULL,
				[Vorname]		[nvarchar](50) NOT NULL,
				[Nachname]		[nvarchar](50) NOT NULL,
				[Strasse]		[nvarchar](50) NOT NULL,
				[Hausnummer]	[nvarchar](10) NOT NULL,
				[PlzOrtID]		[int] NOT NULL,
				[Geburtsdatum]	[date] NOT NULL,
				[Geschlecht]	[char](1) NOT NULL,
				[EMail]			[nvarchar](50) NULL,
			CONSTRAINT [PK_tb_Person] PRIMARY KEY CLUSTERED 
			(
				[PersonID] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]
	END
	BEGIN	--Index:		 IX_tb_Person_Nachname
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Person_Nachname' and object_id=OBJECT_ID('[dbo].[tb_Person]'))
			DROP INDEX [IX_tb_Person_Nachname] ON [dbo].[tb_Person]

		CREATE NONCLUSTERED INDEX [IX_tb_Person_Nachname] ON [dbo].[tb_Person]
		(
			[Nachname] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		
	END
	BEGIN	--Einschränkung: [Geschlecht] = 'm' OR 'w' OR 'd'
		IF EXISTS(SELECT * FROM sys.check_constraints WHERE name='CK_tb_Person_Geschlecht' and parent_object_id=OBJECT_ID('[dbo].[tb_Person]'))
			ALTER TABLE [dbo].[tb_Person] DROP CONSTRAINT [CK_tb_Person_Geschlecht]

			ALTER TABLE [dbo].[tb_Person]  
			WITH CHECK 
				ADD  CONSTRAINT [CK_tb_Person_Geschlecht] 
				CHECK  ([Geschlecht]='m' OR [Geschlecht]='w' OR [Geschlecht]='d')
		ALTER TABLE [dbo].[tb_Person] CHECK CONSTRAINT [CK_tb_Person_Geschlecht]
	END
END
GO
	

/* ====================================================================================================
 Author:		Martin Poledniok
 CreateDate:	2020-08-15
 Tablename:		tb_PlzOrt
 Description:	Referenztabelle PlzOrt mit allen PLZ inkl Ort
 ForeignKeys:	
 2020-08-15 mp	Tabelle erstellt
  				Einschränkungen müssen extra geprüft werden, damit sie auch angefügt werden, 
				falls die Tabelle bereits existiert 
				Hinzufügen der Einschränkungen
====================================================================================================*/
BEGIN
	BEGIN --Tabelle: tb_PlzOrt
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tb_PlzOrt' AND type in ('U'))
			CREATE TABLE [dbo].[tb_PlzOrt](
				[PlzOrtID] [int] IDENTITY(1,1) NOT NULL,
				[PLZ] [nvarchar](5) NOT NULL,
				[Ort] [nvarchar](50) NOT NULL,
				[Bundesland] [nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_PlzOrt] PRIMARY KEY CLUSTERED 
				(
					[PlzOrtID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN --Einschränkung: len([PLZ]) = 5
		IF EXISTS(SELECT * FROM sys.check_constraints WHERE name='CK_tb_PlzOrt_PLZ' and parent_object_id=OBJECT_ID('[dbo].[tb_PlzOrt]'))
			ALTER TABLE [dbo].[tb_PlzOrt] DROP CONSTRAINT [CK_tb_PlzOrt_PLZ]

			ALTER TABLE [dbo].[tb_PlzOrt]  
			WITH CHECK 
				ADD CONSTRAINT [CK_tb_PlzOrt_PLZ] 
				CHECK (len([PLZ]) = 5)

		ALTER TABLE [dbo].[tb_PlzOrt] CHECK CONSTRAINT [CK_tb_PlzOrt_PLZ]
	END
END
GO


/* ====================================================================================================
  Author:		Martin Poledniok
  CreateDate:	2020-08-15
  Tablename:	tb_Teilnehmer
  Description:	Stammtabelle Teilnehmer mit weiteren Informationen
  ForeignKeys:	PersonID	-> Verweis auf die Person 1:n			
  20200815MP	Tabelle erstellt
				Indizes müssen extra geprüft werden, damit sie auch angefügt werden, 
				falls die Tabelle bereits existiert  
====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_Teilnehmer
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Teilnehmer]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Teilnehmer](
				[TeilnehmerID] [int] IDENTITY(1,1) NOT NULL,
				[PersonID] [int] NOT NULL,
				[Beitrittsdatum] [date] NOT NULL,
				CONSTRAINT [PK_tb_Teilnehmer] PRIMARY KEY CLUSTERED 
				(
				[TeilnehmerID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Teilnehmer_PersonID
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Teilnehmer_PersonID' and object_id=OBJECT_ID('[dbo].[tb_Teilnehmer]'))
			DROP INDEX [IX_tb_Teilnehmer_PersonID] ON [dbo].[tb_Teilnehmer]

		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Teilnehmer_PersonID] ON [dbo].[tb_Teilnehmer]
		(
			[PersonID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Martin Poledniok
 CreateDate:	2020-08-15
 Tablename:		tb_Trainer
 Description:	Stammtabelle Trainer mit weiteren Informationen
 ForeignKeys:	PersonID	-> Verweis auf die Person 1:n	
 History
 2020-08-15 mp	Tabelle erstellt
				Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
 2020-08-15 mp	Spalte Verfügbarkeit hinzugefügt (Default = 1 -> verfügbar)
				ACHTUNG: 
				Der Defaultwert muss über ALTER TABLE explizit hinzugefügt werden, weil sonst vom 
				SQL-Server ein interner Name vergeben wird, den man nicht mehr ohne großen Aufwand
				manipulieren kann. weitere Infos s.u.
====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	tb_Trainer
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tb_Trainer' AND type in ('U'))
		BEGIN
			CREATE TABLE [dbo].[tb_Trainer](
				[TrainerID]						[int] IDENTITY(1,1) NOT NULL,
				[PersonID]						[int] NOT NULL,
				[HonorarVereinbarung]			[money] NOT NULL,
				[SportBackground]				[nvarchar](max) NOT NULL,
				[LeistungssportErfahrung]		[int] NOT NULL,	-- default(0) hier jedoch NICHT angeben!
				[TrainerErfahrung]				[int] NOT NULL,	--default(0),-- hier jedoch NICHT angeben!
				[FunctionalTrainingErfahrung]	[int] NOT NULL,	-- default(0) hier jedoch NICHT angeben!
				[Beitrittsdatum]				[date] NOT NULL,
				--[Verfuegbarkeit]				[bit] NOT NULL, -- default(1) hier jedoch NICHT angeben!
				CONSTRAINT [PK_tb_Trainer] PRIMARY KEY CLUSTERED 
				(
					[TrainerID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

			-- Die Default Wert müssen über ALTER TABLE erstellt werden, damit man Einfluss auf den internen Namen des Wertes behält.
			-- Dies wiederum ist notwenig, falls man zu einem späteren Zeit gezwungen ist, den DEFAULT-Wert zu ändern od. löschen.
			ALTER TABLE [dbo].[tb_Trainer] ADD  CONSTRAINT [DF_tb_Trainer_LeistungssportErfahrung]  DEFAULT ((0)) FOR [LeistungssportErfahrung]
			ALTER TABLE [dbo].[tb_Trainer] ADD  CONSTRAINT [DF_tb_Trainer_TrainerErfahrung]  DEFAULT ((0)) FOR [TrainerErfahrung]
			ALTER TABLE [dbo].[tb_Trainer] ADD  CONSTRAINT [DF_tb_Trainer_FunctionalTrainingErfahrung]  DEFAULT ((0)) FOR [FunctionalTrainingErfahrung]
			--ALTER TABLE [dbo].[tb_Trainer] ADD  CONSTRAINT [DF_tb_Trainer_Verfuegbarkeit]  DEFAULT ((1)) FOR [Verfuegbarkeit]
		END
	END
	BEGIN	--Index:	IX_tb_Person_PersonID
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Trainer_PersonID' and object_id=OBJECT_ID('[dbo].[tb_Trainer]'))
			DROP INDEX [IX_tb_Trainer_PersonID] ON [dbo].[tb_Trainer]

		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Trainer_PersonID] ON [dbo].[tb_Trainer]
		(
			[PersonID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
	--BEGIN	--Default:	DF_tb_Trainer_Verfuegbarkeit	(nur als Beispiel > Es wird ein Defaultwert gelöscht und danach wieder erstellt)
		--IF EXISTS(SELECT * FROM sys.default_constraints WHERE name = 'DF_tb_Trainer_Verfuegbarkeit' and parent_object_id=OBJECT_ID('[dbo].[tb_Trainer]'))
		--	ALTER TABLE [dbo].[tb_Trainer] DROP CONSTRAINT [DF_tb_Trainer_Verfuegbarkeit]

		--ALTER TABLE [dbo].[tb_Trainer] ADD  CONSTRAINT [DF_tb_Trainer_Verfuegbarkeit]  DEFAULT (1) FOR [Verfuegbarkeit]
	--END
END 
GO


/* ====================================================================================================
 Author:		Manuela Hebel
 CreateDate:	2020-08-14
 Tablename:		tb_Kurseinheit
 Description:	Stammtabelle der Kurseinheiten je Kurs
 ForeignKeys:	KursID		->  Verweis auf den Kurstyp 1:n
				TrainerID	->  Verweis auf den Trainer 1:n		

 FAQ_DJ:		- Die Spalte TrainerID in GeplanterTrainerID umbennen und dazu 
				  durchgeführtTrainerID (zzgl. evtl Grund) aufteilen/hinzufühen?

 History
 2020-08-14 mh	Tabelle erstellt
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	IX_tb_Kurseinheit_KursIDDatumTrainerID
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Kurseinheit]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Kurseinheit]
			(
				[KurseinheitID] [int]  IDENTITY(1,1) NOT NULL,
				[KursID]		[int]  NOT NULL,
				[Datum]			[date] NOT NULL,
				[TrainerID]		[int]  NOT NULL,			--FAQ_DJ: Aufteilen in Geplant, Durchgeführt rvtl. Grund ?
				[Stattgefunden] [bit]  NOT NULL,
				CONSTRAINT [PK_tb_Kurseinheit] PRIMARY KEY CLUSTERED 
				(
					[KurseinheitID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Kurseinheit_KursIDDatumTrainerID
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Kurseinheit_KursIDDatumTrainerID' and object_id=OBJECT_ID('[dbo].[tb_Kurseinheit]'))
			DROP INDEX [IX_tb_Kurseinheit_KursIDDatumTrainerID] ON [dbo].[tb_Kurseinheit]

		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Kurseinheit_KursIDDatumTrainerID] ON [dbo].[tb_Kurseinheit]
		(
			[KursID] ASC,
			[Datum] ASC,
			[TrainerID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Manuela Hebel
 CreateDate:	2020-08-14
 Tablename:		tb_Uebung
 Description:	Stammtabelle aller Uebungen je Kurseinheit, diese werden vom Trainer bei Planen einer
				Kurseinheit zu dieser vor dem Training zugeordnet
 ForeignKeys:	TrainingsschwerpunktID 1:n
				MuskelgruppeID 1:n
				KontraindikationID 1:n
				TrainingsteilID 1:n
				LeistungslevelID 1:n

   FAQ_DJ:		- Fehlt hier noch die Zuordnug (m:n) zur Kurseinheit	?
   
 History
 2020-08-14 mh	Tabelle erstellt
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
====================================================================================================*/
BEGIN
	BEGIN	--Tqabelle:	IX_tb_Uebung_BezeichnungVariante
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Uebung]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Uebung](
				[UebungID]				[int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung]			[varchar](100) NOT NULL,
				[Variante]				[varchar](500) NOT NULL,
				[Beschreibung]			[nvarchar](max) NULL,
				[LinkVideobeschreibung] [nvarchar](max) NULL,
				[Ansagen]				[nvarchar](max) NULL,
				[SetDauerSec]			[int] NULL,
				[TrainingsschwerpunktID][int] NOT NULL,
				[MuskelgruppeID]		[int] NOT NULL,
				[KontraindikationID]	[int] NULL,
				[TrainingsteilID]		[int] NULL,
				[LeistungslevelID]		[int] NULL,
				[Hilfsmittel]			[nvarchar](max) NULL,
				CONSTRAINT [PK_tb_Uebung] PRIMARY KEY CLUSTERED 
				(
					[UebungID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Uebung_BezeichnungVariante
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Uebung_BezeichnungVariante' and object_id=OBJECT_ID('[dbo].[tb_Uebung]'))
			DROP INDEX [IX_tb_Uebung_BezeichnungVariante] ON [dbo].[tb_Uebung]
		
		CREATE UNIQUE NONCLUSTERED INDEX [IX_tb_Uebung_BezeichnungVariante] ON [dbo].[tb_Uebung]
		(
			[Bezeichnung] ASC,
			[Variante] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Manuela Hebel
 CreateDate:	2020-08-14
 Tablename:		tb_Trainingsschwerpunkt
 Description:	Referenztabelle mit allen Trainigsschwerpunkten
 ForeignKeys:	-

 History
 2020-08-14 mh	Tabelle erstellt
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
 ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle: tb_Trainingsschwerpunkt
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Trainingsschwerpunkt]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Trainingsschwerpunkt](
				[TrainingsschwerpunktID][int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung]			[nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_Trainingsschwerpunkt] PRIMARY KEY CLUSTERED 
				(
					[TrainingsschwerpunktID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index IX_tb__Trainingsschwerpunkt_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Trainingsschwerpunkt_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Trainingsschwerpunkt]'))
			DROP INDEX [IX_tb_Trainingsschwerpunkt_Bezeichnung] ON [dbo].[tb_Trainingsschwerpunkt]
		
		CREATE UNIQUE NONCLUSTERED INDEX IX_tb_Trainingsschwerpunkt_Bezeichnung ON [dbo].[tb_Trainingsschwerpunkt]
		(
			Bezeichnung ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO


/* ====================================================================================================
 Author:		Manuela Hebel
 CreateDate:	2020-08-14
 Tablename:		tb_Muskelgruppe
 Description:	Referenztabelle mit allen Muskelgruppen
 ForeignKeys:	-

 History
 2020-08-14 mh	Tabelle erstellt
 2020-08-14 dj	Indizes und Einschränkungen müssen extra geprüft werden, damit sie auch angefügt 
				werden, falls die Tabelle bereits existiert
 ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	IX_tb_Muskelgruppe_Bezeichnung
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Muskelgruppe]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Muskelgruppe](
				[MuskelgruppeID] [int] IDENTITY(1,1) NOT NULL,
				[Bezeichnung] [nvarchar](50) NOT NULL,
				CONSTRAINT [PK_tb_Muskelgruppe] PRIMARY KEY CLUSTERED 
				(
					[MuskelgruppeID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
	END
	BEGIN	--Index:	IX_tb_Muskelgruppe_Bezeichnung
		IF EXISTS(SELECT * FROM sys.indexes WHERE name='IX_tb_Muskelgruppe_Bezeichnung' and object_id=OBJECT_ID('[dbo].[tb_Muskelgruppe]'))
			DROP INDEX [IX_tb_Muskelgruppe_Bezeichnung] ON [dbo].[tb_Muskelgruppe]
		
		CREATE UNIQUE NONCLUSTERED INDEX IX_tb_Muskelgruppe_Bezeichnung ON [dbo].[tb_Muskelgruppe]
		(
			Bezeichnung ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
END
GO

/* ====================================================================================================
 Author:		Manuela Hebel
 CreateDate:	2020-08-14
 Tablename:		tb_Trainingsplan
 Description:	Referenztabelle mit einen Trainingsplan für einen Kurs
 ForeignKeys:	-

 History
 2020-08-19 mh	Tabelle erstellt
 ====================================================================================================*/
BEGIN
	BEGIN	--Tabelle:	IX_tb_Muskelgruppe_Bezeichnung
		IF NOT EXISTS (SELECT * FROM sys.tables WHERE object_id = OBJECT_ID(N'[dbo].[tb_Trainingsplan]') AND type in ('U'))
			CREATE TABLE [dbo].[tb_Trainingsplan](
				[TrainingsplanID] [int] IDENTITY(1,1) NOT NULL,
				[Wochentag] [int] NOT NULL,
				[Uhrzeit] [time] NOT NULL,
				[DauerMin] [int] NOT NULL,
				[KursID] [int] NOT NULL,
				CONSTRAINT [PK_tb_Trainingsplan] PRIMARY KEY CLUSTERED 
				(
					[TrainingsplanID] ASC
				)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]

			ALTER TABLE [dbo].[tb_Trainingsplan] ADD  CONSTRAINT [DF_tb_Trainingsplan_DauerMin]  DEFAULT (60) FOR [DauerMin]
	END
	BEGIN --Einschränkung: Wochentag BETWEEN 1 AND 7
		IF EXISTS(SELECT * FROM sys.check_constraints WHERE name='CK_tb_Trainingsplan_Wochentag' and parent_object_id=OBJECT_ID('[dbo].[tb_Trainingsplan]'))
			ALTER TABLE [dbo].[tb_Trainingsplan] DROP CONSTRAINT [CK_tb_Trainingsplan_Wochentag]

			ALTER TABLE [dbo].[tb_Trainingsplan]  
			WITH CHECK 
				ADD CONSTRAINT [CK_tb_Trainingsplan_Wochentag] 
				CHECK (Wochentag BETWEEN 1 AND 7)

		ALTER TABLE [dbo].[tb_Trainingsplan] CHECK CONSTRAINT [CK_tb_Trainingsplan_Wochentag]
	END
END
GO


--momentan noch nicht benötigte Tabellen wieder löschen
drop table tb_Uebung
drop table tb_Trainingsschwerpunkt
drop table tb_Trainingsteil
drop table tb_Muskelgruppe
drop table tb_Leistungslevel
