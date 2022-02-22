# Pewlett Hackard with PostgreSQL and PGAdmin - FRM's Tec Data Bootcamp Challenge #7

## Overview of the Analysis
### Purpose
After helping our good friend Bobby throughout his journey with SQL, specifically with PostgreSQL and PGAdmin, mapping the database using ERD and QuickDBD and employing the queries requested for current employees with retirement options, we'll help Bobby to query again through our database and existing tables to get employees close to retiremente based on their age, the number of positions laid off by these employees and how many current employees could be mentored before thier "the silver tsunami" leaves.

## Results
- Trigger 1
```
SELECT COUNT(ut.emp_no),
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT COUNT (*) FROM retiring_titles
```
![Trigger 1](https://user-images.githubusercontent.com/96660344/155063364-e3d73f26-f7d4-4b6b-bff9-b049d0824cc1.png)

There are in total, 7 positions as a whole that will soon be laid off, the range going from managers to staff.
- Trigger 2
```
SELECT DISTINCT ON (emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT COUNT (*) FROM unique_titles
```
![Trigger 2](https://user-images.githubusercontent.com/96660344/155063137-ab5c5076-ec23-4490-862d-7f05f21bf9cc.png)

A total of 72,458 employees are eligible for retirement.

- Trigger 3
```
SELECT COUNT(ut.emp_no),
	ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

SELECT * FROM retiring_titles
```
![Trigger 3](https://user-images.githubusercontent.com/96660344/155063124-05000877-ea0d-43c9-8461-b5954406d279.png)

From the total of eligible employees for retirment, the outliers are the Mnagers, with only 2 position to be laid off while the mode are the Senior Engineers.

- Trigger 4
```
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_elegibility
FROM employees as e
INNER JOIN deptemp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no ASC;

SELECT COUNT (*) FROM mentorship_elegibility
```
![Trigger 4](https://user-images.githubusercontent.com/96660344/155063119-2b41a005-5062-4175-b4f6-77de84f626b5.png)

There are only 1,549 employees eleigible for mentorship.

## Summary
### How many roles will need to be filled as the "silver tsunami" begins to make an impact?
Concisely, only 7 kind of roles will need to be filled by the HR department after the silver tsunami gets to Pewlett Hackard's coasts. But we are only talking about roles, not all the positions.

### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
No, there are not not enough, and if no actions taken upon such confirmation the silver tsunami will erode mainly technical areas. Taking into consideration that if they accept to, only 1549 employees will remain from the total of 72,458 then we are considering that the remaining workers will mentor 70,909 new workers. Insane, right? The ratio goes from 1 to almost 46. Only if PH turns to a university this could be attainable.

> Additional Query 1
```
SELECT COUNT(me.emp_no),
	me.title
--INTO me_titles
FROM mentorship_elegibility as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;
```
![AQ 1](https://user-images.githubusercontent.com/96660344/155064609-1fb42eea-0d39-4d78-a45e-94849b7aad4e.png)

Only the Manager role has no possible mentors available. Guided from this query, we can determine that despite engineers and technical workers being the one with the highest lay off numbers, they also are the ones with the most mentors.

> Additional Query 2
```
SELECT d.dept_no,
	d.dept_name,
     dm.emp_no
INTO AQ2_1
FROM departments as d
INNER JOIN deptemp AS dm
ON d.dept_no = dm.dept_no
GROUP BY (d.dept_no, d.dept_name, dm.emp_no)
ORDER BY d.dept_no ASC;

SELECT aq.dept_name, me.title, COUNT(me.title)
INTO AQ2_2
FROM aq2_1 as aq
INNER JOIN mentorship_elegibility AS me
ON aq.emp_no = me.emp_no
GROUP BY aq.dept_name, me.title
ORDER BY aq.dept_name ASC;
```

![AQ2 Snapshot](https://user-images.githubusercontent.com/96660344/155068742-555177ac-014d-4b64-ba86-959e3d2839d0.png)

With this query I wanted to get how many possible mentors were from 1) which department and 2) for which role. Despite the tables merging accordingly to my sketch, the ending number surpasses the total of 1,549 possible mentors. If you could help me find the gap in my reasoning I'd appreciate it a lot.
The CSV is on my "Data" folder under the name aq2_2.csv.
