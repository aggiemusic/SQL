CREATE PROCEDURE AllCheckedOutBooks1 AS 
SELECT * FROM BooksOutOnLoan 
WHERE DateCheckedOut IS NOT Null AND DateReturned is NULL; 