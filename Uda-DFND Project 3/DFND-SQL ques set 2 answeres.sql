/*Question 1
Use your query to return the email, first name, last name, and Genre of all Rock Music listeners.
Return your list ordered alphabetically by email address starting with A.
Can you find a way to deal with duplicate email addresses so no one receives multiple emails?
I chose to link information from the Customer, Invoice, InvoiceLine, Track, and Genre tables, but you may be able to find another way to get at the information.
*/
SELECT DISTINCT Email, FirstName, LastName, Genre.Name
FROM Customer
JOIN Invoice
ON Customer.CustomerId = Invoice.CustomerId
JOIN InvoiceLine
ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Track
ON Track.TrackId = InvoiceLine.TrackId
JOIN Genre
ON Genre.GenreId = Track.GenreId
WHERE Genre.Name = 'Rock'
ORDER BY Email

SELECT DISTINCT
  c.Email,
  c.FirstName,
  c.LastName,
  g.Name
FROM Customer c
JOIN Invoice i
  ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il
  ON i.InvoiceId = il.InvoiceId
JOIN Track t
  ON il.TrackId = t.TrackId
JOIN Genre g
  ON t.GenreId = g.GenreId
WHERE g.Name = 'Rock'
ORDER BY 2 ASC;


/*Question 2: Who is writing the rock music?
Now that we know that our customers love rock music, we can decide which musicians to invite to play at the concert.
Let's invite the artists who have written the most rock music in our dataset.
Write a query that returns the Artist name and total track count of the top 10 rock bands.
You will need to use the Genre, Track , Album, and Artist tables.
*/

SELECT
  Artist.ArtistId,
  Artist.Name,
  COUNT(TrackId)
FROM Artist
JOIN Album
  ON Artist.ArtistId = Album.ArtistId
JOIN Track
  ON Album.AlbumId = Track.AlbumId
JOIN Genre
  ON Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Rock'
GROUP BY 1,
         2
ORDER BY 3 DESC
LIMIT 10;


/*Question 3
First, find which artist has earned the most according to the InvoiceLines?
Now use this artist to find which customer spent the most on this artist.
For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, Album, and Artist tables.
Notice, this one is tricky because the Total spent in the Invoice table might not be on a single product,
so you need to use the InvoiceLine table to find out how many of each product was purchased, and then multiply this by the price for each artist.
*/
SELECT
  Artist.Name AS ArtName,
  COUNT(Track.AlbumId) * Track.UnitPrice AS AmountSpent,
  Invoice.CustomerId,
  Customer.FirstName,
  Customer.LastName
FROM InvoiceLine
JOIN Track
  ON InvoiceLine.TrackId = Track.TrackId
JOIN Album
  ON Track.AlbumId = Album.AlbumId
JOIN Artist
  ON Album.ArtistId = Artist.ArtistId
JOIN Invoice
  ON InvoiceLine.InvoiceId = Invoice.InvoiceId
JOIN Customer
  ON Invoice.CustomerId = Customer.CustomerId
JOIN Genre
  ON Track.GenreId = Genre.GenreId
WHERE Artist.Name = 'Iron Maiden'
GROUP BY 3
ORDER BY 2 DESC;
