USE [ZimmerSport]
GO

/* ====================================================================================================
 Author:		xxx
 CreateDate:	2020-08-18
 Sicht:			tr_KurseinheitTestDatum
 Description:	Tigger fuer Kurseinheit, um zu testen ob diese stattgefunden haben kann und nicht in 
				der Zukunft liegt

 History
 2020-08-18 ok	Trigger erstellt
 ====================================================================================================*/
DROP TRIGGER IF EXISTS [dbo].[tr_KurseinheitTestDatum] 
GO

CREATE TRIGGER [dbo].[tr_KurseinheitTestDatum] 
   ON  [dbo].[tb_Kurseinheit]
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	--Print 'Kurseinheit kann nicht stattgefunden haben Datum liegt inder Zukuft!'
    -- Insert statements for trigger here
	DECLARE @CurrDatum date;
	DECLARE @insertedStattgefunden bit;
	DECLARE @insertedDatum date;
	------------------------------
	DECLARE @msg AS varchar(MAX);			
	DECLARE @Monat int;
	DECLARE @Jahr int;
	DECLARE @Tag int;

	SELECT @insertedDatum = Datum FROM inserted;
	SELECT @insertedStattgefunden = Stattgefunden FROM inserted;
	SET @CurrDatum = GETDATE();

	--BEGIN TRY
	IF((@insertedDatum> @CurrDatum) AND (@insertedStattgefunden = 1)) 
	BEGIN
		--END TRY
		--BEGIN CATCH
		SET @Monat = MONTH(@insertedDatum);
		SET @Jahr = YEAR(@insertedDatum);
		SET @Tag = DAY(@insertedDatum);

		SET @msg = FORMATMESSAGE('Kurseinheit kann nicht stattgefunden haben: Das Datum %i-%i-%i liegt in der Zukunft, bitte korrigieren!', @Jahr, @Monat,@Tag);
		THROW 51000, @msg, 1;
			-----------------------------------------
			-- EVENTUELL IN EINER LOG TABELLE (z.B. dbo.KurseinheitMeldungen) zusätzlich Fehlermeldung speichern
			--INSERT INTO dbo.KurseinheitMeldungen (Mode, Meldung)
			--VALUES ('U', @msg);
		--END CATCH
	END
END
GO
