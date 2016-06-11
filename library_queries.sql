--1. How many copies of the book titled The Lost Tribe 
--are owned by the library branch whose name
--is "Sharpstown"?
SELECT bc.No_of_Copies '# Copies', b.Title 'Book Title', lb.BranchName 'Library Branch'
FROM Library_Branch lb
INNER JOIN Book_Copies bc ON lb.BranchId = bc.BranchId
INNER JOIN Book b ON b.BookId = bc.BookId
WHERE b.Title = 'The Lost Tribe'
AND lb.BranchName = 'Sharpstown'

--2. How many copies of the book titled The Lost Tribe 
--are owned by each library branch?
SELECT bc.No_of_Copies '# of', b.Title 'This Book', lb.BranchName 'Owned by...'
FROM Library_Branch lb
INNER JOIN Book_Copies bc ON lb.BranchId = bc.BranchId
INNER JOIN Book b ON b.BookId = bc.BookId
WHERE b.Title = 'The Lost Tribe'

--3. Retrieve the names of all borrowers who do not have any books checked out.
SELECT b.CardNo 'Borrowers with',b.Name 'No Checkouts'
FROM Borrower b
FULL OUTER JOIN Book_Loans bl 
ON b.CardNo = bl.CardNo
WHERE b.CardNo IS NULL OR bl.CardNo IS NULL

--4. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today,
--retrieve the book title, the borrower's name, and the borrower's address.
SELECT lb.BranchName 'Branch', bl.DueDate 'Due TODAY', bk.title 'Book Title', bo.Name 'Borrower Name', bo.[Address] 'Borrower Address'
FROM Book bk
INNER JOIN Book_Loans bl ON bl.BookId = bk.BookId
INNER JOIN Borrower bo ON bo.CardNo = bl.CardNo
INNER JOIN Library_Branch lb ON lb.BranchId = bl.BranchId
where lb.BranchName = 'Sharpstown' 
AND bl.DueDate = cast (GETDATE() as DATE)

--5. For each library branch, retrieve the branch name and 
--the total number of books loaned out from that branch.
SELECT lb.BranchName 'Branch', count(*) 'Total Books Loaned'
FROM Library_Branch lb, book_loans bl
WHERE bl.BranchId = lb.BranchId
GROUP BY lb.BranchName;

--6. Retrieve the names, addresses, and number of books checked out for 
--all borrowers who have more than five books checked out.
SELECT bo.Name Borrower, bo.[Address], count( bo.CardNo ) AS 'Total Books'
from Book_Loans bl
INNER JOIN Book bk ON bk.BookId = bl.BookId
INNER JOIN Borrower bo ON bo.CardNo = bl.CardNo
GROUP BY bo.Name,bo.CardNo, bo.[Address]
HAVING count(bo.CardNo) > 5
ORDER BY 3 DESC

--7. For each book by "Stephen King", retrieve the title and the number of
--copies owned by the library branch whose name is "Central"

