﻿--Employee Database: A Mystery in Two Parts


-- DROP TABLE departments CASCADE;
-- DROP TABLE dept_emp CASCADE;
-- DROP TABLE employees CASCADE; 
-- DROP TABLE salaries CASCADE;
-- DROP TABLE titles CASCADE;

-- DROP TABLE IF EXISTS dept_emp;
-- DROP TABLE IF EXISTS dept_manager;
-- DROP TABLE IF EXISTS employees;
-- DROP TABLE IF EXISTS salaries;
-- DROP TABLE IF EXISTS titles;


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE employees (
    emp_no INT  NOT NULL ,
    title_id VARCHAR  NOT NULL ,
    birth_date DATE  NOT NULL ,
    first_name VARCHAR  NOT NULL ,
    last_name VARCHAR  NOT NULL ,
    gender VARCHAR  NOT NULL ,
    hire_date DATE  NOT NULL ,
    PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
    title VARCHAR  NOT NULL ,
    title_id VARCHAR  NOT NULL 
);

CREATE TABLE departments (
    dept_no VARCHAR  NOT NULL ,
    dept_name VARCHAR  NOT NULL ,
    PRIMARY KEY (
        dept_no
    )
);

CREATE TABLE dept_employee (
    emp_no INT  NOT NULL ,
    dept_no VARCHAR  NOT NULL 
);

CREATE TABLE dept_manager (
    dept_no VARCHAR  NOT NULL ,
    emp_no INT  NOT NULL 
);

CREATE TABLE salaries (
    emp_no INT  NOT NULL ,
    salary INT  NOT NULL 
);


ALTER TABLE titles ADD CONSTRAINT fk_titles_title_id FOREIGN KEY(title_id)
REFERENCES employees (title_id);

ALTER TABLE dept_employee ADD CONSTRAINT fk_dept_employee_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_employee ADD CONSTRAINT fk_dept_employee_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);




SELECT * FROM "departments";
SELECT * FROM "dept_employee";
SELECT * FROM "dept_manager";
SELECT * FROM "employees";
SELECT * FROM "salaries";
SELECT * FROM "titles";


-- Data Analysis --
-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT * FROM "employees";


-- 2. List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM "employees"
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';


-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;


-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_employee.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_empolyee
JOIN employees
ON dept_employee.emp_no = employees.emp_no
JOIN departments
ON dept_employee.dept_no = departments.dept_no;


-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_employee.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_employee
JOIN employees
ON dept_employee.emp_no = employees.emp_no
JOIN departments
ON dept_employee.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_employee.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_employee
JOIN employees
ON dept_employee.emp_no = employees.emp_no
JOIN departments
ON dept_employee.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;

