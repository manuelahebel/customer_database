USE [ZimmerSport]
GO

/* ====================================================================================================
 Author:		Olga Korienko
 CreateDate:	2020-08-18
 Sicht:			sp_AddTeilnehmerKursIFSportlich
 Description:	Prozedur, welche die Anmeldung eines Teilnehmer für einen Kurs nur zulässt, wenn ihr 
				Fitnesslevel nicht unter dem durchschnittlichen Fitnesslevel der anderen bereits 
				angemeldeten Kursteilnehmer liegt und sein Alter in der Altersgruppe der bereits 
				angemeldeten Kursteilnehmer liegt, falls sich mehr als 6 Teilnehmer für diesen Kurs 
				bereits angemeldet haben
 History
 2020-08-18 mp	Prozedur erstellt
 ====================================================================================================*/
DROP PROCEDURE IF EXISTS [dbo].[sp_AddTeilnehmerKursIFSportlich]
GO

/*
	@Kursid 
	
	SELECT AVG(SportlichkeitID) AS 'Durchschnittliche Fitness' FROM tb_TeilnehmerKurs
	WHERE KursID = 1 
	
	SELECT COUNT(TeilnehmerID) AS 'Anzahl Teilnehmer' FROM tb_TeilnehmerKurs
	WHERE KursID = 1 
*/


CREATE PROCEDURE [dbo].[sp_AddTeilnehmerKursIFSportlich] 
	@KursID int, 
	@Geburtsdatum date,
	@Sportlichkeit int, -- wie Sportlich ist der Teilnehmer (siehe tb_Sportlichkeit)
	@Erfolg bit OUTPUT, -- geklappt oder nicht
	@Feedback VARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
AS
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		SET @Erfolg = 1;
		SET @Feedback = 'Du bist angemeldet!';
		-------------------------------------------------------	
		DECLARE @AverageFitness int;
		DECLARE @TeilnehmerAlter int;
		DECLARE @AverageAge float;
		DECLARE @StdAge float;
		DECLARE @AverageAgei int;
		DECLARE @StdAgei int;
		DECLARE @Anzahlteilnehmer int;
		DECLARE @msg AS varchar(MAX);

		-- Berechne die durchschnittliche Sportlichkeit der bereits angemeldeten Teilnehmer
		SELECT @AverageFitness = AVG(SportlichkeitID) FROM tb_TeilnehmerKurs WHERE KursID = @KursID
		SELECT @Anzahlteilnehmer = COUNT(TeilnehmerID) FROM tb_TeilnehmerKurs WHERE @KursID = @KursID

		-- Berechne das durchschnittliche Alter der bereits angemeldeten Teilnehmer
		SELECT k.Age INTO  #AlterTeilnehmer 
		FROM 
			(
				SELECT [dbo].[sf_GetAge] (tb_Person.Geburtsdatum) Age --@AverageAge =
				FROM tb_Person
					INNER JOIN tb_Teilnehmer
						ON tb_Person.PersonID = tb_Teilnehmer.PersonID
					INNER JOIN tb_TeilnehmerKurs
						ON tb_Teilnehmer.TeilnehmerID = tb_TeilnehmerKurs.TeilnehmerID
					INNER JOIN tb_Kurs
						ON tb_TeilnehmerKurs.KursID = tb_Kurs.KursID
					INNER JOIN tb_Kurstyp
						ON tb_Kurstyp.KursTypID = tb_Kurs.KursTypID
				WHERE tb_Kurs.KursID =@KursID
			)k

		SELECT @AverageAge = AVG(Age) FROM #AlterTeilnehmer;
		SELECT @StdAge = Stdev(Age) FROM #AlterTeilnehmer;

		SET @AverageAgei = round(@AverageAge,0);
		SET @StdAgei = round(@StdAge,0);

		SET @TeilnehmerAlter =  [dbo].[sf_GetAge](@Geburtsdatum);
	

		-- Teste, ob die Sportlichkeit des Teilnehmers geringer ist als die durchschnittliche Sportlichkeit, der bereits angemeldeten Teilnehmer
		BEGIN TRY 
			IF (@Sportlichkeit<@AverageFitness AND (@Anzahlteilnehmer > 6))
				THROW 50101,'',1;  
		END TRY 
		BEGIN CATCH
			SET @Erfolg = 0;
			SET @msg = FORMATMESSAGE('Kurs %i hat Sportlichkeitslevel %i. Bitte anderen Kurs auswählen!',@KursID,@AverageFitness);
			SET @Feedback = @msg;
		END CATCH

		-- Teste, ob das Alter des Teilnehmers über dem  durchschnittlichen Alter, der bereits angemeldeten Teilnehmer liegt
		BEGIN TRY 
		IF  ((@TeilnehmerAlter<(@AverageAgei-@StdAgei ) OR @TeilnehmerAlter>(@AverageAgei+@StdAgei )) AND @Anzahlteilnehmer > 6)
				THROW 50102,'',1;  
		END TRY 
		BEGIN CATCH
			SET @Erfolg = 0;
			SET @msg = FORMATMESSAGE('Der Kurs %i ist bereits einer anderen Altersgruppe zugeordnet. Bitte anderen Kurs wählen! Alter: %i, Altersgruppe von %i bis %i.',@KursID,@TeilnehmerAlter,@AverageAgei-@StdAgei,@AverageAgei+@StdAgei);
			SET @Feedback = @msg;
		END CATCH
	END
GO

