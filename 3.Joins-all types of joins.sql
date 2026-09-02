use bank_management;
CREATE TABLE class (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE class_info (
    id INT,
    address VARCHAR(30)
);

INSERT INTO class VALUES
(11,'Rahul'),
(12,'Priya'),
(13,'Kiran');

INSERT INTO class_info VALUES
(11,'HYDERABAD'),
(12,'BANGALORE'),
(14,'CHENNAI');

SELECT *
FROM class
CROSS JOIN class_info;

SELECT *
FROM class
INNER JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
NATURAL JOIN class_info;

INSERT INTO class VALUES
(14,'Sneha'),
(15,'Arjun');

INSERT INTO class_info VALUES
(16,'MUMBAI'),
(17,'DELHI');

SELECT *
FROM class
LEFT OUTER JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL;

SELECT *
FROM class
RIGHT OUTER JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;

SELECT *
FROM class
LEFT JOIN class_info
ON class.id = class_info.id

UNION

SELECT *
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id;