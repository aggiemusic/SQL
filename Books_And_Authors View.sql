CREATE VIEW Books_And_Authors AS
SELECT BookTitle, BA.AuthorID, FirstName, LastName 
FROM Books AS B JOIN BooksAuthors AS BA 
ON B.ISBN = BA.ISBN
JOIN Authors AS A ON A.AuthorID = BA.AuthorID; 