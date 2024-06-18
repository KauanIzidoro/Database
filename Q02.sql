
CREATE TABLE students (
    student_id int primary key,
    student_name varchar(100),
    birth_date date
);

CREATE TABLE course (
    course_id int primary key,
    course_name varchar(50)
);

CREATE TABLE classes (
    class_id int primary key,
    course_id int,
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES course (course_id),
    responsible_prof varchar(100)
);

CREATE TABLE students_classes (
    class_id int,
    CONSTRAINT fk_class FOREIGN KEY (class_id) REFERENCES classes (class_id),
    student_id int,
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students (student_id)
);


-- course table population
INSERT INTO course VALUES (1, 'Computer Science Technician');
INSERT INTO course VALUES (2, 'Nursing Technician');
INSERT INTO course VALUES (3, 'Accounting Technician');
INSERT INTO course VALUES (4, 'Electronics Technician');
INSERT INTO course VALUES (5, 'Administration Technician');
INSERT INTO course VALUES (6, 'Work Safety Technician');
INSERT INTO course VALUES (7, 'Mechanical Technician');
INSERT INTO course VALUES (8, 'Logistics Technician');
INSERT INTO course VALUES (9, 'Radiology Technician');
INSERT INTO course VALUES (10, 'Food Technician');

-- students table population
INSERT INTO students VALUES (1, 'Charlie Brown', '2000-10-20');
INSERT INTO students VALUES (2, 'Axl Rose', '2000-10-20');
INSERT INTO students VALUES (3, 'Elvis Presley', '2000-10-20');
INSERT INTO students VALUES (4, 'John Lennon', '2000-10-20');
INSERT INTO students VALUES (5, 'Paul McCartney', '2000-10-20');
INSERT INTO students VALUES (6, 'George Harrison', '2000-10-20');
INSERT INTO students VALUES (7, 'Mick Jagger', '2000-10-20');
INSERT INTO students VALUES (8, 'Keith Richards', '2000-10-20');
INSERT INTO students VALUES (9, 'Roger Waters', '2000-10-20');
INSERT INTO students VALUES (10, 'Freddie Mercury', '2000-10-20');

-- classes table population
INSERT INTO classes VALUES (1, 2, 'Marcos Assunção');
INSERT INTO classes VALUES (2, 4, 'Ronaldinho Gaúcho');
INSERT INTO classes VALUES (3, 6, 'Arthur Antunes Coimbra');
INSERT INTO classes VALUES (4, 2, 'Romário de Souza Faria');
INSERT INTO classes VALUES (5, 5, 'Marcos Evangelista de Morais');
INSERT INTO classes VALUES (6, 8, 'Roberto Carlos da Silva');
INSERT INTO classes VALUES (7, 3, 'Marta Vieira da Silva');
INSERT INTO classes VALUES (8, 9, 'Roberto Rivellino');
INSERT INTO classes VALUES (9, 10, 'José Roberto Gama de Oliveira');
INSERT INTO classes VALUES (10, 1, 'Rivaldo Vítor Borba Ferreira');

--students_classes population
INSERT INTO students_classes VALUES (1, 2);
INSERT INTO students_classes VALUES (2, 3);
INSERT INTO students_classes VALUES (3, 6);
INSERT INTO students_classes VALUES (4, 7);
INSERT INTO students_classes VALUES (5, 8);
INSERT INTO students_classes VALUES (6, 9);
INSERT INTO students_classes VALUES (7, 1);
INSERT INTO students_classes VALUES (8, 3);
INSERT INTO students_classes VALUES (9, 10);
INSERT INTO students_classes VALUES (10, 3);

-- Questions
-- q1.
SELECT students.student_name, classes.class_id 
FROM (classes NATURAL INNER JOIN students_classes)
NATURAL INNER JOIN students 
WHERE classes.class_id = 3;
-- q2.
SELECT course.course_name, classes.class_id 
FROM course RIGHT JOIN classes USING(course_id)
WHERE classes.class_id = 2;
-- q3.
SELECT classes.class_id,
       COUNT(students.student_name) AS student_count
FROM students
NATURAL INNER JOIN students_classes
NATURAL INNER JOIN classes
GROUP BY classes.class_id 
ORDER BY classes.class_id;
