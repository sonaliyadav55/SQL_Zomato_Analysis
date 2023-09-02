

use zomato


#1. Find customers who have never ordered

select * from users
where user_id not in (select user_id from orders);




#2. What is the Average Price/dish?

select menu.f_id,f_name,avg(price) from menu
inner join food on menu.f_id = food.f_id
group by menu.f_id;



#3. Find the top restaurant in terms of the number of orders in june month.

select * from restaurants;
select * from orders;

select r.r_id,r_name,count(order_id) as no_of_orders from restaurants as r
inner join orders as o on r.r_id = o.r_id
where date between '2022-06-01' and '2022-06-30'
group by r.r_id
order by no_of_orders desc
limit 1;



#4. Find the name of restaurants with monthly sales greater than 3000.
 select * from restaurants;
 select * from orders;
 
 select month(date) as months ,o.r_id,r_name ,sum(amount) as monthly_sales from orders o
 inner join restaurants res on o.r_id = res.r_id
 group by o.r_id
 having monthly_sales > 3000;
 
 
 
 #5. Show all orders with order details for a particular customer in a particular date range
 
 select * from orders;
 select * from order_details;
 
 select user_id,o.r_id,amount,date,r_name,f_name,type from orders o
 inner join restaurants r on o.r_id = r.r_id
 inner join order_details od on od.order_id = o.order_id
 inner join food f on f.f_id = od.f_id
 where user_id in (select user_id from users where name like 'ankit') and date between
 '2022-01-01' and '2022-12-30'; 
 
 
 
 #6. Find restaurants with max repeated customers 
 
 select r.r_id,count(o.user_id) repeated_customers ,r_name,name from restaurants r
 inner join orders o on o.r_id = r.r_id
 inner join users u on u.user_id = o.user_id
 group by r_id,u.user_id
 order by repeated_customers desc ;
 
 
 
 #7. Month over month revenue growth of swiggy
 

 
select months,((revenue-prev)/prev)*100 from
(
    WITH sales as
		(
			  select month(date) as months,sum(amount) as revenue
			  from orders
			  group by months
			  order by months
		)
select months,revenue,LAG(revenue,1) over(order by revenue) as prev from sales) t;



#8. What is the Customers - favorite food?


select user_id,count(o.order_id),f.f_id,f_name from orders as o
inner join order_details as od on o.order_id = od.order_id
inner join food as f on od.f_id = f.f_id
group by user_id;

 
 







