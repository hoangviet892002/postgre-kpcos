-- data insertion
-- roles ADMINS, CONSULTOR, DESIGNER, MANAGER, CUSTOMER, CONSTRUCTOR
INSERT INTO Role (name, description) VALUES ('ADMINS', 'Administrators');
INSERT INTO Role (name, description) VALUES ('CONSULTOR', 'Consultants');
INSERT INTO Role (name, description) VALUES ('DESIGNER', 'Designers');
INSERT INTO Role (name, description) VALUES ('MANAGER', 'Managers');
INSERT INTO Role (name, description) VALUES ('CUSTOMER', 'Customers');
INSERT INTO Role (name, description) VALUES ('CONSTRUCTOR', 'Constructors');

-- Inserting Users

-- Admin user
INSERT INTO "User" (fullname, birthdate, address, gender, password, email, role_id)
VALUES ('Admin', '1990-01-01', 'Hanoi', 'MALE', '123456', 'admin@mail.com', (SELECT id FROM Role WHERE name = 'ADMINS'));

-- Consultor user
INSERT INTO "User" (fullname, birthdate, address, gender, password, email, role_id)
VALUES ('Consultor', '1990-01-01', 'Hanoi', 'MALE', '123456', 'consultants@mail.com', (SELECT id FROM Role WHERE name = 'CONSULTOR'));

-- Designer user
INSERT INTO "User" (fullname, birthdate, address, gender, password, email, role_id)
VALUES ('Designer User', '1992-05-20', 'Saigon', 'FEMALE', '123456', 'designer@mail.com', (SELECT id FROM Role WHERE name = 'DESIGNER'));

-- Manager user
INSERT INTO "User" (fullname, birthdate, address, gender, password, email, role_id)
VALUES ('Manager User', '1985-07-15', 'Da Nang', 'FEMALE', '123456', 'manager@mail.com', (SELECT id FROM Role WHERE name = 'MANAGER'));

-- Customer user
INSERT INTO "User" (fullname, birthdate, address, gender, password, email, role_id)
VALUES ('Customer User', '2000-10-10', 'Hai Phong', 'MALE', '123456', 'customer@mail.com', (SELECT id FROM Role WHERE name = 'CUSTOMER'));

-- Constructor user
INSERT INTO "User" (fullname, birthdate, address, gender, password, email, role_id)
VALUES ('Constructor User', '1988-02-28', 'Hue', 'MALE', '123456', 'constructor@mail.com', (SELECT id FROM Role WHERE name = 'CONSTRUCTOR'));
