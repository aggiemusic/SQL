/* Code to create a function that will format dates to show the day of the week, day, month and year  */
USE [Music's Library Database]
GO
CREATE FUNCTION getFormattedDate
(
@DateValue AS DATETIME
)
RETURNS VARCHAR(MAX)
AS 
BEGIN 
RETURN 
DATENAME(DW, @DateValue) + ','+
DATENAME (DAY, @DateValue)+' '+
DATENAME (MONTH, @DateValue)+','+
DATENAME (YEAR, @DateValue)
END; 
