use publications;

select * from authors;
select * from titles;
select * from sales;
select * from titleauthor;
select * from publishers;
-- challenge 1

-- step 1

select ta.au_id,ta.title_id,sum(titles.advance * ta.royaltyper / 100) as advance,sum(titles.price * sales.qty * titles.royalty / 100 * ta.royaltyper / 100) 
as sales_royalty from titles, sales,titleauthor ta group by ta.au_id,ta.title_id ;

-- step 2

select au_id, title_id, sum(advance) as total_advance, sum(sales_royalty) as total_sales
from (select ta.au_id,ta.title_id,round(titles.advance * ta.royaltyper / 100) as advance,sum(titles.price * sales.qty * titles.royalty / 100 * ta.royaltyper / 100) 
as sales_royalty from titles, sales,titleauthor ta) sub_1
group by au_id, title_id;

-- step 3

select au_id , (total_advance + total_sales) as profits from (select au_id, title_id, sum(advance) as total_advance, sum(sales_royalty) as total_sales
from (select ta.au_id,ta.title_id,round(titles.advance * ta.royaltyper / 100) as advance,round(titles.price * sales.qty * titles.royalty / 100 * ta.royaltyper / 100) 
as sales_royalty from titles, sales,titleauthor ta) sub_1
group by au_id, title_id) sub_2 ;


-- Challenge 2 
-- Derived tables :

select * from (select au_id , (total_advance + total_sales) as profits from (select au_id, title_id, sum(advance) as total_advance, sum(sales_royalty) as total_sales
from (select ta.au_id,ta.title_id,round(titles.advance * ta.royaltyper / 100) as advance,round(titles.price * sales.qty * titles.royalty / 100 * ta.royaltyper / 100) 
as sales_royalty from titles, sales,titleauthor ta) sub_1
group by au_id, title_id) sub_2 ) derived_table;

create temporary table profits_table
select au_id , (total_advance + total_sales) as profits from (select au_id, title_id, sum(advance) as total_advance, sum(sales_royalty) as total_sales
from (select ta.au_id,ta.title_id,round(titles.advance * ta.royaltyper / 100) as advance,round(titles.price * sales.qty * titles.royalty / 100 * ta.royaltyper / 100) 
as sales_royalty from titles, sales,titleauthor ta) sub_1
group by au_id, title_id) sub_2;

select * from profits_table;


-- Challenge 3 
create table most_profiting_authors as select * from profits_table;

select * from most_profiting_authors 
order by profits desc 
limit 3;



-- challenge 1 
select ta.title_id, ta.au_id from titleauthor as ta;

select titleauthor.au_id,titleauthor.title_id, sum(titles.advance * titleauthor.royaltyper / 100) as total_advance
from titles 
inner join titleauthor
on titles.title_id = titleauthor.title_id
group by titleauthor.au_id,titleauthor.title_id;

select titleauthor.au_id,titleauthor.title_id, sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)
as sales_royalty
from titles 
join sales
on titles.title_id = sales.title_id
join titleauthor
on titleauthor.title_id = sales.title_id
group by titleauthor.au_id,titleauthor.title_id;



