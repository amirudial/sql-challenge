-- Drop tables if exist
DROP TABLE IF EXISTS departments cascade;
DROP TABLE IF EXISTS dept_emp cascade;
DROP TABLE IF EXISTS dept_manager cascade;
DROP TABLE IF EXISTS employees cascade;
DROP TABLE IF EXISTS salaries cascade;
DROP TABLE IF EXISTS titles cascade;

-- Create Departments table
CREATE TABLE departments (
	dept_no VARCHAR (30) not null,
	dept_name VARCHAR (30) not null,
	primary key (dept_no)
);

select * from departments d ;


-- Create Titles table
CREATE TABLE titles(
	title_id VARCHAR (30) primary key,
	title VARCHAR (30) 
	
);

select * from titles t;


-- Create Employees table
CREATE TABLE employees(
	emp_no INT primary key not null,
	emp_title_id VARCHAR (30) not null,
	Foreign key (emp_title_id) references titles(title_id),
	birth_date DATE not null,
	first_name VARCHAR (30) not null,
	last_name VARCHAR (30) not null,
	sex VARCHAR (30) not null,
	hire_date DATE not null
);

select * from employees e ;

-- Create Salaries table
CREATE TABLE salaries(
	emp_no INT not null,
	salary INT not null,
	primary key (emp_no),
	foreign key (emp_no) references employees(emp_no) 
);

select * from salaries s ;

-- Create Department_Employ table
CREATE TABLE dept_emp (
	emp_no INT not null,
	dept_no VARCHAR (30) not null,
	primary key (dept_no, emp_no),
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
);

select * from dept_emp de ;

-- Create Department_Managers table
CREATE TABLE dept_manager(
	dept_no VARCHAR (30) not null,
	emp_no INT not null,
	primary key (emp_no, dept_no),
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments (dept_no)
	);
select * from dept_manager dm ;
	
-- List the employee number, last name, first name, sex, and salary of each employee
select e.emp_no, e.last_name, first_name, e.sex, s.salary
from employees e 
join salaries s on e.emp_no = s.emp_no; 

-- List the first name, last name, and hire date for the employees who were hired in 1986
select e.emp_no, e.first_name, e.last_name, e.hire_date
from employees e
where e.hire_date
between '1986-01-01' and '1986-12-31';

-- List the manager of each department along with their department number, department name, employee number, last name, and first name
select d.dept_name, d.dept_no, e.emp_no, e.last_name, e.first_name
from departments d2  
inner join departments d on d2.dept_no = d.dept_no 
inner join employees e on e.emp_no = e.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name
select d.dept_name, d.dept_no, e.emp_no, e.last_name, e.first_name
from employees e 
inner join dept_emp de on e.emp_no = de.emp_no
inner join departments d on de.dept_no = d.dept_no ;


-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
select e.first_name, e.last_name, e.sex
from employees e 
where e.first_name = 'Hercules' and e.last_name like 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e 
inner join dept_emp de on e.emp_no = de.emp_no 
inner join departments d on d.dept_no = de.dept_no 
where dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e 
inner join dept_emp de on e.emp_no = de.emp_no 
inner join departments d on d.dept_no = de.dept_no 
where dept_name = 'Sales' or dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
select e.last_name, count(*) from employees e group by e.last_name order by count(*) desc;








