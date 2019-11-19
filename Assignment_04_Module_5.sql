                                  --SELECT Statement Problems--
                                  
--1-For event requests, list the event number, event date ( eventrequest.dateheld ), and count of the event plans. 
--Only include event requests in the result if the event request has more than one related event plan with a work date in December 2018.

select er.eventno, er.dateheld, count(ep.planno) AS NUM_EVENT_PLANS
from eventrequest  er, eventplan ep
Where er.eventno = ep.eventno 
AND (er.dateheld BETWEEN '1-Dec-2018' AND '31-Dec-2018')
Group By er.eventno,er.dateheld
Having count(ep.planno) > 1 ;


--2-List the plan number, event number, work date, and activity of event plans meeting the following two conditions:
-- (1) the work date is in December 2018 and (2) the event is held in the “Basketball arena”.
-- Your query must not use the facility number (“F101”) of the basketball arena in the WHERE clause.
-- Instead, you should use a condition on the FacName column for the value of “Basketball arena”.

Select ep.planno, ep.eventno,ep.workdate, ep.activity
from eventplan ep, facility fc, eventrequest er
where ep.eventno = er.eventno AND 
fc.facno = er.facno AND
fc.facname = 'Basketball arena' AND
(ep.workdate between '1-Dec-2018' AND '31-Dec-2018');


--3-List the event number, event date, status, and estimated cost of events where there is an event plan managed by Mary Manager
-- and the event is held in the basketball arena in the period October 1 to December 31, 2018.
--  Your query must not use the facility number (“F101”) of the basketball arena or the employee number (“E101”) of “Mary Manager” in the WHERE clause.
-- Thus, the WHERE clause should not have conditions involving the facility number or employee number compared to constant values.


Select er.eventno,er.dateheld,er.status, er.estcost
from eventrequest er, employee em, eventplan ep, facility fc
where fc.facno = er.facno AND
em.empno = ep.empno AND
er.eventno = ep.eventno AND 
em.empname = 'Mary Manager' AND 
fc.facname = 'Basketball arena' AND
(er.dateheld between '1-Oct-2018' AND '31-Dec-2018') ;

--4-List the plan number, line number, resource name, number of resources (eventplanline.number), 
--location name, time start, and time end where the event is held at the basketball arena, 
--the event plan has activity of activity of “Operation”, and the event plan has a work date
-- in the period October 1 to December 31, 2018.  Your query must not use the facility number (“F101”)
-- of the basketball arena in the WHERE clause. Instead, you should use a condition on the FacName column for the value of “Basketball arena”.


Select epl.planno, epl.lineno, res.resname, epl.numberfld, loc.locname, epl.timestart, epl.timeend
From eventplanline epl, resourcetbl res, locations loc, facility fc, eventplan ep
where  ep.planno = epl.planno AND
res.resno = epl.resno AND
loc.locno = epl.locno AND
fc.facno = loc.facno AND
fc.facname = 'Basketball arena' AND
ep.activity = 'Operation' AND
(ep.workdate between '1-Oct-2018' AND '31-Dec-2018');
-----------=========================================================================================================================================
                                                                 --Database Modification Problems--
                                                               
--1- Insert a new row into the Facility table with facility name “Swimming Pool”.                                                       

Insert into facility(FacNo, FacName) values('F104','Swimming Pool');
select * from facility;

--2-Insert a new row in the Location table related to the Facility row in modification problem 1. The new row should have “Door” for the location name.

Insert Into locations values('L107','F104','Door');

Select * from locations;

--3-Insert a new row in the Location table related to the Facility row in modification problem 1. The new row should have “Locker Room” for the location name.

Insert Into locations values('L108','F104','Locker Room');
Select * from locations;

--4-Change the location name of “Door” to “Gate” for the row inserted in modification problem 2.

Update locations 
set locations.locname ='Gate' 
Where locations.locname = 'Door';

Select * from locations;

--5-Delete the row inserted in modification problem 3.

Delete from locations
where locations.locno ='L107'

Select * from locations;


--=====================================================================================================================================================

--1- Identify errors in the following Oracle SQL statement and label errors with error type (syntax, redundancy, or semantic). To simplify your work, the statement has only one type of error. Rewrite the statement to remove the error.

SELECT eventrequest.eventno, dateheld, status, estcost

FROM eventrequest, employee, facility, eventplan

WHERE estaudience > 5000

AND eventplan.empno = employee.empno

AND eventrequest.facno = facility.facno

AND eventrequest.eventno = eventplan.eventno   --(semantic error for join condition)

AND facname = 'Football stadium'

AND empname = 'Mary Manager';

--2. Identify errors in the following Oracle SQL statement and label errors with error type (syntax, redundancy, or semantic). To simplify your work, the statement has only one type of error. Rewrite the statement to remove the error.

SELECT DISTINCT eventrequest.eventno, dateheld, status, estcost

FROM eventrequest, eventplan

WHERE estaudience > 4000

AND eventplan.eventno = eventrequest.eventno;

--GROUP BY eventrequest.eventno, dateheld, status, estcost;  --(redundancy for extra group by clause)

--3. Identify errors in the following Oracle SQL statement and label errors with error type (syntax, redundancy, or semantic). To simplify your work, the statement has only one type of error. Rewrite the statement to remove the error.

SELECT DISTINCT eventrequest.eventno, eventrequest.dateheld, eventrequest.status, eventrequest.estcost

FROM eventrequest,facility
--, employee, eventplan               (redundancy error for extra table joins)

WHERE eventrequest.estaudience > 5000
AND eventrequest.facno = facility.facno
AND facname = 'Football stadium';
--AND eventplan.empno = employee.empno  
--AND eventplan.eventno = eventrequest.eventno


--4. Identify errors in the following Oracle SQL statement and label errors with error type (syntax, redundancy, or semantic). To simplify your work, the statement has only one type of error. Rewrite the statement to remove the error.

SELECT DISTINCT eventrequest.eventno, dateheld, status, estcost  --syntax for eventno as ambigous column

FROM eventrequest, employee, eventplan

WHERE estaudience BETWEEN 5000 AND 10000  --(Syntax for BETWEN)

AND eventplan.empno = employee.empno

AND eventrequest.eventno = eventplan.eventno

AND empname = 'Mary Manager';


--5. Identify areas in which the SQL statement has poor coding practices and rewrite the statement to improve the coding practices. You do not need to search for errors.


SELECT eventplan.planno, lineno, resname,numberfld, timestart, timeend  --rearranged code 
FROM eventrequest, facility, eventplan,eventplanline, resourcetbl
WHERE eventplan.planno = eventplanline.planno
AND eventrequest.facno = facility.facno
AND eventplanline.resno = resourcetbl.resno
AND eventrequest.eventno = eventplan.eventno
AND facname = 'Basketball arena'
AND estaudience = '10000';






