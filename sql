CREATE DATABASE studentsDB4;
use  studentsDB4;
CREATE TABLE books2 (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(100),
    category VARCHAR(50),
    author VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT,
    published_year INT
);
INSERT INTO books2
VALUES
(1, 'Java Basics', 'Programming', 'Arun', 500, 10, 2020),
(2, 'Python Guide', 'Programming', 'Priya', 600, 15, 2022),
(3, 'SQL Master', 'Database', 'Kumar', 450, 20, 2021),
(4, 'English Grammar', 'Education', 'Divya', 300, 12, 2019),
(5, 'MySQL Guide', 'Database', 'Rahul', 700, 8, 2023);

SELECT * FROM books2;

-- trigger--
DELIMITER //
CREATE TRIGGER InsertBefore1
BEFORE INSERT ON books2
FOR EACH ROW
BEGIN
IF NEW.price<0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Price cannot be zero';
END IF;
END //
DELIMITER 


DELIMITER //
CREATE TRIGGER InsertBefore2
BEFORE INSERT ON books2
FOR EACH ROW
BEGIN
IF NEW.quantity<0 THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT='quantity cannot be zero';
END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BookToUpper
BEFORE INSERT ON books2
FOR EACH ROW
BEGIN
SET NEW.book_name=UPPER(NEW.book_name) ;
END //
DELIMITER ;
SHOW TRIGGERS;

INSERT INTO books2
(book_id, book_name, price, quantity)
VALUES
(102, 'Python', 500, -5);


DELIMITER //
CREATE TRIGGER BeforeInsert1
BEFORE UPDATE ON books2
FOR EACH ROW
BEGIN
IF NEW.quantity<0 THEN
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT='quantity cannot be zero';
END IF;
END //
DELIMITER ;

SHOW TRIGGERS;

DELIMITER //

CREATE TRIGGER logdeleted_book_date
AFTER DELETE ON books2
FOR EACH ROW
BEGIN
    INSERT INTO deleted_books (book_id, book_name, deleted_date)
    VALUES (OLD.book_id, OLD.book_name, CURDATE());
END //

DELIMITER ;







