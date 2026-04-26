Feedback System (Java Full Stack Project)

This project is a simple web-based Feedback System built using Java technologies. It allows students to give feedback to teachers, while teachers and admin can view and manage the data. The application follows a basic MVC structure and demonstrates full-stack development using Servlets, JSP, and MySQL.

Technologies Used:
Frontend: HTML, CSS, JSP  
Backend: Java Servlets, JDBC  
Database: MySQL  
Server: Apache Tomcat  
Architecture: MVC (Model-View-Controller)

Project Structure:
The project is divided into backend Java code and frontend JSP pages.

- dao package handles database operations  
- servlet package contains controller logic  
- webapp folder contains JSP pages and configuration files  
- SQL file is used to create database and tables  

Main Features:
- User registration and login system  
- Role-based access (Admin, Teacher, Student)  
- Students can submit feedback  
- Teachers can view feedback  
- Admin can manage users  
- Feedback includes ratings and reviews  

Database Setup:
1. Open MySQL  
2. Run the SQL file provided in the project  
3. It will create:
   - users table (stores login and roles)  
   - feedback table (stores reviews and ratings)  

How to Run:
1. Import the project into Eclipse as a Dynamic Web Project  
2. Configure Apache Tomcat server  
3. Add MySQL JDBC driver  
4. Update database username and password in the code  
5. Run the project on server (Dont forget to add mysql connector jar files inside web-inf -> lib (i forgot it))
 

Default Admin Login:
Username: admin@email.com  
Password: admin123  

Future Improvements:
- Add better UI design  
- Convert to Spring Boot  
- Add REST APIs  
- Improve validation and security  
- Add analytics/dashboard  

This project is useful for understanding Java web development basics and can be included in a resume as a full-stack project.
