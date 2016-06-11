/*
--Add 5 copies of every book to each branch
INSERT INTO Book_Copies (BookId, BranchId, No_Of_Copies) 
SELECT b.BookId , lb.BranchId, 5
FROM Library_Branch lb, Book b
--Optional where clause
--WHERE BookId = 2 AND BranchId = 11000
*/

/*
--Inline If statement for SQL Server 2012 
INSERT INTO Book_Copies (BookId, BranchId, No_Of_Copies) 
SELECT b.BookId , lb.BranchId, iif( b.BookId %2 = 0, 3, 5)
FROM Library_Branch lb, Book b
*/

--Insert 
INSERT INTO Book_Copies (BookId, BranchId, No_Of_Copies) 
SELECT 
b.BookId , lb.BranchId, 
CASE 
	WHEN b.BookId % 5 = 0 THEN 5
	WHEN b.BookId % 3 = 0 then 3
	ELSE 4
END
FROM Library_Branch lb, Book b
--SELECT * FROM Book_Copies

/*
--This subquery query also works but can only return one value
INSERT INTO Book_Copies(BookId, BranchId, No_Of_Copies) 
VALUES 
(
(SELECT BookId FROM Book WHERE BookId = 2),
(SELECT BranchId FROM Library_Branch WHERE BranchId = 11000),
2
)
*/

--Add Book_Loans
INSERT INTO Book_Loans (BookId, BranchId, CardNo, DueDate ) 
SELECT b.BookId , lb.BranchId, bo.CardNo, getdate()
FROM Library_Branch lb, book b, Borrower bo
WHERE BranchId = 11000 
AND bo.CardNo = 1003
AND b.BookId BETWEEN 3 AND 5

INSERT INTO Book_Loans (BookId, BranchId, CardNo, DueDate ) 
SELECT b.BookId , lb.BranchId, bo.CardNo, getdate()+15
FROM Library_Branch lb, book b, Borrower bo
WHERE BranchId = 11000 
AND bo.CardNo = 1004
AND b.BookId BETWEEN 1 AND 3

INSERT INTO Book_Loans (BookId, BranchId, CardNo, DueDate ) 
SELECT b.BookId , lb.BranchId, bo.CardNo, getDate()-5
FROM Library_Branch lb, book b, Borrower bo
WHERE BranchId = 12000 
AND bo.CardNo BETWEEN 1006 AND 1009
AND b.BookId BETWEEN 7 AND 9

INSERT INTO Book_Loans (BookId, BranchId, CardNo, DueDate ) 
SELECT b.BookId , lb.BranchId, bo.CardNo, getDate()+10
FROM Library_Branch lb, book b, Borrower bo
WHERE BranchId = 13000 
AND bo.CardNo BETWEEN 1011 AND 1014
AND b.BookId BETWEEN 15 AND 16

INSERT INTO Book_Loans (BookId, BranchId, CardNo, DueDate ) 
SELECT b.BookId , lb.BranchId, bo.CardNo, getdate()
FROM Library_Branch lb, book b, Borrower bo
WHERE BranchId = 14000 
AND bo.CardNo BETWEEN 1016 AND 1019
AND b.BookId BETWEEN 22 AND 24

INSERT INTO Book_Loans (BookId, BranchId, CardNo, DueDate ) 
SELECT b.BookId , lb.BranchId, bo.CardNo, getdate()
FROM Library_Branch lb, book b, Borrower bo
WHERE BranchId = 11000 
AND bo.CardNo BETWEEN 1023 AND 1025
AND b.BookId BETWEEN 25 AND 27

--2 borrowers have more than 5 loans
INSERT INTO Book_Loans (BookId, BranchId, CardNo, DueDate ) 
SELECT b.BookId , lb.BranchId, bo.CardNo, getDate()+10
FROM Library_Branch lb, book b, Borrower bo
WHERE BranchId = 13000 
AND bo.CardNo = 1001 
AND b.BookId BETWEEN 6 AND 12

--More than 5 loans and due today
INSERT INTO Book_Loans (BookId, BranchId, CardNo, DueDate ) 
SELECT b.BookId , lb.BranchId, bo.CardNo, getdate()
FROM Library_Branch lb, book b, Borrower bo
WHERE BranchId = 13000 
AND bo.CardNo = 1002
AND b.BookId BETWEEN 12 AND 19
