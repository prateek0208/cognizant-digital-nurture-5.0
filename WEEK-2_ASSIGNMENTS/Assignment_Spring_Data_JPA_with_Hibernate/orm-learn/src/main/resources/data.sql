-- Countries
INSERT INTO country (code, name) VALUES ('IN', 'India');
INSERT INTO country (code, name) VALUES ('US', 'United States of America');
INSERT INTO country (code, name) VALUES ('BV', 'Bouvet Island');
INSERT INTO country (code, name) VALUES ('DJ', 'Djibouti');
INSERT INTO country (code, name) VALUES ('TF', 'French Southern Territories');
INSERT INTO country (code, name) VALUES ('GP', 'Guadeloupe');
INSERT INTO country (code, name) VALUES ('LU', 'Luxembourg');
INSERT INTO country (code, name) VALUES ('ZA', 'South Africa');
INSERT INTO country (code, name) VALUES ('GS', 'South Georgia');
INSERT INTO country (code, name) VALUES ('SS', 'South Sudan');
INSERT INTO country (code, name) VALUES ('ZM', 'Zambia');
INSERT INTO country (code, name) VALUES ('ZW', 'Zimbabwe');

-- Departments
INSERT INTO department (id, name) VALUES (1, 'IT');
INSERT INTO department (id, name) VALUES (2, 'HR');
INSERT INTO department (id, name) VALUES (3, 'Finance');

-- Skills
INSERT INTO skill (id, name) VALUES (1, 'Java');
INSERT INTO skill (id, name) VALUES (2, 'Spring');
INSERT INTO skill (id, name) VALUES (3, 'SQL');

-- Employees
INSERT INTO employee (id, name, salary, permanent, date_of_birth, dp_id) VALUES (1, 'John Doe', 50000.0, true, '1990-01-01', 1);
INSERT INTO employee (id, name, salary, permanent, date_of_birth, dp_id) VALUES (2, 'Jane Smith', 60000.0, true, '1985-05-15', 1);
INSERT INTO employee (id, name, salary, permanent, date_of_birth, dp_id) VALUES (3, 'Bob Brown', 45000.0, false, '1992-10-20', 2);

-- Employee Skills
INSERT INTO employee_skill (es_em_id, es_sk_id) VALUES (1, 1);
INSERT INTO employee_skill (es_em_id, es_sk_id) VALUES (1, 2);
INSERT INTO employee_skill (es_em_id, es_sk_id) VALUES (2, 3);

-- Stocks
INSERT INTO stock (st_code, st_date, st_open, st_close, st_volume) VALUES ('FB', '2019-09-03', 184.00, 182.39, 9779400);
INSERT INTO stock (st_code, st_date, st_open, st_close, st_volume) VALUES ('FB', '2019-09-04', 184.65, 187.14, 11308000);
INSERT INTO stock (st_code, st_date, st_open, st_close, st_volume) VALUES ('GOOGL', '2019-04-22', 1236.67, 1253.76, 954200);
INSERT INTO stock (st_code, st_date, st_open, st_close, st_volume) VALUES ('GOOGL', '2019-04-23', 1256.64, 1270.59, 1593400);
INSERT INTO stock (st_code, st_date, st_open, st_close, st_volume) VALUES ('NFLX', '2018-12-24', 242.00, 233.88, 9547600);

-- Quiz Tables
INSERT INTO user (id, name) VALUES (1, 'Admin');
INSERT INTO attempt (id, date, user_id, score) VALUES (1, '2023-10-01', 1, 1.0);
INSERT INTO question (id, text) VALUES (1, 'What is the extension of the hyper text markup language file?');
INSERT INTO options (id, question_id, text, score) VALUES (1, 1, '.xhtm', 0.0);
INSERT INTO options (id, question_id, text, score) VALUES (2, 1, '.html', 1.0);
INSERT INTO attempt_question (id, attempt_id, question_id) VALUES (1, 1, 1);
INSERT INTO attempt_option (id, attempt_id, option_id, selected) VALUES (1, 1, 2, true);
