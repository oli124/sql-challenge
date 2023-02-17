departments
-------
department_no VARCHAR(255) PK FK -< department_employees.department_no
department_name VARCHAR(255)

department_employees
-------
employee_no INT PK
department_no VARCHAR(255) PK

department_manager
-------
department_no VARCHAR(255) PK FK >- departments.department_no
employee_no INT PK FK >- employees.employee_no
# department_no VARCHAR(255) PK - departments.department_no
# employee_no INT PK >- employees.employee_no

employees
-------
employee_no INT PK FK -< department_employees.employee_no
employee_title_id VARCHAR(255)
birth_date DATE
first_name VARCHAR(255)
last_name VARCHAR(255)
sex VARCHAR(255)
hire_date DATE

salaries
-------
employee_no INT PK FK - employees.employee_no
salary INT

titles
-------
title_id VARCHAR(255) PK FK -< employees.employee_title_id
title VARCHAR(255)
