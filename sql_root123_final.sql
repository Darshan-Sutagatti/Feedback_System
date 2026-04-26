drop database feedback_system;
CREATE DATABASE feedback_system;
USE feedback_system;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(50),
    role VARCHAR(20),
    usn VARCHAR(20),
    subject VARCHAR(50)
);

CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    teacher_id INT,
    review TEXT,
    rating INT,
    UNIQUE(student_id, teacher_id)
);

-- admin
INSERT INTO users(username,password,role) VALUES('admin@email.com','admin123','admin');

