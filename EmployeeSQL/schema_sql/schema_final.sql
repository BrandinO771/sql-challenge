
--CREATE BY BRANDON STEINKE | POSTGRES |  9-20-2019

CREATE TABLE departments
(
dept_no     VARCHAR(4)  UNIQUE NOT NULL,
dept_name   VARCHAR(30) NOT NULL,
CONSTRAINT "pk_departments" PRIMARY KEY (dept_no)
);

--drop table employees
CREATE TABLE employees
(
emp_no          INT 	UNIQUE NOT NULL,
birth_date  VARCHAR(10) NOT NULL,     
first_name  VARCHAR(30) NOT NULL, 
last_name   VARCHAR(30) NOT NULL, 
gender      VARCHAR(1)  NOT NULL, 
hire_date   VARCHAR(10) NOT NULL,
CONSTRAINT "pk_employees" PRIMARY KEY (emp_no, first_name, last_name, hire_date )
);

--drop table dept_manager
CREATE TABLE dept_manager
(
dept_no     VARCHAR(4)  NOT NULL,
emp_no          INT 	NOT NULL, 
from_date   VARCHAR(10) NOT NULL,
to_date     VARCHAR(10) NOT NULL,
CONSTRAINT "pk_dept_manager"        PRIMARY KEY(emp_no, dept_no, from_date, to_date ), 
CONSTRAINT "fk_dept_mgr_Emp_Num"    FOREIGN KEY(emp_no)  REFERENCES  employees(emp_no),
CONSTRAINT "fk_dept_mgr_Dept_Num"   FOREIGN KEY(dept_no) REFERENCES  departments(dept_no)
);

--drop table dept_emp
CREATE TABLE dept_emp
(
emp_no          INT 	NOT NULL, 
dept_no     VARCHAR(4)  NOT NULL,
from_date   VARCHAR(10) NOT NULL,
to_date     VARCHAR(10) NOT NULL,
CONSTRAINT "pk_dept_emp"         PRIMARY KEY(emp_no, dept_no,  from_date, to_date ), 
CONSTRAINT "fk_dept_emp_Emp_Num" FOREIGN KEY(emp_no) REFERENCES  employees(emp_no)
);

--drop table titles
CREATE TABLE titles
(
emp_no         INT  	NOT NULL,
title       VARCHAR(30) NOT NULL,
from_date   VARCHAR(10) NOT NULL,
to_date     VARCHAR(10) NOT NULL,
CONSTRAINT "pk_titles"          PRIMARY KEY( emp_no, title, from_date, to_date ), 
CONSTRAINT "fk_title_Emp_Num"   FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

select * from titles
limit 5

--drop table salaries 
CREATE TABLE salaries
(
emp_no          INT 	NOT NULL, 
salary          INT		NOT NULL,
from_date   VARCHAR(10) NOT NULL,
to_date     VARCHAR(10) NOT NULL,
CONSTRAINT "pk_salaries" PRIMARY KEY(emp_no, salary,  from_date, to_date ), 
CONSTRAINT "fk_salaries" FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);



--                                                                                                                                                                                                                                                                                                                                          B R A N D O N   S T E I N K E 



















































































































--                                                                                                                                                                                                                                                                                                                                          B R A N D O N   S T E I N K E 





























