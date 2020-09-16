SELECT BookTitle, FirstName AS Author_First_Name, LastName AS Author_Last_Name  
FROM Books 
JOIN BooksAuthors ON Books.ISBN = BooksAuthors.ISBN
JOIN Authors 
ON BooksAuthors.AuthorID = Authors.AuthorID
Order BY BookTitle;	