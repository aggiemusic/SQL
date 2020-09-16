Select BookTitle, CategoryName 
FROM Books
JOIN BooksCategories ON Books.ISBN = BooksCategories.ISBN
JOIN Categories
ON BooksCategories.CategoryID = Categories.CategoryID
Order By BookTitle;

