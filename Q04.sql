
CREATE TABLE Patient (
    patient_id int primary key,
    patient_name varchar(100),
    birth_date date
);

CREATE TABLE Doctor (
    doctor_id int primary key,
    doctor_name varchar(100),
    specialization varchar(50)
);

CREATE TABLE patient_doctor (
    appointment_id int primary key,
    patient_id int,
    CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES Patient (patient_id),
    doctor_id int,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES Doctor (doctor_id) 
);

ALTER TABLE patient_doctor ADD appointment_date date;

-- patient table population
INSERT INTO Patient VALUES (1, 'Leonardo DiCaprio', '1974-11-11'),
                           (2, 'Meryl Streep', '1949-06-22'),
                           (3, 'Tom Hanks', '1956-06-09'),
                           (4, 'Denzel Washington', '1954-12-28'),
                           (5, 'Julia Roberts', '1967-10-28'),
                           (6, 'Brad Pitt', '1963-12-18'),
                           (7, 'Jennifer Lawrence', '1990-08-15'),
                           (8, 'Robert De Niro', '1943-08-17'),
                           (9, 'Charlize Theron', '1975-08-07'),
                           (10, 'George Clooney', '1961-05-06');

-- doctor table population
INSERT INTO Doctor VALUES (1, 'Nicole Kidman', 'Anesthesiologist'),
                          (2, 'Johnny Depp', 'Cardiologist'),
                          (3, 'Sandra Bullock', 'Dermatologist'),
                          (4, 'Will Smith', 'Endocrinologist'),
                          (5, 'Scarlett Johansson', 'Gastroenterologist'),
                          (6, 'Daniel Day-Lewis', 'Gynecologist'),
                          (7, 'Emma Watson', 'Hematologist'),
                          (8, 'Morgan Freeman', 'Infectious Disease Specialist'),
                          (9, 'Cate Blanchett', 'Neurosurgeon'),
                          (10, 'Hugh Jackman', 'Oncologist');

-- patient_doctor population
INSERT INTO patient_doctor VALUES (1, 1, 5, '2022-08-10'),
                                  (2, 3, 6, '2022-08-12'),
                                  (3, 6, 2, '2022-09-21'),
                                  (4, 2, 1, '2022-09-28'),
                                  (5, 8, 2, '2022-10-05'),
                                  (6, 9, 7, '2022-10-07'),
                                  (7, 7, 9, '2022-11-17'),
                                  (8, 10, 8, '2023-01-08'),
                                  (9, 5, 10, '2023-01-20'),
                                  (10, 4, 4, '2023-04-21');

-- Update doctor_id values
UPDATE patient_doctor SET doctor_id = 1 WHERE doctor_id = 4;
UPDATE patient_doctor SET doctor_id = 1 WHERE doctor_id = 5;

-- q1.
SELECT Patient.patient_name, Doctor.doctor_name 
FROM (Patient NATURAL INNER JOIN patient_doctor)
NATURAL INNER JOIN Doctor 
WHERE Doctor.doctor_name = 'Nicole Kidman';
-- q2.
SELECT Patient.patient_name, Doctor.doctor_name 
FROM (Patient NATURAL INNER JOIN patient_doctor)
NATURAL INNER JOIN Doctor 
WHERE Patient.patient_name = 'Leonardo DiCaprio';
-- q3.
SELECT 
    COUNT(Patient.patient_name) / COUNT(Doctor.doctor_name) AS patients_per_doctor
FROM
    Patient
NATURAL INNER JOIN
    patient_doctor
NATURAL INNER JOIN 
    Doctor;
