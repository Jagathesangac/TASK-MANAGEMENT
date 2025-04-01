			-- create database
create database raja
	use raja
			-- create  user table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Manager', 'Employee') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
			-- create projects table
CREATE TABLE Projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    status ENUM('Not Started', 'In Progress', 'Completed') DEFAULT 'Not Started',
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);
			-- create tasks table
CREATE TABLE Tasks (
    task_id INT PRIMARY KEY AUTO_INCREMENT,
    task_name VARCHAR(255) NOT NULL,
    description TEXT,
    project_id INT,
    assigned_to INT,
    due_date DATE,
    priority ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (assigned_to) REFERENCES Users(user_id)
);
			-- create task_comments table
CREATE TABLE Task_Comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    task_id INT,
    user_id INT,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
			-- create task_history table
CREATE TABLE Task_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    task_id INT,
    updated_by INT,
    old_status ENUM('Pending', 'In Progress', 'Completed'),
    new_status ENUM('Pending', 'In Progress', 'Completed'),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id),
    FOREIGN KEY (updated_by) REFERENCES Users(user_id)
);
			-- create attachment table
CREATE TABLE Attachment (
    attachment_id INT PRIMARY KEY AUTO_INCREMENT,
    task_id INT,
    user_id INT,
    file_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES Tasks(task_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
			-- create notification table
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
			-- insert users values
INSERT INTO Users (name, email, password_hash, role) VALUES
('Alice Johnson', 'alice@example.com', 'hashed_password_1', 'Admin'),
('Bob Smith', 'bob@example.com', 'hashed_password_2', 'Manager'),
('Charlie Brown', 'charlie@example.com', 'hashed_password_3', 'Employee'),
('David Wilson', 'david@example.com', 'hashed_password_4', 'Employee'),
('Emma Davis', 'emma@example.com', 'hashed_password_5', 'Manager'),
('Frank Thomas', 'frank@example.com', 'hashed_password_6', 'Employee'),
('Grace Lee', 'grace@example.com', 'hashed_password_7', 'Admin'),
('Henry Martin', 'henry@example.com', 'hashed_password_8', 'Employee'),
('Isabella White', 'isabella@example.com', 'hashed_password_9', 'Manager'),
('Jack Harris', 'jack@example.com', 'hashed_password_10', 'Employee'),
('Karen Scott', 'karen@example.com', 'hashed_password_11', 'Manager'),
('Liam Young', 'liam@example.com', 'hashed_password_12', 'Employee'),
('Mia King', 'mia@example.com', 'hashed_password_13', 'Employee'),
('Noah Green', 'noah@example.com', 'hashed_password_14', 'Admin'),
('Olivia Adams', 'olivia@example.com', 'hashed_password_15', 'Employee');

			-- insert projects values
INSERT INTO Projects (project_name, description, start_date, end_date, status, created_by) VALUES
('Website Redesign', 'Revamping the corporate website for better UX', '2024-01-10', '2024-04-15', 'In Progress', 1),
('Mobile App Development', 'Developing a new mobile app for customer engagement', '2024-02-01', '2024-07-30', 'Not Started', 2),
('Marketing Campaign Q2', 'Running a digital marketing campaign for Q2', '2024-03-15', '2024-06-30', 'In Progress', 3),
('Data Migration', 'Migrating data to a secure cloud system', '2023-12-01', '2024-03-10', 'Completed', 4),
('Cybersecurity Audit', 'Assessing security vulnerabilities and risk factors', '2024-02-10', NULL, 'Not Started', 5),
('Employee Training Program', 'Training employees on the latest software tools', '2024-01-20', '2024-05-20', 'In Progress', 6),
('SEO Optimization', 'Improving search engine ranking through SEO strategies', '2024-02-15', '2024-06-01', 'In Progress', 7),
('Product Launch', 'Launching the company’s new product line', '2024-04-01', '2024-08-30', 'Not Started', 8),
('Office Relocation', 'Relocating the corporate office to a new location', '2024-03-01', '2024-06-30', 'Not Started', 9),
('E-commerce Integration', 'Integrating an online store into the website', '2024-03-10', '2024-09-10', 'In Progress', 10);

			-- insert tasks values
INSERT INTO Tasks (task_name, description, project_id, assigned_to, due_date, priority, status) VALUES
('Design Homepage', 'Create a new design for the homepage', 1, 3, '2024-03-10', 'High', 'In Progress'),
('Develop Backend API', 'Implement RESTful API for the mobile app', 2, 5, '2024-06-01', 'High', 'Pending'),
('SEO Audit', 'Analyze and improve website SEO', 7, 4, '2024-04-15', 'Medium', 'In Progress'),
('Data Backup', 'Ensure all company data is backed up before migration', 4, 6, '2024-02-20', 'High', 'Completed'),
('Security Assessment', 'Run penetration testing for vulnerabilities', 5, 7, '2024-05-01', 'High', 'Pending'),
('Marketing Strategy', 'Create marketing content for the Q2 campaign', 3, 8, '2024-04-01', 'Medium', 'Pending'),
('Employee Onboarding', 'Prepare training materials for new employees', 6, 9, '2024-03-20', 'Low', 'In Progress'),
('Product Packaging', 'Finalize the design of product packaging', 8, 10, '2024-07-10', 'Medium', 'Pending'),
('Office Setup', 'Arrange furniture and utilities in the new office', 9, 1, '2024-06-25', 'Medium', 'pending'),
('E-commerce Payment Integration', 'Implement secure payment gateway', 10, 2, '2024-08-15', 'High', 'In Progress');

			-- insert task_comments values
INSERT INTO Task_Comments (task_id, user_id, comment) VALUES
(21, 3, 'Initial homepage design draft is ready for review.'),
(22, 4, 'Great work! Please refine the color scheme.'),
(22, 5, 'Started working on the backend API authentication.'),
(22, 6, 'Make sure to include JWT authentication for security.'),
(23, 7, 'SEO audit report has been shared with the team.'),
(23, 8, 'We should focus more on keyword optimization.'),
(24, 6, 'Data backup process completed successfully.'),
(24, 9, 'Verified the backup files, everything looks good.'),
(25, 7, 'Security assessment tools are set up. Running tests now.'),
(25, 10, 'Check for any SQL injection vulnerabilities in the API.'),
(26, 8, 'Drafted a new strategy for Q2 marketing campaign.'),
(26, 9, 'Added more social media channels for outreach.'),
(27, 9, 'Training materials are almost finalized.'),
(27, 10, 'We need to add a section on remote work policies.'),
(28, 1, 'Product packaging design v1 is completed and shared.');

			-- insert task_history values
INSERT INTO Task_History (task_id, updated_by, old_status, new_status) VALUES
(21, 3, 'Pending', 'In Progress'),
(21, 4, 'In Progress', 'Completed'),
(22, 5, 'Pending', 'In Progress'),
(22, 6, 'In Progress', 'Completed'),
(23, 7, 'Pending', 'In Progress'),
(23, 8, 'In Progress', 'Completed'),
(24, 6, 'Pending', 'In Progress'),
(24, 9, 'In Progress', 'Completed'),
(25, 7, 'Pending', 'In Progress'),
(25, 10, 'In Progress', 'Completed')
			-- insert attachments values
INSERT INTO Attachments (task_id, user_id, file_path) VALUES
(21, 3, '/uploads/design/homepage_mockup_v1.png'),
(21, 4, '/uploads/design/homepage_colorscheme.pdf'),
(22, 5, '/uploads/backend/api_documentation.pdf'),
(22, 6, '/uploads/backend/database_schema.sql'),
(23, 7, '/uploads/seo/seo_audit_report.xlsx'),
(24, 6, '/uploads/data_backup/backup_logs.txt'),
(25, 7, '/uploads/security/security_test_results.pdf'),
(25, 10, '/uploads/security/firewall_config.json'),
(26, 8, '/uploads/marketing/q2_strategy_presentation.pptx'),
(27, 9, '/uploads/training/training_materials.zip');

			-- insert natification values
INSERT INTO Notifications (user_id, message, is_read) VALUES
(1, 'Your task "Design Homepage" has been marked as completed.', FALSE),
(2, 'A new task "Develop Backend API" has been assigned to you.', FALSE),
(3, 'Comment added to your task "SEO Audit" by user 8.', FALSE),
(4, 'Your project "Data Migration" has been successfully completed.', TRUE),
(5, 'Reminder: Task "Security Assessment" is due tomorrow.', FALSE),
(6, 'A new comment has been added to "Employee Onboarding".', FALSE),
(7, 'Your attachment for "SEO Audit Report" has been uploaded.', TRUE),
(8, 'Task "Marketing Strategy" status changed to In Progress.', FALSE),
(9, 'Your task "Product Packaging" has been assigned a high priority.', TRUE),
(10, 'The deadline for "E-commerce Payment Integration" is approaching.', FALSE);

			-- retrive all table values
select * from users
select * from projects
select * from tasks
select * from task_comments
select * from task_history
select * from attachments
select * from  notifications

		-- in clause(filter users in user_id)
select * from users where user_id in(1,9,12,15)

			-- limit clause(filter users in)
select * from users limit 8

						/*2.Logical Operators task_comments*/

			-- and clause(filter task_id and user_id)
select * from task_comments where task_id=22 and user_id=4

			-- or clause(filter 
select * from task_comments where comment_id=8 or comment_id=13

			-- not clause
select * from task_comments where not user_id=8

				/*3.Aggredate Function task_history*/

			-- count()
select(old_status)from task_history
			-- max()
select(history_id)from task_history
			-- min()
select(updated_by)from task_history
			-- sum()
select sum(history_id) from task_history
			-- avg()
select avg(task_id)from task_history

/*4.order by group by and having attachments*/

				-- order by
			-- asc
select * from  attachments order by task_id asc
			-- desc
select * from  attachments order by attachment_id desc
				-- group by
select count(attachment_id),task_id from attachments group by task_id
				-- having
select count(attachment_id),user_id from attachments group by user_id having count(attachment_id)>2

					/*5.joins projects and tasks*/

			-- inner join
select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
inner join tasks as b on a.project_id=b.task_id

			-- right join

select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
right join tasks as b on a.project_id=b.task_id

			-- left join

select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
left join tasks as b on a.project_id=b.task_id

			-- cross join

select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
cross join tasks as b on a.project_id=b.task_id

			-- self join

select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
 , tasks as b where a.project_id=b.task_id

					/*6.union and union all*/

			-- union

(select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
right join tasks as b on a.project_id=b.task_id)
union
(select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
left join tasks as b on a.project_id=b.task_id)

			-- union all

(select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
right join tasks as b on a.project_id=b.task_id)
union all
(select a.project_id,a.project_name,b.task_id,b.task_name
from projects as a
left join tasks as b on a.project_id=b.task_id)