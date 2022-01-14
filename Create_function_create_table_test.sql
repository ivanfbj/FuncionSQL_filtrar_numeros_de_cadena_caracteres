/*Función encontrada en Stackoverflow
https://stackoverflow.com/questions/16667251/query-to-get-only-numbers-from-a-string
*/

/*Si existe la función se elimina*/
IF OBJECT_ID (N'dbo.udf_GetNumeric', N'FN') IS NOT NULL  
    DROP FUNCTION udf_GetNumeric;  
GO
/*Se crea la función*/
CREATE FUNCTION dbo.udf_GetNumeric
(@strAlphaNumeric VARCHAR(256))
RETURNS VARCHAR(256)
AS
BEGIN
	DECLARE @intAlpha INT
	SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric)
	BEGIN
		WHILE @intAlpha > 0
			BEGIN
			SET @strAlphaNumeric = STUFF(@strAlphaNumeric, @intAlpha, 1, '' )
			SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric )
			END
	END
	RETURN ISNULL(@strAlphaNumeric,0)
END
GO



/*Se crea una tabla de prueba para insertar información*/
IF OBJECT_ID (N'data_test') IS NOT NULL
	DROP TABLE data_test;
GO
CREATE TABLE [dbo].[data_test]
(
  [data] NVARCHAR(100) NOT NULL, 
 );
GO

/*Se inserta información de prueba*/
INSERT INTO data_test([data]) VALUES ('123abc456'),('ABC987%'),('003Preliminary Examination Plan'),('Coordination005  '),('Balance1000sheet'),('+573295826587'),('+57315 987 254 16'),('258-69-87'),('1.269.982.479'),('01/01/2022'),('@258467%&/()');

/*Se consulta la tabla y se utiliza la función*/
SELECT 
	data
,	'Solo_caracteres_numericos'	=	dbo.udf_GetNumeric(data)
FROM
	data_test;

