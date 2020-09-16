CREATE VIEW Library_Patrons AS 
SELECT CardID, FirstName, LastName, Address, Zip, PhoneNumber, EmailAddress
FROM Patrons;