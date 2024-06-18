
CREATE TABLE books (
    isbn bigint primary key,
    title varchar(150),
    publisher varchar(150),
    publication_year integer
);

CREATE TABLE books_author (
    isbn bigint,
    CONSTRAINT fk_isbn FOREIGN KEY (isbn) REFERENCES books (isbn),
    author_id int,
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES author (author_id)
);

ALTER TABLE books_author ALTER COLUMN isbn TYPE bigint;

-- books_authot population
INSERT INTO books_author VALUES(9845663802345, 1);
INSERT INTO books_author VALUES(9321823942432, 2);
INSERT INTO books_author VALUES(9312312312843, 3);
INSERT INTO books_author VALUES(9745935743445, 4);
INSERT INTO books_author VALUES(9875694594354, 5);
INSERT INTO books_author VALUES(9852423432423, 6);
INSERT INTO books_author VALUES(9641384914732, 7);
INSERT INTO books_author VALUES(9338193812731, 8);
INSERT INTO books_author VALUES(9043781231311, 9);
INSERT INTO books_author VALUES(9238194381412, 10);
INSERT INTO books_author VALUES(9184378423421, 11);

-- books population
INSERT INTO books VALUES(9184378423421, 'The Little Prince', 'Agir', 1943);
INSERT INTO books VALUES(9845663802345, 'Don Quixote', 'Nova Fronteira', 1605);
INSERT INTO books VALUES(9321823942432, 'The Divine Comedy', 'Martin Claret', 1308);
INSERT INTO books VALUES(9312312312843, 'Pride and Prejudice', 'Martin Claret', 1813);
INSERT INTO books VALUES(9745935743445, '1984', 'Companhia das Letras', 1949);
INSERT INTO books VALUES(9875694594354, 'The Catcher in the Rye', 'J.D. Salinger', 1951);
INSERT INTO books VALUES(9852423432423, 'One Hundred Years of Solitude', 'Record', 1967);
INSERT INTO books VALUES(9641384914732, 'Crime and Punishment', 'Martin Claret', 1866);
INSERT INTO books VALUES(9338193812731, 'The Lord of the Rings', 'Martins Fontes', 1954);
INSERT INTO books VALUES(9043781231311, 'Harry Potter', 'Rocco', 1997);
INSERT INTO books VALUES(9238194381412, 'Animal Farm', 'Companhia das Letras', 1945);

-- author population
INSERT INTO author VALUES(1, 'Miguel de Cervantes');
INSERT INTO author VALUES(2, 'Dante Alighieri');
INSERT INTO author VALUES(3, 'Jane Austen');
INSERT INTO author VALUES(4, 'George Orwell');
INSERT INTO author VALUES(5, 'J.D. Salinger');
INSERT INTO author VALUES(6, 'Gabriel García Márquez');
INSERT INTO author VALUES(7, 'Fyodor Dostoevsky');
INSERT INTO author VALUES(8, 'J.R.R. Tolkien');
INSERT INTO author VALUES(9, 'J.K. Rowling');
INSERT INTO author VALUES(10, 'George Orwell');
INSERT INTO author VALUES(11, 'Antoine de Saint-Exupéry');


-- Questions: 

-- q1)
SELECT books.title, author.author_name 
FROM (author NATURAL INNER JOIN books_author)
NATURAL INNER JOIN books;
-- q2)
SELECT books.title, author.author_name 
FROM (books NATURAL INNER JOIN books_author)
NATURAL INNER JOIN author 
WHERE author.author_name = 'Jane Austen';
-- q3)
SELECT books.title, author.author_name 
FROM (books NATURAL INNER JOIN books_author)
NATURAL INNER JOIN author 
WHERE books.title = 'The Little Prince';
