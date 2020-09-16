CREATE VIEW Loaned_Books AS 
SELECT ISBN, CardID, DateCheckedOut, DateReturned
FROM BooksOutOnLoan;