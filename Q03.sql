
CREATE TABLE employees (
    employee_id int primary key,
    employee_name varchar(100),
    birth_date date
);

CREATE TABLE projects (
    project_id int primary key,
    project_name varchar(150),
    start_date date,
    end_date date
);

CREATE TABLE employees_projects (
    project_id int,
    CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES projects (project_id),
    employee_id int,
    CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

-- employees table population
INSERT INTO employees VALUES (1, 'John Doe', '1980-01-15');
INSERT INTO employees VALUES (2, 'Jane Smith', '1985-03-22');
INSERT INTO employees VALUES (3, 'Robert Brown', '1990-07-30');
INSERT INTO employees VALUES (4, 'Emily Davis', '1975-11-05');
INSERT INTO employees VALUES (5, 'Michael Wilson', '1982-08-25');
INSERT INTO employees VALUES (6, 'Jessica Garcia', '1988-12-13');
INSERT INTO employees VALUES (7, 'David Martinez', '1992-04-10');
INSERT INTO employees VALUES (8, 'Sarah Lee', '1984-06-18');
INSERT INTO employees VALUES (9, 'Daniel Anderson', '1979-02-27');
INSERT INTO employees VALUES (10, 'Laura Thomas', '1995-09-09');

-- projects table population
INSERT INTO projects VALUES (1, 'School Database', '2023-01-01', '2023-06-01');
INSERT INTO projects VALUES (2, 'Hospital Management System', '2023-02-15', '2023-08-15');
INSERT INTO projects VALUES (3, 'E-commerce Platform', '2023-03-01', '2023-09-01');
INSERT INTO projects VALUES (4, 'Library System', '2023-04-01', '2023-10-01');
INSERT INTO projects VALUES (5, 'Inventory Management', '2023-05-01', '2023-11-01');
INSERT INTO projects VALUES (6, 'Payroll System', '2023-06-01', '2023-12-01');
INSERT INTO projects VALUES (7, 'Customer Relationship Management', '2023-07-01', '2023-12-31');
INSERT INTO projects VALUES (8, 'Online Learning Platform', '2023-08-01', '2024-02-01');
INSERT INTO projects VALUES (9, 'Social Media App', '2023-09-01', '2024-03-01');
INSERT INTO projects VALUES (10, 'Mobile Banking App', '2023-10-01', '2024-04-01');

-- employees_projects table population
INSERT INTO employees_projects VALUES (1, 1);
INSERT INTO employees_projects VALUES (2, 2);
INSERT INTO employees_projects VALUES (3, 3);
INSERT INTO employees_projects VALUES (4, 4);
INSERT INTO employees_projects VALUES (5, 5);
INSERT INTO employees_projects VALUES (6, 6);
INSERT INTO employees_projects VALUES (7, 7);
INSERT INTO employees_projects VALUES (8, 8);
INSERT INTO employees_projects VALUES (9, 9);
INSERT INTO employees_projects VALUES (10, 10);
INSERT INTO employees_projects VALUES (1, 2);
INSERT INTO employees_projects VALUES (3, 4);
INSERT INTO employees_projects VALUES (5, 6);
INSERT INTO employees_projects VALUES (7, 8);
INSERT INTO employees_projects VALUES (9, 10);

-- Questions
-- q1. 
SELECT employees.employee_name, projects.project_name 
FROM (projects NATURAL INNER JOIN employees_projects)
NATURAL INNER JOIN employees 
WHERE projects.project_name = 'School Database';
-- q2.
SELECT employees.employee_name, projects.project_name 
FROM (projects NATURAL INNER JOIN employees_projects)
NATURAL INNER JOIN employees 
WHERE employees.employee_name = 'Marco Polo';
-- q3.
SELECT 
    COUNT(employees.employee_name) / COUNT(projects.project_id) AS employees_per_project
FROM 
    employees
NATURAL INNER JOIN
    employees_projects
NATURAL INNER JOIN
    projects;
