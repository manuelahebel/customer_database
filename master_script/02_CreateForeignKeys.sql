USE [ZimmerSport]
GO

/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-17
 Tablename:		tb_TeilnehmerKurs
 Description:	Foreignkeys
 ForeignKeys:	Benamung von ForeignKeys ist immer der FKName_PKName, m-n besteht immer zweimal aus 1:n

				FK_tb_Person_tb_Teilnehmer					1:1 (deshalbt Reihenfolge von PK_Tabelle und FK_Tabelle egal)
				FK_tb_Person_tb_Trainer						1:1 (deshalbt Reihenfolge von PK_Tabelle und FK_Tabelle egal)
				FK_tb_Person_tb_PlzOrt						1:n
				FK_tb_PersonRolle_tb_Person					1:n
				FK_tb_PersonRolle_tb_Rolle					1:n
				FK_tb_TeilnehmerKurs_tb_Erfahrung			1:n
				FK_tb_TeilnehmerKurs_tb_Kontraindikation	1:n
				FK_tb_TeilnehmerKurs_tb_Sportlichkeit		1:n
				FK_tb_TeilnehmerKurs_tb_Kurs				1:n
				FK_tb_TeilnehmerKurs_tb_Teilnehmer			1:n
				FK_tb_Kurs_tb_KursTyp						1:n
				FK_tb_Kurs_tb_Trainer						1:n
				FK_tb_Kurseinheit_tb_Kurs					1:n
				FK_tb_Kurseinheit_tb_Trainer				1:n
				FK_tb_Trainingplan_tb_Kurs					1:n
 History
 2020-08-16 dj	Erstellung der ForegnKeys über Script
====================================================================================================*/
BEGIN
	/*
		Erläuterung:
		Zuerst wird geprüft, er FK bereits in der Datenbank existiert
			Ist das so wird der FK gelöscht, damit der FK in jedem Fall neu erstellt werden kann
		
		Der FK wird in der DB erstellt 
		Der FK wird ausgeführt (check)
	*/

	BEGIN --ForeignKey:	FK_tb_PersonRolle_tb_Person
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_PersonRolle_tb_Person' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_PersonRolle]'))
			ALTER TABLE [dbo].[tb_PersonRolle] DROP CONSTRAINT FK_tb_PersonRolle_tb_Person
		
		ALTER TABLE [dbo].[tb_PersonRolle] WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_PersonRolle_tb_Person
			FOREIGN KEY([PersonID]) REFERENCES [dbo].[tb_Person] ([PersonID])

		ALTER TABLE [dbo].[tb_PersonRolle] CHECK CONSTRAINT FK_tb_PersonRolle_tb_Person
	END
	BEGIN --ForeignKey:	FK_tb_PersonRolle_tb_Rolle
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_PersonRolle_tb_Rolle' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_PersonRolle]'))
			ALTER TABLE [dbo].[tb_PersonRolle] DROP CONSTRAINT FK_tb_PersonRolle_tb_Rolle
		
		ALTER TABLE [dbo].[tb_PersonRolle] WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_PersonRolle_tb_Rolle
			FOREIGN KEY([RolleID]) REFERENCES [dbo].[tb_Rolle] ([RolleID])

		ALTER TABLE [dbo].[tb_PersonRolle] CHECK CONSTRAINT FK_tb_PersonRolle_tb_Rolle
	END
	BEGIN --ForeignKey:	FK_tb_Person_tb_PlzOrt
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Person_tb_PlzOrt' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_Person]'))
			ALTER TABLE [dbo].[tb_Person] DROP CONSTRAINT FK_tb_Person_tb_PlzOrt
		
		ALTER TABLE [dbo].[tb_Person] WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_Person_tb_PlzOrt 
			FOREIGN KEY([PlzOrtID]) REFERENCES [dbo].tb_PlzOrt ([PlzOrtID])

		ALTER TABLE [dbo].[tb_Person] CHECK CONSTRAINT FK_tb_Person_tb_PlzOrt
	END
	BEGIN --ForeignKey:	FK_tb_TeilnehmerKurs_tb_Erfahrung
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Erfahrung' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_TeilnehmerKurs]'))
			ALTER TABLE [dbo].[tb_TeilnehmerKurs] DROP CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Erfahrung]
		
		ALTER TABLE [dbo].[tb_TeilnehmerKurs] WITH CHECK 
		ADD 
			CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Erfahrung] 
			FOREIGN KEY([ErfahrungID]) REFERENCES [dbo].[tb_Erfahrung] ([ErfahrungID])

		ALTER TABLE [dbo].[tb_TeilnehmerKurs] CHECK CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Erfahrung]
	END
	BEGIN --ForeignKey:	FK_tb_TeilnehmerKurs_tb_Kontraindikation
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Kontraindikation' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_TeilnehmerKurs]'))
			ALTER TABLE [dbo].[tb_TeilnehmerKurs] DROP CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Kontraindikation]
		
		ALTER TABLE [dbo].[tb_TeilnehmerKurs] WITH CHECK 
		ADD 
			CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Kontraindikation] 
			FOREIGN KEY([KontraindikationID]) REFERENCES [dbo].[tb_Kontraindikation] ([KontraindikationID])

		ALTER TABLE [dbo].[tb_TeilnehmerKurs] CHECK CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Kontraindikation]
	END
	BEGIN --ForeignKey:	FK_tb_TeilnehmerKurs_tb_Sportlichkeit
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Sportlichkeit' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_TeilnehmerKurs]'))
			ALTER TABLE [dbo].[tb_TeilnehmerKurs] DROP CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Sportlichkeit]
		
		ALTER TABLE [dbo].[tb_TeilnehmerKurs] WITH CHECK 
		ADD 
			CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Sportlichkeit] 
			FOREIGN KEY([SportlichkeitID]) REFERENCES [dbo].[tb_Sportlichkeit] ([SportlichkeitID])

		ALTER TABLE [dbo].[tb_TeilnehmerKurs] CHECK CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Sportlichkeit]
	END
	BEGIN --ForeignKey:	FK_tb_Kurs_tb_KursTyp
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Kurs_tb_KursTyp' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_Kurs]'))
			ALTER TABLE [dbo].[tb_Kurs] DROP CONSTRAINT FK_tb_Kurs_tb_KursTyp
		
		ALTER TABLE [dbo].tb_Kurs WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_Kurs_tb_KursTyp 
			FOREIGN KEY(KursTypID) REFERENCES [dbo].tb_KursTyp (KursTypID)

		ALTER TABLE [dbo].tb_Kurs CHECK CONSTRAINT FK_tb_Kurs_tb_KursTyp
	END
	BEGIN --ForeignKey:	FK_tb_TeilnehmerKurs_tb_Kurs
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Kurs' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_TeilnehmerKurs]'))
			ALTER TABLE [dbo].[tb_TeilnehmerKurs] DROP CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Kurs]
		
		ALTER TABLE [dbo].[tb_TeilnehmerKurs] WITH CHECK 
		ADD 
			CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Kurs] 
			FOREIGN KEY([KursID]) REFERENCES [dbo].[tb_Kurs] ([KursID])

		ALTER TABLE [dbo].[tb_TeilnehmerKurs] CHECK CONSTRAINT [FK_tb_TeilnehmerKurs_tb_Kurs]
	END
	BEGIN --ForeignKey:	FK_tb_Person_tb_Teilnehmer	1:1 (deshalbt Reihenfolge von PK_Tabelle und FK_Tabelle egal)
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Teilnehmer_tb_Person' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_Teilnehmer]'))
			ALTER TABLE [dbo].[tb_Teilnehmer] DROP CONSTRAINT [FK_tb_Teilnehmer_tb_Person]
		
		ALTER TABLE [dbo].[tb_Teilnehmer] WITH CHECK 
		ADD 
			CONSTRAINT [FK_tb_Teilnehmer_tb_Person] 
			FOREIGN KEY([PersonID]) REFERENCES [dbo].[tb_Person] ([PersonID])

		ALTER TABLE [dbo].[tb_Teilnehmer] CHECK CONSTRAINT [FK_tb_Teilnehmer_tb_Person]
	END
	BEGIN --ForeignKey:	FK_tb_Person_tb_Trainer		1:1 (deshalbt Reihenfolge von PK_Tabelle und FK_Tabelle egal)
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Person_tb_Trainer' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_Trainer]'))
			ALTER TABLE [dbo].tb_Trainer DROP CONSTRAINT FK_tb_Person_tb_Trainer
		
		ALTER TABLE [dbo].tb_Trainer WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_Person_tb_Trainer 
			FOREIGN KEY([PersonID]) REFERENCES [dbo].[tb_Person] ([PersonID])

		ALTER TABLE [dbo].tb_Trainer CHECK CONSTRAINT FK_tb_Person_tb_Trainer
	END
	BEGIN --ForeignKey:	FK_tb_Kurseinheit_tb_Kurs
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Kurseinheit_tb_Kurs' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_Kurseinheit]'))
			ALTER TABLE [dbo].tb_Kurseinheit DROP CONSTRAINT FK_tb_Kurseinheit_tb_Kurs
		
		ALTER TABLE [dbo].tb_Kurseinheit WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_Kurseinheit_tb_Kurs 
			FOREIGN KEY(KursID) REFERENCES [dbo].tb_Kurs (KursID)

		ALTER TABLE [dbo].tb_Kurseinheit CHECK CONSTRAINT FK_tb_Kurseinheit_tb_Kurs

	END
	BEGIN --ForeignKey:	FK_tb_Kurseinheit_tb_Trainer
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Kurseinheit_tb_Trainer' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_Kurseinheit]'))
			ALTER TABLE [dbo].tb_Kurseinheit DROP CONSTRAINT FK_tb_Kurseinheit_tb_Trainer
		
		ALTER TABLE [dbo].tb_Kurseinheit WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_Kurseinheit_tb_Trainer 
			FOREIGN KEY(TrainerID) REFERENCES [dbo].tb_Trainer (TrainerID)

		ALTER TABLE [dbo].tb_Kurseinheit CHECK CONSTRAINT FK_tb_Kurseinheit_tb_Trainer
	END
	BEGIN --ForeignKey:	FK_tb_Kurs_tb_Trainer
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Kurs_tb_Trainer' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_Kurs]'))
			ALTER TABLE [dbo].[tb_Kurs] DROP CONSTRAINT FK_tb_Kurs_tb_Trainer
		
		ALTER TABLE [dbo].tb_Kurs WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_Kurs_tb_Trainer 
			FOREIGN KEY(TrainerID) REFERENCES [dbo].tb_Trainer (TrainerID)

		ALTER TABLE [dbo].tb_Kurs CHECK CONSTRAINT FK_tb_Kurs_tb_Trainer
	END
	BEGIN --ForeignKey:	FK_tb_TeilnehmerKurs_tb_Teilnehmer
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_TeilnehmerKurs_tb_Teilnehmer' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_TeilnehmerKurs]'))
			ALTER TABLE [dbo].[tb_TeilnehmerKurs] DROP CONSTRAINT FK_tb_TeilnehmerKurs_tb_Teilnehmer
		
		ALTER TABLE [dbo].[tb_TeilnehmerKurs] WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_TeilnehmerKurs_tb_Teilnehmer 
			FOREIGN KEY([TeilnehmerID]) REFERENCES [dbo].[tb_Teilnehmer] ([TeilnehmerID])

		ALTER TABLE [dbo].[tb_TeilnehmerKurs] CHECK CONSTRAINT FK_tb_TeilnehmerKurs_tb_Teilnehmer
	END
	BEGIN --ForeignKey:	FK_tb_Trainingsplan_tb_Kurs
		IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name='FK_tb_Trainingsplan_tb_Kurs' AND parent_object_id = OBJECT_ID(N'[dbo].[tb_Trainingsplan]'))
			ALTER TABLE [dbo].[tb_Trainingsplan] DROP CONSTRAINT FK_tb_Trainingsplan_tb_Kurs
		
		ALTER TABLE [dbo].[tb_Trainingsplan] WITH CHECK 
		ADD 
			CONSTRAINT FK_tb_Trainingsplan_tb_Kurs 
			FOREIGN KEY([KursID]) REFERENCES [dbo].[tb_Kurs] ([KursID])

		ALTER TABLE [dbo].[tb_Trainingsplan] CHECK CONSTRAINT FK_tb_Trainingsplan_tb_Kurs
	END
END
GO