
CREATE TABLE Departments (
    department_id int primary key,
    department_name varchar(50)
);
CREATE TABLE Employees (
    employee_id int primary key,
    department_id int,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES Departments (department_id),
    employee_name varchar(100),
    hire_date date,
    job_title varchar(50)
);

-- departments table population
INSERT INTO Departments VALUES (1, 'Software Development'),
                               (2, 'Human Resources'),
                               (3, 'Marketing'),
                               (4, 'Software Quality Assurance'),
                               (5, 'Accounting');


-- Employees table population
INSERT INTO Employees VALUES (1, 1, 'Gabriel Barbosa', '2022-03-20', 'Development Manager'),
                             (2, 2, 'Éverton Ribeiro', '2022-03-20', 'HR Manager'),
                             (3, 3, 'Diego Ribas', '2022-03-20', 'Marketing Manager'),
                             (4, 4, 'Gustavo Scarpa', '2022-03-22', 'QA Manager'),
                             (5, 5, 'Givanildo Vieira de Souza', '2022-03-22', 'Accounting Manager'),
                             (6, 1, 'Nacho Fernández', '2022-03-22', 'Senior Developer'),
                             (7, 2, 'João Paulo', '2022-03-22', 'HR Analyst'),
                             (8, 3, 'Diego Souza', '2022-08-12', 'Marketing Analyst'),
                             (9, 4, 'Wardell Stephen Curry', '2022-08-12', 'QA Analyst'),
                             (10, 5, 'Wardell Stephen Curry', '2022-08-12', 'Accounting Analyst');

-- Update job titles for the first 5 employees
UPDATE Employees SET job_title = 'Manager' WHERE employee_id <= 5;

-- Update the name of the 10th employee
UPDATE Employees SET employee_name = 'Lebron James' WHERE employee_id = 10;

-- Insert additional employees
INSERT INTO Employees VALUES (11, 1, 'Marcos', '2022-03-20', 'Junior Developer'),
                             (12, 1, 'Joao', '2022-03-20', 'Mid-Level Developer');

-- Select all employees ordered by employee_id
SELECT * FROM Employees ORDER BY employee_id;
-- q1.
SELECT Employees.employee_name, Departments.department_name, Employees.job_title 
FROM Employees 
NATURAL INNER JOIN Departments 
WHERE Departments.department_name = 'Software Development';
-- q2.
SELECT Employees.employee_name, Departments.department_name, Employees.job_title 
FROM Employees 
NATURAL INNER JOIN Departments 
WHERE Employees.employee_name = 'Wardell Stephen Curry';
-- q3.
SELECT 
    mgr.employee_name AS manager,
    COUNT(emp.employee_id) AS total_employees
FROM 
    Employees mgr
LEFT JOIN 
    Employees emp ON mgr.department_id = emp.department_id AND emp.job_title != 'Manager'
WHERE 
    mgr.job_title = 'Manager'
GROUP BY 
    mgr.employee_name;
