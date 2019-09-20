
reference this doc for contraint examples :
https://www.postgresql.org/docs/9.2/ddl-constraints.html

a) in this hw exercise are we verifying all tables are populated accurately by referencing similar values in other tables via foreign keys? 
b) could we also use references to populate some of the tables already provided by linking variable references from a new child table  to variables of other existing parent tables 

1.) when a foreign key is the  primary key of another table, do we reference the primary key constraint name or primary keys assigned variables?

2.) can a foreign key for table 2 reference a composite primary key in table 1 PK_Composite(emp_no, st_date) where 
    table 2 only contains one portion of the table 1 composite primary key  such as emp_no? 

    meanining how is the foreign key matching the employee number of a dept when it is trying to be mapped to a employee number and start date ? 
    is the foreign key matching the employee number then just checking to see if a value is present for the start date?

===================================================

table_1 : 
emp_no
start_date
CONSTRAINT 'PK_Emp' PRIMARY KEY(emp_no, start_date)

===================================================

table_2 :  
emp_no
dept_no
--primary--
CONSTRAINT 'PK_emp_dept_No' PRIMARY KEY(emp_no, dept_no)
--foreign---
CONSTRAINT 'FK_table_2'    FOREIGN KEY'PK_Emp' REFERENCES table_1(emp_no)
----OR-----
CONSTRAINT 'FK_table_2'    FOREIGN KEY'PK_Emp' REFERENCES table_1('PK_Emp')

==================================================
VERSION 2 
==================================================

'--CONSTRUCT TABLES '

departments
-
dept_no     VARCHAR(4)  UNIQUE NOT NULL,
dept_name   VARCHAR(30) NOT NULL
CONSTRAINT 'pk_departments' PRIMARY KEY (dept_no)


--------------------------------------------------------

dept_manager
-
dept_no     VARCHAR(4)  NOT NULL
emp_no          INT(6)  NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL
mgr_period( from_date, to_date WITHOUT OVERLAPS) VARCHAR(30) NOT NULL
CONSTRAINT 'pk_dept_manager'        PRIMARY KEY(emp_no, dept_no, mgr_period) 
CONSTRAINT 'fk_dept_mgr_Emp_Num'    FOREIGN KEY(emp_no)  REFERENCES  employees(emp_no);
CONSTRAINT 'fk_dept_mgr_Dept_Num'   FOREIGN KEY(dept_no) REFERENCES  departments(dept_no);

---OR AFTER TABLE CREATED ------
-- ALTER TABLE dept_manager ADD CONSTRAINT 'fk_dept_mgr_Emp_Num'   FOREIGN KEY(emp_no) 
-- REFERENCES  employees(emp_no);
-- ALTER TABLE dept_manager ADD CONSTRAINT 'fk_dept_mgr_Dept_Num'  FOREIGN KEY(dept_no) 
-- REFERENCES  departments(dept_no);
 
------------------------------------------------------
dept_emp
-
emp_no          INT(5)  NOT NULL
dept_no     VARCHAR(4)  NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL
emp_dept_period(from_date, to_date WITHOUT OVERLAPS) VARCHAR(30) NOT NULL
CONSTRAINT 'pk_dept_emp'         PRIMARY KEY(emp_no, dept_no, emp_dept_period)
CONSTRAINT 'fk_dept_emp_Emp_Num' FOREIGN KEY(emp_no) REFERENCES  employees(emp_no);

-- ALTER TABLE dept_emp ADD CONSTRAINT 'fk_dept_emp_Emp_Num'   FOREIGN KEY(emp_no) 
-- REFERENCES  employees(emp_no);
-- ALTER TABLE dept_emp ADD CONSTRAINT 'fk_dept_emp_Dept_Num'  FOREIGN KEY(dept_no) 
-- REFERENCES  departments(dept_no);



-------------------------------------------------------
employees
-
emp_no          INT(5)  UNIQUE NOT NULL,
birth_date  VARCHAR(10) NOT NULL     
first_name  VARCHAR(30) NOT NULL 
last_name   VARCHAR(30) NOT NULL 
gender      VARCHAR(1)  NOT NULL 
hire_date   VARCHAR(10) NOT NULL
CONSTRAINT 'pk_employees' PRIMARY KEY (emp_no, first_name, last_name, hire_date )

--ALTER TABLE employees ADD CONSTRAINT 'fk_employees_Emp_Num' FOREIGN KEY(??????)
--REFERENCES  ?????? (?????);
-------------------------------------------------------

titles
-
emp_no          INT(5)  NOT NULL
title       VARCHAR(30) NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL
title_per(from_date, to_date WITHOUT OVERLAPS) VARCHAR(30) NOT NULL
CONSTRAINT 'pk_titles'          PRIMARY KEY( emp_no, title, title_per)
CONSTRAINT 'fk_title_Emp_Num'   FOREIGN KEY(emp_no) REFERENCES employees(emp_no);
----OR DO IT AFTER----------
-- ALTER TABLE titles ADD CONSTRAINT 'fk_title_Emp_Num' FOREIGN KEY(emp_no)
-- REFERENCES employees(emp_no);
-------------------------------------------------------

salaries
-
emp_no          INT(5)  NOT NULL --not unique could have many diff salaries for same employee over sev periods
salary          INT(10) NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL
emp_sal_period(from_date, to_date WITHOUT OVERLAPS) VARCHAR(30) NOT NULL
CONSTRAINT 'pk_salaries' PRIMARY KEY(emp_no, salary, emp_sal_period )
CONSTRAINT 'fk_salaries' FOREIGN KEY(emp_no) REFERENCES employees(emp_no);

----OR DO IT AFTER----------
-- ALTER TABLE salaries ADD CONSTRAINT 'fk_salaries' FOREIGN KEY(emp_no) 
-- REFERENCES employees(emp_no);

















=======================================
VERS 1 
=======================================
'--CONSTRUCT TABLES '

departments
-
dept_no     VARCHAR(4)  UNIQUE NOT NULL,
dept_name   VARCHAR(30) NOT NULL
CONSTRAINT 'pk_departments' PRIMARY KEY (dept_no, dept_name)

'!-! NO FOREIGN KEY !-!'

--------------------------------------------------------

dept_manager
-
dept_no     VARCHAR(4)  NOT NULL
emp_no          INT(6)  NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL

PERIOD FOR  mgr_period( from_date, to_date )
-------OR---------------------------
mgr_period( from_date, to_date WITHOUT OVERLAPS) VARCHAR(30) NOT NULL
---keys---below--------------------

CONSTRAINT 'pk_dept_manager' PRIMARY KEY (dept_no, mgr_period) 
-- if this table is for multiple years you may have a mgr that was mgr of abc dept then tranfered
---to xyz dept then later transfered back to abc dept , you want to accurately depict the time periods they were mgrs per depts 
ALTER TABLE dept_manager ADD CONSTRAINT 'fk_dept_mgr_Emp_Num'   FOREIGN KEY(emp_no) 
REFERENCES  employees(emp_no);
ALTER TABLE dept_manager ADD CONSTRAINT 'fk_dept_mgr_Dept_Num'  FOREIGN KEY(dept_no) 
REFERENCES  departments(dept_no);
--ALTER TABLE dept_manager ADD CONSTRAINT 'fk_dept_manager_Emp_Num' FOREIGN KEY(emp_no)
--REFERENCES employees(emp_no);

------------------------------------------------------
dept_emp
-
emp_no          INT(5)  NOT NULL
dept_no     VARCHAR(4)  NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL
emp_dept_period(from_date, to_date WITHOUT OVERLAPS) VARCHAR(30) NOT NULL
CONSTRAINT 'pk_dept_emp' PRIMARY KEY (emp_no, emp_dept_period)

ALTER TABLE dept_emp ADD CONSTRAINT 'fk_dept_emp_Emp_Num'   FOREIGN KEY(emp_no) 
REFERENCES  employees(emp_no);
ALTER TABLE dept_emp ADD CONSTRAINT 'fk_dept_emp_Dept_Num'  FOREIGN KEY(dept_no) 
REFERENCES  departments(dept_no);

-- ALTER TABLE dept_emp ADD CONSTRAINT 'fk_dept_emp_Dept_Num'  FOREIGN KEY('pk_employees')
-- REFERENCES employees('pk_employees');
-- -----FOREIGN KEY------(  ABOVE OR BELOW? )-----(OR BOTH! U CAN HAVY BOTH FULL LOCK DOWN)------
-- ALTER TABLE dept_emp ADD CONSTRAINT 'fk_dept_emp_Dept_Num' FOREIGN KEY('pk_departments')
-- REFERENCES departments('pk_departments');

-------------------------------------------------------
employees
-
emp_no          INT(5)  UNIQUE NOT NULL,
birth_date  VARCHAR(10) NOT NULL     
first_name  VARCHAR(30) NOT NULL 
last_name   VARCHAR(30) NOT NULL 
gender      VARCHAR(1)  NOT NULL 
hire_date   VARCHAR(10) NOT NULL

'?? is below overkill since I have a contraint on Unique emp num ??'
CONSTRAINT 'pk_employees' PRIMARY KEY (emp_no, birth_date)
---OR---
CONSTRAINT 'pk_employees' PRIMARY KEY (emp_no)

'!-! NO FOREIGN KEY !-!'
'????? is there a FK ?? maybe this is also a primary ????? '
--ALTER TABLE employees ADD CONSTRAINT 'fk_employees_Emp_Num' FOREIGN KEY(??????)
--REFERENCES  ?????? (?????);
-------------------------------------------------------

titles
-
emp_no          INT(5)  NOT NULL
title       VARCHAR(30) NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL

CONSTRAINT 'pk_titles' PRIMARY KEY (title)

ALTER TABLE titles ADD CONSTRAINT 'fk_title_Emp_Num' FOREIGN KEY(emp_no)
REFERENCES employees(emp_no);
-------------------------------------------------------

salaries
-
emp_no          INT(5)  NOT NULL --not unique could have many diff salaries for same employee over sev periods
salary          INT(10) NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL
emp_sal_period(from_date, to_date WITHOUT OVERLAPS) VARCHAR(30) NOT NULL

CONSTRAINT 'pk_salaries' PRIMARY KEY (emp_no, emp_sal_period )

ALTER TABLE salaries ADD CONSTRAINT 'fk_salaries' FOREIGN KEY(emp_no) 
REFERENCES employees(emp_no);


