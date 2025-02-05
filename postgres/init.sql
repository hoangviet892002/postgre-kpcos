-- table creation
-- Guid id
-- created_at, updated_at, deleted_at, id, 

-- database for chat app


-- Tạo bảng Role
CREATE TABLE Role (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE, 
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    CONSTRAINT check_role_active_deleted CHECK (deleted_at IS NULL OR is_active = FALSE)
);

CREATE INDEX idx_role_name ON Role (name);


 -- Tạo trigger tự động cập nhật updated_at cho bảng Role
CREATE OR REPLACE FUNCTION update_role_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER role_updated_at_trigger
BEFORE UPDATE ON Role
FOR EACH ROW
EXECUTE FUNCTION update_role_updated_at();

-- Tạo bảng User
CREATE TABLE "User"  (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    fullname VARCHAR(255) NOT NULL,
    birthdate DATE,
    address TEXT,
    gender VARCHAR,
    avatar TEXT DEFAULT 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaotZTcu1CLMGOJMDl-f_LYBECs7tqwhgpXA&s', 
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role_id UUID NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Role(id) ON DELETE CASCADE,
    CONSTRAINT check_user_active_deleted CHECK (deleted_at IS NULL OR is_active = FALSE)
);

-- Tạo trigger tự động cập nhật updated_at cho bảng User
CREATE OR REPLACE FUNCTION update_user_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_updated_at_trigger
BEFORE UPDATE ON "User"
FOR EACH ROW
EXECUTE FUNCTION update_user_updated_at();

-- Tạo chỉ mục để tăng hiệu suất truy vấn cho bảng User
CREATE INDEX idx_user_fullname ON "User" (fullname);
CREATE INDEX idx_user_email ON "User" (email);
CREATE INDEX idx_user_role_id ON "User" (role_id);

-- table customer
CREATE table customer(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    point INT DEFAULT 0,
    user_id UUID NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "User"(id) ON DELETE CASCADE,
    CONSTRAINT check_customer_active_deleted CHECK (deleted_at IS NULL OR is_active = FALSE)
);
CREATE INDEX idx_customer_user_id ON customer (user_id);

CREATE OR REPLACE FUNCTION create_customer()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the role is 'CUSTOMER' by querying the Role table
    IF NEW.role_id = (SELECT id FROM Role WHERE name = 'CUSTOMER') THEN
        -- Insert into the customer table
        INSERT INTO customer (user_id) VALUES (NEW.id);
    END IF;

    -- Return the new row for the insert to proceed
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for AFTER INSERT on "User" table
CREATE TRIGGER create_customer_trigger
AFTER INSERT ON "User"
FOR EACH ROW
EXECUTE FUNCTION create_customer();

-- table service
CREATE TABLE service(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price INT,
    unit VARCHAR(255),
    type INT,
    CONSTRAINT check_service_active_deleted CHECK (deleted_at IS NULL OR is_active = FALSE)
);

CREATE INDEX idx_service_name ON service (name);

-- table package 
CREATE TABLE package(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    name VARCHAR(255) NOT NULL,
    rate INT,
    description TEXT,
    price INT,
    CONSTRAINT check_package_active_deleted CHECK (deleted_at IS NULL OR is_active = FALSE),
    CONSTRAINT check_package_rate CHECK (rate >= 0 AND rate <= 10)
);


CREATE INDEX idx_package_name ON package (name);

-- table package_service
CREATE TABLE package_service(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    price INT,
    category INT,
    quantity INT,
    amount INT,
    package_id UUID NOT NULL,
    service_id UUID NOT NULL,
    FOREIGN KEY (package_id) REFERENCES package(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES service(id) ON DELETE CASCADE,
    CONSTRAINT check_package_service_active_deleted CHECK (deleted_at IS NULL OR is_active = FALSE)
);

CREATE INDEX idx_package_service_package_id ON package_service (package_id);
CREATE INDEX idx_package_service_service_id ON package_service (service_id);






