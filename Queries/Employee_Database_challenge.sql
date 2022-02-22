-- FRM's Module 7 - Pewlett Hackard Challenge

-- Deliverable 1: The Number of Retiring Employees by Title
-- Step 1 to 7 
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Step 8 (Use Dictinct with Orderby to remove duplicate rows) to Step 15
SELECT DISTINCT ON (emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

-- Step 16 to Step 22
SELECT COUNT(ut.emp_no),
	ut.title
-- INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

INTO nameyourtable
FROM _______
WHERE _______
ORDER BY _____, _____ DESC;


-- Deliverable 2: The Employees Eligible for the Mentorship Program





-- END OF CHALLENGE 7 CODE
-- Florencio Rustrian Monroy