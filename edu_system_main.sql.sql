-- Educational System 
-- Developed by Kauan Izidoro
-- 05.10.2024 

-- DDL Comands
CREATE TABLE Student(
    cpf VARCHAR(14) PRIMARY KEY,
    name VARCHAR (50) NOT NULL,
    age INTEGER,
    number INTEGER,
    street VARCHAR(50),
    neighborhood VARCHAR(20),
    city VARCHAR(20),
    state VARCHAR(20),
    zipcode VARCHAR(9) NOT NULL,
    country VARCHAR(20) 
);

CREATE TABLE Contact_Phone(
    cpf VARCHAR(14),
    code_number VARCHAR(7),
    number VARCHAR(20),
    FOREIGN KEY (cpf) REFERENCES Student(cpf)
);

CREATE TABLE Contact_Email(
    cpf VARCHAR(14),
    email VARCHAR(64),
    domain VARCHAR(50),
    FOREIGN KEY (cpf) REFERENCES Student(cpf)
);

CREATE TABLE Department(
    id_dept SERIAL PRIMARY KEY,
    acronym VARCHAR(5),
    name VARCHAR(20)
);

CREATE TABLE Course(
    id_dept INTEGER,
    id_course SERIAL PRIMARY KEY,
    name VARCHAR(50),
    FOREIGN KEY (id_dept) REFERENCES Department(id_dept)
);

CREATE TABLE Enrollment(
    sr VARCHAR(11) PRIMARY KEY,
    cpf VARCHAR(14),
    id_course INTEGER,
    status VARCHAR(15), -- 'active' OR 'inactive' OR 'droput'
    FOREIGN KEY (id_course) REFERENCES Course(id_course),
    FOREIGN KEY (cpf) REFERENCES Student(cpf)
);

CREATE TABLE Discipline(
    id_discipline SERIAL PRIMARY KEY,
    name VARCHAR(50),
    optative BOOLEAN
);

CREATE TABLE Enrollment_Discipline(
    sr VARCHAR(11),
    id_discipline SERIAL,
    FOREIGN KEY (sr) REFERENCES Enrollment(sr),
    FOREIGN KEY (id_discipline) REFERENCES Discipline(id_discipline)
);

CREATE TABLE Course_Discipline(
    id_course SERIAL,
    id_discipline SERIAL,
    FOREIGN KEY (id_course) REFERENCES Course(id_course),
    FOREIGN KEY (id_discipline) REFERENCES Discipline(id_discipline)
);




-- DML Comands
CREATE OR REPLACE FUNCTION dml_StudentN() --Function to fill tables (Student)
RETURNS VOID AS
$$
DECLARE
    i INTEGER := 1; -- control variable
    age_s INTEGER[];
    number_s INTEGER[];
    cpf_s VARCHAR[] := ARRAY['866.208.500-81', '386.394.590-53', '330.461.630-61', '427.572.430-55', '495.458.050-13', 
                                '535.522.999-61', '531.574.750-61', '421.080.488-63', '561.244.918-69', '656.710.968-80', 
                                '714.778.688-28', '135.863.748-28', '458.877.038-14', '550.634.768-56', '987.896.848-00', 
                                '349.235.028-35', '602.299.468-36', '160.844.938-66', '491.505.098-02', '192.681.668-44', 
                                '070.229.228-10', '111.222.333-44', '222.333.444-55', '333.444.555-66', '444.555.666-77', 
                                '555.666.777-88', '666.777.888-99', '777.888.999-00', '888.999.000-11'];  

    name_s VARCHAR[] := ARRAY['Sofia Oliveira', 'André Silva', 'Inês Santos', 'Diogo Rodrigues', 'Carolina Pereira', 
                            'Tiago Martins', 'Mariana Costa', 'Miguel Fernandes', 'Beatriz Almeida', 'Pedro Sousa', 
                            'Ana Gonçalves', 'João Carvalho', 'Catarina Mendes', 'Francisco Santos', 'Marta Pereira', 
                            'Ricardo Oliveira', 'Sara Rodrigues', 'David Silva', 'Laura Fernandes', 'Bruno Costa', 
                            'Filipa Almeida', 'Rui Martins', 'Inês Pereira', 'Hugo Rodrigues', 'Patrícia Carvalho', 
                            'Nuno Mendes', 'Diana Santos', 'Carlos Almeida', 'Mariana Gonçalves', 'Alexandre Costa'];

    street_s VARCHAR[] := ARRAY['Rua das Flores','Avenida Brasil','Rua da Praia','Avenida Paulista','Rua do Ouvidor',
        'Avenida Atlântica','Rua Augusta','Avenida Boa Viagem','Rua Oscar Freire','Avenida Vieira Souto','Rua Barão de Itapetininga',
        'Avenida Jornalista Roberto Marinho','Rua das Palmeiras','Avenida Presidente Vargas','Rua Riachuelo','Avenida Beira Mar',
        'Rua Padre Chagas','Avenida Brigadeiro Faria Lima','Rua dos Andradas','Avenida Paulista','Rua Marechal Deodoro',
        'Avenida Goethe','Rua da Consolação','Avenida Dom Luís','Rua Padre Feijó','Avenida Boa Viagem','Rua XV de Novembro','Avenida Conselheiro Aguiar',
        'Rua dos Andradas','Rua dos Girassóis'];

   neighborhood_s VARCHAR[] := ARRAY['Centro', 'Copacabana', 'Boa Viagem', 'Bela Vista', 'Centro','Copacabana', 'Consolação',
                                     'Boa Viagem', 'Jardins', 'Ipanema', 'Centro','Barra da Tijuca', 'Cidade Baixa', 'Centro',
                                     'Centro', 'Centro','Moinhos de Vento', 'Itaim Bibi', 'Centro', 'Bela Vista', 'Centro','Rio Branco',
                                     'Consolação', 'Meireles', 'Centro', 'Boa Viagem', 'Centro', 'Boa Viagem','Centro', 'Centro'];

    zipcode_s VARCHAR[] := ARRAY['01001-000', '22041-000', '51023-000', '01310-811', '20040-030','22010-000', '01305-000',
                                 '51022-000', '01426-001', '22420-002', '01042-020','22640-000', '90050-000', '20071-004',
                                  '01007-000', '60060-440','90570-080', '04538-133', '90020-007', '01310-888', '80010-010',
                                  '90430-100', '01302-000', '60160-230', '99910-150', '52011-100', '88010-101','51911-030', '01051-500','13232-493'];

BEGIN 
    age_s := array(SELECT trunc(random()*(49-17+1))+17 FROM generate_series(1, 30));
    --array_name := array(select trunc(random()*(max-min+1))+min FROM generate_series(1,num max of generate))
    number_s := array(SELECT trunc(random()*(99-0+1))+1 FROM generate_series(1, 30));
    WHILE i<30 LOOP
        INSERT INTO Student(cpf,name,age,number,street,neighborhood,city,state,zipcode,country)
        VALUES (cpf_s[i],name_s[i],age_s[i],number_s[i],street_s[i],neighborhood_s[i],'Sorocaba','SP',zipcode_s[i],'Brazil');
        i := i+1;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT dml_StudentN();

CREATE OR REPLACE FUNCTION dml_Contact_PhoneN() -- Fill table (Contact_Phone)
RETURNS VOID AS 
$$
DECLARE
    i INT := 1;
    cpf_s VARCHAR[] := ARRAY['866.208.500-81', '386.394.590-53', '330.461.630-61', '427.572.430-55', '495.458.050-13', 
                                '535.522.999-61', '531.574.750-61', '421.080.488-63', '561.244.918-69', '656.710.968-80', 
                                '714.778.688-28', '135.863.748-28', '458.877.038-14', '550.634.768-56', '987.896.848-00', 
                                '349.235.028-35', '602.299.468-36', '160.844.938-66', '491.505.098-02', '192.681.668-44', 
                                '070.229.228-10', '111.222.333-44', '222.333.444-55', '333.444.555-66', '444.555.666-77', 
                                '555.666.777-88', '666.777.888-99', '777.888.999-00', '888.999.000-11'];

   code_number_s VARCHAR[] := ARRAY['+55 15', '+55 11', '+55 14', '+55 15', '+55 11', '+55 14',
                                    '+55 15', '+55 11', '+55 14', '+55 15', '+55 11', '+55 14',
                                    '+55 15', '+55 11', '+55 14', '+55 15', '+55 11', '+55 14',
                                    '+55 15', '+55 11', '+55 14', '+55 15', '+55 11', '+55 14',
                                    '+55 15', '+55 11', '+55 14', '+55 15', '+55 11', '+55 14'];

    number_s VARCHAR[] := ARRAY['99000-0000', '99001-0001', '99002-0002', '99003-0003', '99004-0004', '99005-0005',
                               '99006-0006', '99007-0007', '99008-0008', '99009-0009', '99010-0010', '99011-0011',
                               '99012-0012', '99013-0013', '99014-0014', '99015-0015', '99016-0016', '99017-0017',
                               '99018-0018', '99019-0019', '99020-0020', '99021-0021', '99022-0022', '99023-0023',
                               '99024-0024', '99025-0025', '99026-0026', '99027-0027', '99028-0028', '99029-0029'];

BEGIN 
    WHILE i<31 LOOP
        INSERT INTO Contact_Phone(cpf,code_number,number) VALUES (cpf_s[i],code_number_s[i],number_s[i]);
        i:=i+1;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT dml_Contact_PhoneN();

CREATE OR REPLACE FUNCTION dml_Contact_EmailN() -- Fill table (Contact_Email)
RETURNS VOID AS 
$$
DECLARE
    i INTEGER := 1;
    rand_s INTEGER[];
    cpf_s VARCHAR[] := ARRAY['866.208.500-81', '386.394.590-53', '330.461.630-61', '427.572.430-55', '495.458.050-13', 
                                '535.522.999-61', '531.574.750-61', '421.080.488-63', '561.244.918-69', '656.710.968-80', 
                                '714.778.688-28', '135.863.748-28', '458.877.038-14', '550.634.768-56', '987.896.848-00', 
                                '349.235.028-35', '602.299.468-36', '160.844.938-66', '491.505.098-02', '192.681.668-44', 
                                '070.229.228-10', '111.222.333-44', '222.333.444-55', '333.444.555-66', '444.555.666-77', 
                                '555.666.777-88', '666.777.888-99', '777.888.999-00', '888.999.000-11'];
    email_s VARCHAR[] := ARRAY['sofiaoliveira', 'andresilva', 'inessantos', 'diogorodrigues', 'carolinapereira',
                               'tiagomartins', 'marianacosta', 'miguelfernandes', 'beatrizalmeida', 'pedrosousa',
                               'anagoncalves', 'joaocarvalho', 'catarinamendes', 'franciscosantos', 'martapereira',
                               'ricardooliveira', 'sararodrigues', 'davidsilva', 'laurafernandes', 'brunocosta',
                               'filipaalmeida', 'ruimartins', 'inespereira', 'hugorodrigues', 'patriciacarvalho',
                               'nunomendes', 'dianasantos', 'carlosalmeida', 'marianagoncalves'];
    domain_s VARCHAR[] := ARRAY['@gmail.com', '@gmail.com', '@gmail.com', '@gmail.com', '@gmail.com','@outlook.com',
                                '@gmail.com', '@gmail.com', '@gmail.com', '@gmail.com', '@gmail.com','2rp.com',
                                '@senai.sp.com', '@senai.sp.com', '@senai.sp.com', '@senai.sp.com', '@senai.sp.com',
                                '@senai.sp.com', '@senai.sp.com', '@senai.sp.com', '@senai.sp.com', '@senai.sp.com',
                                '@company.com', '@company.com', '@company.com', '@company.com', '@company.com',
                                '@company.com', '@company.com', '@company.com', '@company.com', '@company.com'];
BEGIN
    rand_s := array(SELECT trunc(random()*(32-1+1))+1 FROM generate_series(1,30));
    WHILE i<30 LOOP
        INSERT INTO Contact_Email(cpf,email,domain) VALUES (cpf_s[i],email_s[i],domain_s[rand_s[i]]);
        i:=i+1;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT dml_Contact_EmailN();

-- DDL Comand
ALTER TABLE Department ALTER COLUMN acronym TYPE VARCHAR(10);

CREATE OR REPLACE FUNCTION dml_DepartmentN() --Fill table (Department)
RETURNS VOID AS 
$$
DECLARE 
    i INT := 1;
    acronym_s VARCHAR[] := ARRAY['ENG-01','HEALTH-10','HUMAN-11','TEC-001'];
    name_s VARCHAR[] := ARRAY['Engineering','Health','Humanities','Tecnology'];
BEGIN
    WHILE i<5 LOOP
        INSERT INTO Department(acronym, name) VALUES (acronym_s[i],name_s[i]);
        i:=i+1;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT dml_DepartmentN();

CREATE OR REPLACE FUNCTION dml_CourseN() --Fill table (Course)
RETURNS VOID AS 
$$
DECLARE
    i INT := 1;
    name_s VARCHAR[] := ARRAY['Civil Engineering','Mechanical Engineering','Electrical Engineering','Industrial Engineering',
                              'Chemical Engineering','Computer Engineering','Environmental Engineering','Medicine','Nursing',
                              'Dentistry','Physiotherapy','Nutrition','Pharmacy','Psychology','History','Philosophy',
                              'Sociology','Anthropology','Geography','Literature','Pedagogy','Computer Science',
                              'Information Systems','Software Engineering','Game Design','Artificial Intelligence',
                              'Information Security','Web Development'];
    id_dept_s INTEGER[] := ARRAY[1,2,3,4];
BEGIN 
    WHILE i<8 LOOP
        INSERT INTO Course(id_dept,name) VALUES (1,name_s[i]), (2,name_s[i+7]), (3,name_s[i+14]), (4, name_s[i+21]);
        i:=i+1;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT dml_CourseN();

CREATE OR REPLACE FUNCTION dml_EnrollmentN() -- Fill table (Enrollment)
RETURNS VOID AS
$$
DECLARE 
    i INTEGER := 1;
    rand_s INTEGER[] := array(SELECT trunc(random()*(3-1+1))+1 FROM generate_series(1,30));
    sr_s INTEGER := 2024;
    cpf_s VARCHAR[] := ARRAY['866.208.500-81', '386.394.590-53', '330.461.630-61', '427.572.430-55', '495.458.050-13', 
                                '535.522.999-61', '531.574.750-61', '421.080.488-63', '561.244.918-69', '656.710.968-80', 
                                '714.778.688-28', '135.863.748-28', '458.877.038-14', '550.634.768-56', '987.896.848-00', 
                                '349.235.028-35', '602.299.468-36', '160.844.938-66', '491.505.098-02', '192.681.668-44', 
                                '070.229.228-10', '111.222.333-44', '222.333.444-55', '333.444.555-66', '444.555.666-77', 
                                '555.666.777-88', '666.777.888-99', '777.888.999-00', '888.999.000-11'];
    status_s VARCHAR[] := ARRAY['active','inactive','dropout'];
BEGIN 
    WHILE i<=31 LOOP
        INSERT INTO Enrollment(sr,cpf,id_course,status) VALUES (sr_s+i+11,cpf_s[i],6,status_s[rand_s[i]]);
        i:=i+1;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT dml_EnrollmentN();

CREATE OR REPLACE FUNCTION dml_DisciplineN() --Fill table (Discipline)
RETURNS VOID AS 
$$
DECLARE
    i INT := 1;
    name_s VARCHAR[] := ARRAY['Physics','Chemistry','Calculus','Anatomy',
                              'Physiology','Ethics','Microbiology','Algebra','Literature',
                              'Programming','Data Structures','Artificial Intelligence','Pharmacology','Cell Biology','Materials Science'];
    name_sOptative VARCHAR[] := ARRAY['Statistics','Art History','Creative Writing','Philosophy of Science','Film Studies',
                                      'Marketing','Entrepreneurship','Public Speaking','Music Theory','Digital Marketing',
                                      'Business Ethics','Graphic Design','Culinary Arts','Astrophysics','Yoga'];
    optative_s BOOLEAN[] := ARRAY[true,false];
BEGIN 
    WHILE i<31 LOOP
        INSERT INTO Discipline(name, optative) VALUES (name_s[i],optative_s[1]), (name_sOptative[i],optative_s[2]); 
        i:=i+1;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT dml_DisciplineN();

CREATE OR REPLACE FUNCTION dml_Enrollment_DisciplineN() -- Fill table (Enrollment_Discipline)
RETURNS VOID AS 
$$
DECLARE 
    i INTEGER := 1;
    sr_s INTEGER[] := array(SELECT 2024 + i + 11 FROM generate_series(1,30));
BEGIN 
    WHILE i<31 LOOP
        INSERT INTO Enrollment_Discipline(sr) VALUES (sr_s[i]), (sr_s[i] + 12);
        i:=i+1;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

SELECT dml_Enrollment_DisciplineN();

-- Fill table (Course_Discipline)
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (1,2);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (1,8);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (1,15);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (6,1);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (6,3);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (6,10);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (6,12);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (14,2);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (14,4);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (14,5);
INSERT INTO Course_Discipline(id_course, id_discipline) VALUES (14,6);

--DQL Comands 

SELECT * FROM Student;
SELECT * FROM Contact_Phone;
SELECT * FROM Contact_Email;
SELECT * FROM Department;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Discipline;
SELECT * FROM Enrollment_Discipline;
SELECT * FROM Course_Discipline;

-- 1.Given the RA or the Student's Name, retrieve all other student data from the database
    SELECT * FROM Student WHERE cpf = 'enter cpf for query' OR name = 'enter name for query';
-- 2.Given the name of a department, display the names of all courses associated with it
    SELECT Course.name 
    FROM Course 
    INNER JOIN Department ON Course.id_dept = Department.id_dept 
    WHERE Department.name = 'enter department for query';
-- 3.Given the name of a discipline, display which course(s) it belongs to
    SELECT Course.name 
    FROM Course 
    INNER JOIN Course_Discipline ON Course.id_course = Course_Discipline.id_course 
    INNER JOIN Discipline ON Course_Discipline.id_discipline = Discipline.id_discipline 
    WHERE Discipline.name = 'Name of discipline';
-- 4.Given a student's CPF, display which disciplines they are enrolled in
    SELECT Discipline.name 
    FROM Discipline 
    INNER JOIN Enrollment_Discipline ON Discipline.id_discipline = Enrollment_Discipline.id_discipline 
    INNER JOIN Enrollment ON Enrollment_Discipline.sr = Enrollment.sr 
    WHERE Enrollment.cpf = 'cpf of student';
-- 5.Filter all students enrolled in a specific course
    SELECT * 
    FROM Student 
    INNER JOIN Enrollment ON Student.cpf = Enrollment.cpf 
    INNER JOIN Course ON Enrollment.id_course = Course.id_course 
    WHERE Course.name = 'Name of course';
-- 6.Filter all students enrolled in a particular discipline
    SELECT * 
    FROM Student 
    INNER JOIN Enrollment ON Student.cpf = Enrollment.cpf 
    INNER JOIN Enrollment_Discipline ON Enrollment.sr = Enrollment_Discipline.sr 
    INNER JOIN Discipline ON Enrollment_Discipline.id_discipline = Discipline.id_discipline 
    WHERE Discipline.name = 'Name of discipline';
-- 7.Filter graduated students 
    SELECT * 
    FROM Student 
    INNER JOIN Enrollment ON Student.cpf = Enrollment.cpf 
    WHERE Enrollment.status = 'inactive';
-- 8.Filter active students
    SELECT * 
    FROM Student 
    INNER JOIN Enrollment ON Student.cpf = Enrollment.cpf 
    WHERE Enrollment.status = 'active';
-- 9.Present the number of active students per course
    SELECT Course.name, COUNT(Student.cpf) AS active_student
    FROM Course 
    INNER JOIN Enrollment ON Course.id_course = Enrollment.id_course 
    INNER JOIN Student ON Enrollment.cpf = Student.cpf 
    WHERE Enrollment.status = 'active' 
    GROUP BY Course.name;
--10.Present the number of active students per discipline
    SELECT Discipline.name, COUNT(Student.cpf) AS Active_Student
    FROM Discipline
    INNER JOIN Enrollment_Discipline ON Discipline.id_discipline = Enrollment_Discipline.id_discipline
    INNER JOIN Enrollment ON Enrollment_Discipline.sr = Enrollment.sr
    INNER JOIN Student ON Enrollment.cpf = Student.cpf
    WHERE Enrollment.status = 'inactive'
    GROUP BY Discipline.name;


