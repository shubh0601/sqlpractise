#StrataScratch Queries - Easy Category

/*Q1) Salaries Difference: Write a query that calculates the difference between 
the highest salaries found in the marketing and engineering departments. 
Output just the absolute difference in salaries.*/
SELECT DISTINCT((SELECT MAX(salary) 
FROM db_employee e 
JOIN db_dept d 
ON e.department_id = d.id
WHERE department LIKE 'marketing') - (SELECT MAX(salary) 
FROM db_employee e1 
JOIN db_dept d1 
ON e1.department_id = d1.id
WHERE department LIKE 'engineering')) AS difference;

/*Q2) Finding Updated Records: We have a table with employees and their salaries, 
however, some of the records are old and contain outdated salary information. 
Find the current salary of each employee assuming that salaries increase each year. 
Output their id, first name, last name, department ID, and current salary. 
Order your list by employee ID in ascending order.*/
SELECT id, first_name, last_name, MAX(salary), department_id
FROM ms_employee_salary
GROUP BY 1
ORDER BY 1 ASC; 

/*Q3)Bikes Last Used: Find the last time each bike was in use. Output both the bike number and 
the date-timestamp of the bike's last use (i.e., the date-time the bike was returned). 
Order the results by bikes that were most recently used.*/ 
SELECT bike_number, MAX(end_time) AS last_used
FROM dc_bikeshare_q1_2012
GROUP BY 1
ORDER BY 2; 

/*Q4) Reviews of Hotel Arena: Find the number of rows for each review score 
earned by 'Hotel Arena'. Output the hotel name (which should be 'Hotel Arena'), 
review score along with the corresponding number of rows with that score for the specified hotel.*/
SELECT hotel_name, reviewer_score, COUNT(reviewer_score)
FROM hotel_reviews
WHERE hotel_name LIKE "Hotel Arena"
GROUP BY 2; 

/*Q5) Count the number of movies that Abigail Breslin was nominated for an oscar.*/
SELECT COUNT(movie)
FROM oscar_nominees 
WHERE nominee LIKE "Abigail Breslin"; 

/*Q6) Find all posts which were reacted to with a heart. For such posts output all 
columns from facebook_posts table.*/
SELECT DISTINCT p.post_id, p.poster, post_text, post_keywords, post_date
FROM facebook_posts p
JOIN facebook_reactions r
ON p.post_id = r.post_id
WHERE reaction LIKE "heart";

/*Q7) Meta/Facebook has developed a new programing language called Hack.
To measure the popularity of Hack they ran a survey with their employees. 
The survey included data on previous programing familiarity as well as the
number of years of experience, age, gender and most importantly satisfaction 
with Hack. Due to an error location data was not collected, but your supervisor 
demands a report showing average popularity of Hack by office location. Luckily 
the user IDs of employees completing the surveys were stored.
Based on the above, find the average popularity of the Hack per office location.
Output the location along with the average popularity.*/ 
SELECT location, AVG(popularity)
FROM facebook_employees e 
JOIN facebook_hack_survey hs 
ON e.id = hs.employee_id
GROUP BY location; 

/*Q8) Lyft Driver Wages: Find all Lyft drivers who earn either equal to or 
less than 30k USD or equal to or more than 70k USD.
Output all details related to retrieved records.*/ 
SELECT * 
FROM lyft_drivers
WHERE yearly_salary <= 30000 OR yearly_salary >= 70000;

/*Q9) Find how many times each artist appeared on the Spotify ranking list
Output the artist name along with the corresponding number of occurrences.
Order records by the number of occurrences in descending order.*/ 
SELECT artist, COUNT(artist) 
FROM spotify_worldwide_daily_song_ranking
GROUP BY 1
ORDER BY 2 DESC;

/*Q10) Find the base pay for Police Captains.
Output the employee name along with the corresponding base pay.*/ 
SELECT employeename, basepay
FROM sf_public_salaries
WHERE jobtitle LIKE "CAPTAIN III (POLICE DEPARTMENT)";

/*Q11) Find libraries who haven't provided the email address in circulation 
year 2016 but their notice preference definition is set to email.
Output the library code. */
SELECT DISTINCT home_library_code
FROM library_usage
WHERE provided_email_address = FALSE 
AND circulation_active_year = 2016
AND notice_preference_definition = "email";

/*Q12) Average Salaries: Compare each employee's salary with the average salary 
of the corresponding department. Output the department, first name, and salary 
of employees along with the average salary of that department.*/ 
SELECT department, first_name, salary, 
AVG(salary) OVER (PARTITION BY department)
FROM employee; 

/*Q13) Order Details: Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.*/
SELECT first_name, order_date, order_details, total_order_cost
FROM customers c
JOIN orders o 
ON c.id = o.cust_id 
WHERE first_name IN ("Jill", "Eva")
ORDER BY c.id; 

/*Q14) Customer Details: Find the details of each customer regardless of whether the 
customer made an order. Output the customer's first name, last name, and the city 
along with the order details. Sort records based on the customer's first name and 
the order details in ascending order.*/
SELECT first_name, last_name, city, order_details
FROM customers c 
LEFT JOIN orders o 
ON c.id = o.cust_id 
ORDER BY 1, 4 ASC;

/*Q15) Find the number of workers by department who joined in or after April.
Output the department name along with the corresponding number of workers.
Sort records based on the number of workers in descending order.*/ 
SELECT department, COUNT(worker_id)
FROM worker
WHERE MONTH(joining_date) >= 4
GROUP BY 1
ORDER BY 2 DESC; 

/*Q16) Find the number of employees working in the Admin department 
that joined in April or later.*/ 
SELECT COUNT(worker_id)
FROM worker
WHERE MONTH(joining_date) >= 4 
AND department LIKE "Admin"
GROUP BY department; 

/*Q17) Find the activity date and the pe_description of facilities with 
the name 'STREET CHURROS' and with a score of less than 95 points.*/
SELECT activity_date, pe_description
FROM los_angeles_restaurant_health_inspections 
WHERE facility_name LIKE "STREET CHURROS"
AND score < 95; 

/*Q18) Find the most profitable company from the financial sector. 
Output the result along with the continent.*/ 
SELECT company, continent 
FROM forbes_global_2010_2014
WHERE profits = (SELECT MAX(profits) 
FROM forbes_global_2010_2014); 

/*Q19) Count the number of user events performed by MacBookPro users.
Output the result along with the event name.
Sort the result based on the event count in the descending order.*/
SELECT event_name, COUNT(device)
FROM playbook_events
WHERE device LIKE "macbook pro"
GROUP BY 1
ORDER BY 2 DESC; 

/*Q20) Find the average number of bathrooms and bedrooms for each city’s
property types. Output the result along with the city name and the property type.*/
SELECT city, property_type, AVG(bathrooms), AVG(bedrooms)
FROM airbnb_search_details
GROUP BY 1, 2;

/*Q21) You have been asked to find the 5 most lucrative products in terms of 
total revenue for the first half of 2022 (from January to June inclusive).
Output their IDs and the total revenue.*/
SELECT product_id, SUM(cost_in_dollars*units_sold) AS revenue
FROM online_orders
WHERE MONTH(date) >= "January" OR MONTH(date) <= "June"
GROUP BY 1
ORDER BY revenue DESC
LIMIT 5;

/*Q22) Write a query that will calculate the number of shipments per month. 
The unique key for one shipment is a combination of shipment_id and sub_id. 
Output the year_month in format YYYY-MM and the number of shipments in that month.*/
SELECT COUNT(shipment_id), DATE_FORMAT(shipment_date, '%Y-%m')  date_ym
FROM amazon_shipment
GROUP BY date_ym;

/*Q23 Write a query that returns the number of unique users per client per month*/
SELECT client_id, MONTH(time_id), COUNT(DISTINCT user_id)
FROM fact_events
GROUP BY 1, MONTH(time_id); 


