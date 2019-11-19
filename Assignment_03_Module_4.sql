--------------------Using Oracle SQL Developer-----------------


---1- List the city, state, and zip codes in the customer table. Your result should not have duplicates.

select distinct c.city, c.state, c.zip from CUSTOMER c;

--2.	List the name, department, phone number, and email address of employees with a phone number beginning with “3-”.

select e.empname,e.department,e.phone,e.email from employee e
where e.phone like '3-%';

--3.	List all columns of the resource table with a rate between $10 and $20. Sort the result by rate.

select * from resourcetbl res where res.rate between 10 AND 20 order by res.rate; 

--4-List the event requests with a status of “Approved” or “Denied” and an authorized date in July 2018.
-- Include the event number, authorization date, and status in the output. (Hint: see the examples in Module 4 for date constants in Oracle and MySQL.)

Select er.eventno, er.dateauth,er.status from Eventrequest er
where (er.status= 'Approved' OR er.status = 'Denied')  
AND er.dateauth BETWEEN '1-Jul-2018' AND '31-Jul-2018' ;

--5-List the location number and name of locations that are part of the “Basketball arena”. 
--Your WHERE clause should not have a condition involving the facility number compared to a constant (“F101”). 
--Instead, you should use a condition on the FacName column for the value of “Basketball arena”.

Select lo.locno,fa.facno ,lo.locname,fa.facname from locations lo, facility fa
where lo.facno = fa.facno AND
fa.facname = 'Basketball arena';



--6-For each event plan, list the plan number, count of the event plan lines, and sum of the number of resources assigned.
-- For example, plan number “P100” has 4 lines and 7 resources assigned. You only need to consider event plans that have at least one line.


SELECT distinct PlanNo, COUNT(*) AS EventPlamLines, SUM(NumberFld) AS SumOfResources
FROM EventPlanLine

GROUP BY PlanNo
HAVING COUNT(*) >=1;

