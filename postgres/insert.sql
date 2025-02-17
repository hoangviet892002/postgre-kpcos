---------------------------------
-- Thêm dữ liệu vào bảng users --
---------------------------------

-- Guest
INSERT INTO users (email, password, full_name, phone, status)
VALUES 
('guest1@example.com', 'guest123', 'Guest One', '1234567890', 'Active'),
('guest2@example.com', 'guest123', 'Guest Two', '1234567891', 'Active');

-- Customer
INSERT INTO users (email, password, full_name, phone, status)
VALUES 
('customer1@example.com', 'customer123', 'Customer One', '1234567892', 'Active'),
('customer2@example.com', 'customer123', 'Customer Two', '1234567893', 'Active');

-- Consulting Staff
INSERT INTO users (email, password, full_name, phone, status)
VALUES 
('consulting1@example.com', 'consulting123', 'Consulting Staff One', '1234567894', 'Active'),
('consulting2@example.com', 'consulting123', 'Consulting Staff Two', '1234567895', 'Active');

-- Design Staff
INSERT INTO users (email, password, full_name, phone, status)
VALUES 
('design1@example.com', 'design123', 'Design Staff One', '1234567896', 'Active'),
('design2@example.com', 'design123', 'Design Staff Two', '1234567897', 'Active');

-- Construction Staff
INSERT INTO users (email, password, full_name, phone, status)
VALUES 
('construction1@example.com', 'construction123', 'Construction Staff One', '1234567898', 'Active'),
('construction2@example.com', 'construction123', 'Construction Staff Two', '1234567899', 'Active');

-- Manager
INSERT INTO users (email, password, full_name, phone, status)
VALUES 
('manager1@example.com', 'manager123', 'Manager One', '1234567800', 'Active'),
('manager2@example.com', 'manager123', 'Manager Two', '1234567801', 'Active');

-- Administrator
INSERT INTO users (email, password, full_name, phone, status)
VALUES 
('admin1@example.com', 'admin123', 'Administrator One', '1234567802', 'Active'),
('admin2@example.com', 'admin123', 'Administrator Two', '1234567803', 'Active');

-- Lấy ID của các Customer từ bảng users
WITH customer_users AS (
    SELECT id FROM users WHERE email LIKE 'customer%'
)
-- Thêm dữ liệu vào bảng customer
INSERT INTO customer (address, gender, user_id)
SELECT 
    '123 Customer Street, City, Country', 
    CASE WHEN RANDOM() < 0.5 THEN 'Male' ELSE 'Female' END, 
    id
FROM customer_users;

-- Lấy ID của các Staff từ bảng users
WITH staff_users AS (
    SELECT id, email FROM users WHERE email LIKE 'consulting%' OR email LIKE 'design%' OR email LIKE 'construction%' OR email LIKE 'manager%' OR email LIKE 'admin%'
)
-- Thêm dữ liệu vào bảng staff
INSERT INTO staff (position, user_id)
SELECT 
    CASE 
        WHEN email LIKE 'consulting%' THEN 'CONSULTANT' 
        WHEN email LIKE 'design%' THEN 'DESIGNER' 
        WHEN email LIKE 'construction%' THEN 'CONSTRUCTOR' 
        WHEN email LIKE 'manager%' THEN 'MANAGER' 
        ELSE 'ADMINISTRATOR'    
    END,
    id
FROM staff_users;



---------------------------------


