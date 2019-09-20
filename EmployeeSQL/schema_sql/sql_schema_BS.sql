

'--CONSTRUCT TABLES '

departments
-
dept_no     VARCHAR(4)  NOT NULL
dept_name   VARCHAR(30) NOT NULL
CONSTRAINT "pk_departments" PRIMARY KEY ("dept_no")
--no fk this is the ultra primary 
--------------------------------------------------------

dept_manager
-
dept_no     VARCHAR(4)  NOT NULL
emp_no          INT(6)  NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL
PERIOD FOR  mgr_period( from_date, to_date )
-------OR---------------------------
mgr_period( from_date, to_date ) VARCHAR(30) NOT NULL


CONSTRAINT "dept_manager" PRIMARY KEY ("dept_no", "mgr_period") 
-- if this table is for multiple years you may have a mgr that was mgr of abc dept then tranfered
---to xyz dept then later transfered back to abc dept , you want to accurately depict the time periods they were mgrs per depts 
ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_Emp_Num" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


------------------------------------------------------
dept_emp
-
emp_no          INT(5)  NOT NULL
dept_no     VARCHAR(4)  NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL
emp_dept_period(from_date, to_date )
CONSTRAINT "dept_emp" PRIMARY KEY ("emp_no", "emp_dept_period")

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_Dept_Num"  FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
-----FOREIGN KEY------(  ABOVE OR BELOW? )-----(OR BOTH! U CAN HAVY BOTH FULL LOCK DOWN)------
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_Dept_Num" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");




-------------------------------------------------------
employees
-
emp_no          INT(5)  NOT NULL
birth_date  VARCHAR(10) NOT NULL     
first_name  VARCHAR(30) NOT NULL 
last_name   VARCHAR(30) NOT NULL 
gender      VARCHAR(1)  NOT NULL 
hire_date   VARCHAR(10) NOT NULL

CONSTRAINT "employees" PRIMARY KEY ("emp_no")

'????? is there a FK ?? maybe this is also a primary ????? '
ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_Emp_Num" FOREIGN KEY("??????")
REFERENCES  "??????" ("?????");
-------------------------------------------------------


titles
-
emp_no          INT(5)  NOT NULL
title       VARCHAR(30) NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL

CONSTRAINT titles PRIMARY KEY (title)

ALTER TABLE titles ADD CONSTRAINT "fk_title_Emp_Num" FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);
-------------------------------------------------------


salaries
-
emp_no          INT(5)  NOT NULL
salary          INT(10) NOT NULL
from_date   VARCHAR(10) NOT NULL
to_date     VARCHAR(10) NOT NULL

"??? salaries can't be the primary key  ???"
CONSTRAINT "salaries" PRIMARY KEY ("salary")

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_Emp_Num" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

