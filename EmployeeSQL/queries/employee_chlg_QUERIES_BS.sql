
--QUERIES BY BRANDON STEINKE |  9-20-2019

--=======================================================
-- 1. List the following details of each employee: 
----employee number, last name, first name, gender, and salary.
--=======================================================

SELECT *
FROM EMPLOYEES 
LIMIT 2

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary 
FROM employees AS e
INNER JOIN salaries AS s
  ON e.emp_no = s.emp_no
ORDER BY e.emp_no
LIMIT 5

--=======================================================
-- 2. List employees who were hired in 1986.
--========================================================
--300024, TOTAL EMPLOYEES
SELECT COUNT (e.emp_no)
FROM employees AS e

--MOST EMPLOYEES HIRED AFTER THIS DATE 
--264628, EMP HIRED PRIOR TO DATE
SELECT COUNT (e.emp_no)
FROM employees AS e
WHERE hire_date > '1986-01-01'

--35316, EMP HIRED PRIOR TO DATE
SELECT COUNT (e.emp_no)
FROM employees AS e
WHERE hire_date < '1986-01-01'

--FINAL QUERY
SELECT e.emp_no, e.last_name, e.first_name, e.hire_date 
FROM employees AS e
WHERE hire_date > '1986-01-01'
ORDER BY hire_date
LIMIT 50


--==================================================================================
-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
-- last name, first name, and start and end employment dates.
--==================================================================================
SELECT dm.dept_no, ds.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager AS dm
LEFT JOIN departments AS ds
	ON dm.dept_no = ds.dept_no
LEFT JOIN employees AS e 
	ON dm.emp_no = e.emp_no
ORDER BY dm.emp_no
LIMIT 50

---FINDINGS :
----WELL ITS A BIT ODD THAT EVERYTIME A DEPT MANAGER ENDED WITH THAT DEPT 
-----A NEW DEPT MGR WAS ASSIGNED THE NEXT DAY WITH AN EMPLOYEE NUMBER GREATER THAN 
------THAT OF THE PRIOR MGR, PERHAPS SO THE CHRONOLOGY OF DEPT MGR CAN BE EASILY VIEWED.....


--==================================================================================
-- 4. List the department of each employee with the following information: 
--------employee number, last name, first name, and department name.
--==================================================================================
SELECT de.emp_no, e.last_name, e.first_name, ds.dept_name
FROM dept_emp AS de
INNER JOIN employees AS e
	ON de.emp_no = e.emp_no 
INNER JOIN departments AS ds
	ON de.dept_no = ds.dept_no
ORDER BY de.emp_no	
LIMIT 50

--==================================================================================
-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
--==================================================================================
SELECT first_name, last_name
FROM employees 
WHERE first_name = 'Hercules' AND last_name  LIKE 'B%'
ORDER BY last_name
LIMIT 50


--RESULTS : 20 Unique employees match this query
----SORT OF A VERY UNCOMMON FIRST NAME FOR SO MANY EMPLOYEES TO HAVE ??

--==================================================================================
-- 6. List all employees in the ( Sales department ), including their 
--------employee number, last name, first name, and department name.
--==================================================================================
--SELECT COUNT (de.emp_no) --RESULTS : 52245 employees match this query
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM  dept_emp AS de
JOIN  employees AS e 
	ON de.emp_no = e.emp_no 
JOIN  departments AS d
	ON de.dept_no = d.dept_no
WHERE de.dept_no = 'd007'
ORDER BY de.emp_no
--ORDER BY last_name, first_name
LIMIT 50

--==================================================================================
-- 7. List all employees in the (Sales and Development departments ), including their 
-------employee number, last name, first name, and department name.
--==================================================================================
--SELECT COUNT (de.emp_no) --RESULTS :137952 employees match this query
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM  dept_emp AS de
JOIN  employees AS e 
	ON de.emp_no = e.emp_no 
JOIN  departments AS d
	ON de.dept_no = d.dept_no
WHERE de.dept_no = 'd005' OR de.dept_no = 'd007'
ORDER BY de.emp_no
LIMIT 50

--==================================================================================
-- 8. In descending order, list the frequency count of employee last names, 
------i.e., how many employees share each last name.
--==================================================================================

SELECT COUNT(last_name)  AS "NAME_COUNT" , last_name
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;



--==================================================================================
--BONUS  average salary by title.
--==================================================================================

SELECT ROUND(AVG(s.salary),2) AS "Average_Salary", t.title
FROM  salaries AS s 
JOIN titles AS t
	ON s.emp_no = t.emp_no
GROUP BY t.title
ORDER BY "Average_Salary"
---FINDINGS :
-- 	in a typical company we expect to see senior staff and managers making more than junior or regular staff
-- 	here it is opposite or extremely similar? 
-- 	the avg salary of a manager is less than staff
-- 	the avg salary of senior engineer and assistant engineer are almost identical
-- 	with an engineer making more than the senior engineer
-- 	the avg salary of senior staff and staff is almost indentical

























--                                                                                                                                                                                                                                                                                                                                          B R A N D O N   S T E I N K E 























































--                                                                                                                                                                                                                                                                                                                                          B R A N D O N   S T E I N K E 





















