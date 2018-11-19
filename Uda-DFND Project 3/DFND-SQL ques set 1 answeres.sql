/*Question 1: Which countries have the most Invoices?

Use the Invoice table to determine the countries that have the most invoices. 
Provide a table of BillingCountry and Invoices ordered by the number of invoices for each country.
The country with the most invoices should appear first.
*/
SELECT  BillingCountry,count(InvoiceId)  FROM Invoice group by BillingCountry order by 2 desc;

/*Question 2: Which city has the best customers?

We would like to throw a promotional Music Festival in the city we made the most money.
Write a query that returns the 1 city that has the highest sum of invoice totals.
Return both the city name and the sum of all invoice totals.
*/
Select i.BillingCity, sum(i.total) 
from Invoice i
group by 1
order by 2 desc
Limit 1;

/*Question 3: Who is the best customer?
The customer who has spent the most money will be declared the best customer.
Build a query that returns the person who has spent the most money.
I found the solution by linking the following three: Invoice, InvoiceLine, and Customer tables to retrieve this information, 
but you can probably do it with fewer!
*/
select i.InvoiceId,  c.FirstName, sum(i.Total), c.CustomerId
from Invoice i
join Customer c
on c.CustomerId = i.CustomerId
group by 4
order by 3 desc;



