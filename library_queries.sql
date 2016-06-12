-- EXEC spLibQUerySelect 
-- USAGE: EXEC spLipQuerySelect ['1111111']
-- OPtional string argument toggles each of 7 queries. 
-- 0=off, 1=on. No arg passed = all on ('1111111')
-- e.g.: EXEC spLibQUerySelect '0000001' runs only query #7


CREATE PROC spLibQuerySelect
@args nvarchar(7) = '1111111' AS

IF SUBSTRING(@args,1,1) = 1
	BEGIN
		PRINT 'Arg 1'
		--1. How many copies of the book titled The Lost Tribe 
		--are owned by the library branch whose name is "Sharpstown"?
		SELECT bc.No_of_Copies '# Copies', b.Title 'Book Title', lb.BranchName 'Library Branch'
		FROM Library_Branch lb
		INNER JOIN Book_Copies bc ON lb.BranchId = bc.BranchId
		INNER JOIN Book b ON b.BookId = bc.BookId
		WHERE b.Title = 'The Lost Tribe'
		AND lb.BranchName = 'Sharpstown'
	END

IF SUBSTRING(@args,2,1) = 1
	BEGIN
		PRINT 'Arg 2'
		--2. How many copies of the book titled The Lost Tribe 
		--are owned by each library branch?
		SELECT bc.No_of_Copies '# of', b.Title 'This Book', lb.BranchName 'Owned by...'
		FROM Library_Branch lb
		INNER JOIN Book_Copies bc ON lb.BranchId = bc.BranchId
		INNER JOIN Book b ON b.BookId = bc.BookId
		WHERE b.Title = 'The Lost Tribe'
	END

IF SUBSTRING(@args,3,1) = 1
	BEGIN
		PRINT 'Arg 3'
		--3. Retrieve the names of all borrowers who do not have any books checked out.
		SELECT b.CardNo 'Borrowers with',b.Name 'No Checkouts'
		FROM Borrower b
		FULL OUTER JOIN Book_Loans bl 
		ON b.CardNo = bl.CardNo
		WHERE b.CardNo IS NULL OR bl.CardNo IS NULL
	END

IF SUBSTRING(@args,4,1) = 1
	BEGIN
		PRINT 'Arg 4'
		--4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today,
		--retrieve the book title, the borrower's name, and the borrower's address.
		SELECT bk.title 'This book is ', bl.DueDate 'due TODAY', lb.BranchName 'at this Branch', bo.Name 'by this borrower', bo.[Address] 'who lives here.'
		FROM Book bk
		INNER JOIN Book_Loans bl ON bl.BookId = bk.BookId
		INNER JOIN Borrower bo ON bo.CardNo = bl.CardNo
		INNER JOIN Library_Branch lb ON lb.BranchId = bl.BranchId
		where lb.BranchName = 'Sharpstown' 
		AND bl.DueDate = cast (GETDATE() as DATE)
	END

IF SUBSTRING(@args,5,1) = 1
	BEGIN
		PRINT 'Arg 5'
		--5. For each library branch, retrieve the branch name and 
		--the total number of books loaned out from that branch.
		SELECT lb.BranchName 'Branch', count(*) 'Total Books Loaned'
		FROM Library_Branch lb, book_loans bl
		WHERE bl.BranchId = lb.BranchId
		GROUP BY lb.BranchName;
	END
		
IF SUBSTRING(@args,6,1) = 1
	BEGIN
		PRINT 'Arg 6'
		--6. Retrieve the names, addresses, and number of books checked out for 
		--all borrowers who have more than five books checked out.
		SELECT bo.Name Borrower, bo.[Address], count( bo.CardNo ) AS 'Total Books'
		from Book_Loans bl
		INNER JOIN Book bk ON bk.BookId = bl.BookId
		INNER JOIN Borrower bo ON bo.CardNo = bl.CardNo
		GROUP BY bo.Name,bo.CardNo, bo.[Address]
		HAVING count(bo.CardNo) > 5
		ORDER BY 3 DESC
	END

IF SUBSTRING(@args,7,1) = 1
	BEGIN
		PRINT 'Arg 7'
		--7. For each book by "Stephen King", retrieve the title and the number of
		--copies owned by the library branch whose name is "Central"
		SELECT bc.No_Of_Copies '# Copies of', bk.Title 'this book ', ba.AuthorName 'written by', lb.BranchName 'owned by this branch'
		FROM Book_Copies bc
		INNER JOIN Book bk ON bk.BookId = bc.BookId
		INNER JOIN Book_Authors ba ON bk.BookId = ba.BookId
		INNER JOIN Library_Branch lb ON lb.BranchId = bc.BranchId
		WHERE ba.AuthorName = 'Stephen King' AND bc.BranchId = 13000
	END


/*
--TESTING. For each book by "Stephen King", retrieve the title and the number of
--copies owned by ALL library branches
SELECT sum( bc.No_Of_Copies) 'Total Copies of', bk.Title 'this book ', ba.AuthorName 'written by', lb.BranchName 'owned by this branch'
FROM Book_Copies bc
INNER JOIN Book bk ON bk.BookId = bc.BookId
INNER JOIN Book_Authors ba ON bk.BookId = ba.BookId
INNER JOIN Library_Branch lb ON lb.BranchId = bc.BranchId
WHERE ba.AuthorName = 'Stephen King' 
GROUP BY bk.Title, ba.AuthorName, lb.BranchName
*/