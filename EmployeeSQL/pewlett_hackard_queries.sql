-- Create all tables
CREATE TABLE departments(
	department_no VARCHAR(50) NOT NULL PRIMARY KEY,
	department_name VARCHAR(50) NOT NULL
);

CREATE TABLE titles(
	title_id VARCHAR(50) NOT NULL PRIMARY KEY,
	title VARCHAR(50) NOT NULL
);

CREATE TABLE salaries(
	employee_no INT NOT NULL PRIMARY KEY,
	salary INT NOT NULL
);

CREATE TABLE employees(
	employee_no INT NOT NULL PRIMARY KEY REFERENCES salaries(employee_no),
	employee_title_id VARCHAR(50) NOT NULL REFERENCES titles(title_id),
	birth_date VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	sex VARCHAR(50),
	hire_date VARCHAR(50)
);

CREATE TABLE department_employees(
	employee_no INT NOT NULL REFERENCES employees(employee_no),
	department_no VARCHAR(50) NOT NULL REFERENCES departments(department_no),
	PRIMARY KEY (employee_no, department_no)
);

CREATE TABLE department_manager(
	department_no VARCHAR(50) NOT NULL REFERENCES departments(department_no),
	employee_no INT NOT NULL REFERENCES employees(employee_no),
	PRIMARY KEY (department_no, employee_no)
);

SELECT * FROM employees;

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.employee_no,
	employees.last_name,
	employees.first_name,
	employees.sex,
	salaries.salary
FROM employees
INNER JOIN salaries ON
salaries.employee_no=employees.employee_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';

-- List the manager of each department along with their department number, department name,
-- employee number, last name, and first name.
SELECT departments.department_no,
	departments.department_name,
	department_manager.employee_no,
	employees.last_name,
	employees.first_name
FROM employees
LEFT JOIN department_manager ON
employees.employee_no = department_manager.employee_no
RIGHT JOIN departments ON
departments.department_no = department_manager.department_no;

-- List the department number for each employee along with that employee’s employee number,
-- last name, first name, and department name.
SELECT department_employees.department_no,
	department_employees.employee_no,
	employees.last_name,
	employees.first_name,
	departments.department_name
FROM employees
RIGHT JOIN department_employees ON
employees.employee_no = department_employees.employee_no
LEFT JOIN departments ON
department_employees.department_no = departments.department_no;

-- List the first name, last name, and sex of each employee whose first name is Hercules and 
-- whose last name begins with the letter B.
SELECT employees.first_name,
	employees.last_name,
	employees.sex
FROM employees
WHERE 
	first_name = 'Hercules'
	AND last_name LIKE 'B%';
	
-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT department_employees.employee_no,
	employees.last_name,
	employees.first_name
FROM department_employees
LEFT JOIN employees ON
department_employees.employee_no = employees.employee_no
WHERE department_no = 'd007';

-- List each employee in the Sales and Development departments, including their employee number, last name, 
-- first name, and department name.
SELECT department_employees.employee_no,
	employees.last_name,
	employees.first_name,
	departments.department_name
FROM department_employees
LEFT JOIN employees ON
department_employees.employee_no = employees.employee_no
LEFT JOIN departments ON
department_employees.department_no = departments.department_no
WHERE
	department_employees.department_no = 'd007'
	OR department_employees.department_no = 'd005';
	
-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees
-- share each last name).
SELECT last_name, COUNT(last_name) AS "Frequency Counts"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Counts" DESC;