## Employee Workforce Analysis
show databases;
use employees;
show tables;
describe employees;
describe salaries;
select * from employees;

-- Question 1: Female Workforce Analysis
-- Business Requirement: Identify female employees for HR workforce analysis.
-- Task: Display employee number, first name, last name, and gender.
-- Filter: Include only female employees (gender = 'F').
-- Sort: First name in ascending alphabetical order
select emp_no,first_name,last_name,gender from employees
where gender = "F" order by first_name asc; 

-- Question 2: Hiring Trends
-- Business Requirement: Analyze employees hired between 1990 and 1995.
-- Task: Display employee number, first name, last name, and hire date.
-- Filter: Hire date from January 1, 1990, to December 31, 1995.
-- Sort: Hire date in ascending order (oldest to newest).
select emp_no,first_name,last_name,hire_date from employees
where hire_date between '1990-01-01' and '1995-12-31'
order by hire_date asc;

-- Question 3: Male Workforce Analysis
-- Business Requirement: Analyze male employees for HR workforce reporting.
-- Task: Display employee number, first name, last name, and gender.
-- Filter: Include only male employees (gender = 'M').
-- Sort: Last name in ascending alphabetical order.
select emp_no,first_name,last_name,gender from employees
where gender = "M" 
order by last_name asc;

-- Question 4: Recent Hires Analysis
-- Business Requirement: Identify employees hired on or after January 1, 2000.
-- Task: Display employee number, first name, last name, and hire date.
-- Filter: Include employees hired on or after '2000-01-01'.
-- Sort: Hire date in descending order (newest to oldest).
select emp_no,first_name,last_name,hire_date from employees
where hire_date >= '2000-01-01'
order by hire_date desc;

-- Question 5: Employee Count by Gender
-- Business Requirement: Find the total number of male and female employees.
-- Task: Display gender and the total number of employees in each group.
select gender,count(*) as total_employees 
from employees
group by gender; 

-- Question 6: Employee Count by Hire Year
-- Business Requirement: Analyze yearly recruitment trends.
-- Task: Display each hiring year and the total employees hired that year.
select year(hire_date) as hire_year, 
count(*) as total_employees 
from employees
group by year(hire_date) order by hire_year asc;

-- Question 7: Employees by First Name
-- Business Requirement: Identify common first names in the workforce.
-- Task: Count employees sharing each first name.
-- Filter: Show only first names shared by more than 200 employees.
-- Sort: Total employees in descending order.
select first_name, count(first_name) as total_employees 
from employees 
group by first_name
having count(first_name) > 200 order by total_employees desc;

-- Question 8: Employees by Hire Date
-- Business Requirement: Identify dates with high employee hiring activity.
-- Task: Count employees hired on each date.
-- Filter: Show only dates with more than 100 employees hired.
-- Sort: Total employees in descending order.
select hire_date,count(hire_date) as total_employees from employees
group by hire_date
having count(hire_date) > 100
order by total_employees desc;

select * from dept_emp;
-- Question 9: Department-wise Employee Count
-- Business Requirement: Analyze employee distribution across departments.
-- Task: Count employee records in each department.
-- Table: dept_emp
-- Sort: Total employees in descending order.
select dept_no,count(emp_no) as total_employees from dept_emp
group by dept_no 
order by total_employees desc;

-- Question 10: Current Employees by Department
-- Business Requirement: Analyze the current workforce distribution.
-- Task: Count current employees in each department.
-- Table: current_dept_emp
-- Sort: Total employees in descending order.
select dept_no, count(emp_no) as total_employees
from current_dept_emp
group by dept_no
order by total_employees desc;

-- Question 11: Department Names and Employee Counts
-- Business Requirement: Generate a report of current employees by department name.
-- Tables: departments, current_dept_emp
-- Task: Display department names and count current employees in each department.
-- Sort: Total employees from highest to lowest.
select d.dept_name, count(c.emp_no) as total_employees
from departments d
join current_dept_emp c
 on d.dept_no = c.dept_no
group by d.dept_name
order by total_employees desc;

-- Question 12: Average Salary by Department
-- Business Requirement: Compare average salaries across departments.
-- Tables: salaries, dept_emp
-- Task: Calculate the average current salary for each department.
-- Filter: Include only current department assignments and current salaries.
-- Sort: Average salary from highest to lowest.
select d.dept_no, avg(s.salary) as avg_salary
from dept_emp d 
join salaries s
on d.emp_no = s.emp_no
where d.to_date = '9999-01-01' and s.to_date = '9999-01-01'
group by d.dept_no order by avg_salary desc;


-- Question 13: Highest Salary in the Company
-- Business Requirement: Identify the highest current salary recorded.
-- Table: salaries
-- Task: Display the highest salary as highest_salary.
-- Filter: Consider only current salaries.
-- SQL Concepts: MAX(), WHERE
select MAX(salary) as highest_salary
from salaries
where to_date = '9999-01-01';

-- Question 14: Minimum Current Salary
-- Business Requirement: Identify the lowest current salary in the company.
-- Table: salaries
-- Task: Display the lowest salary as lowest_salary.
-- Filter: Consider only current salary records.
select min(salary) as lowest_salary
from salaries
where to_date = '9999-01-01';

-- Question 15: Total Current Salary by Department
-- Business Requirement: Estimate salary expenditure for each department.
-- Tables: dept_emp, salaries
-- Task: Calculate total current salary for each department.
-- Filter: Include only current department assignments and current salaries.
-- Sort: Total salary from highest to lowest.
select de.dept_no, sum(s.salary) as total_salary
from dept_emp de
join salaries s
on de.emp_no = s.emp_no
where de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by de.dept_no
order by total_salary desc;

-- Question 16: Employee Count by Department and Gender
-- Business Requirement: Analyze gender distribution within each department.
-- Tables: employees, current_dept_emp
-- Task: Count employees by department and gender.
-- Filter: Include only current department assignments.
-- Sort: Department number, then gender.
select c.dept_no,e.gender,
count(e.emp_no) AS total_employees
from employees e
join current_dept_emp c
on e.emp_no = c.emp_no
group by c.dept_no, e.gender
order by c.dept_no asc, e.gender asc;

-- Question 17: Employee Count by Job Title
-- Business Requirement: Understand the distribution of job titles.
-- Table: titles
-- Task: Count employee records for each job title.
-- Sort: Total employees from highest to lowest.
select title,count(emp_no) as total_employees from titles 
group by title 
order by total_employees desc;

-- Question 18: Current Employee Count by Job Title
-- Business Requirement: Identify how many employees currently hold each job title.
-- Table: titles
-- Filter: Include only current job titles.
-- Sort: Total employees from highest to lowest.
select title,count(emp_no) as total_employees from titles
where to_date = '9999-01-01'
group by title
order by total_employees desc;

-- Question 19: Employees Hired by Year and Gender
-- Business Requirement: Compare yearly hiring numbers by gender.
-- Table: employees
-- Task: Count employees by hiring year and gender.
-- Sort: Hiring year in ascending order.
select year(hire_date) as hire_year,gender,count(emp_no) as total_employees
from employees 
group by year(hire_date),gender
order by hire_year asc;

-- Question 20: Department Workforce Summary
-- Business Requirement: Summarize the current workforce in each department.
-- Tables: departments, current_dept_emp
-- Task: Display department names and current employee counts.
-- Sort: Employee count from highest to lowest.
select d.dept_name,
count(c.emp_no) as total_employees
from departments d
join current_dept_emp c
on d.dept_no = c.dept_no
group by d.dept_name
order by total_employees desc;


