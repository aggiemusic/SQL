SELECT Patrons.FirstName, Patrons.LastName, BooksOutOnLoan.ISBN, BooksOutOnLoan.DateCheckedOut,
 DATEADD (day,30,DateCheckedOut) AS DueDate
FROM Patrons JOIN BooksOutOnLoan ON Patrons.CardID=BooksOutOnLoan.CardID; 