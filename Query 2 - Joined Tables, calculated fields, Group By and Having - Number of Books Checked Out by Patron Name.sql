SELECT Patrons.LastName, COUNT(BooksOutOnLoan.CardID) As NumberOfBooksCheckedOut 
FROM Patrons JOIN BooksOutOnLoan ON Patrons.CardID=BooksOutOnLoan.CardID
GROUP BY LastName
HAVING COUNT(BooksOutOnLoan.CardID)>0
ORDER BY LastName ASC; 