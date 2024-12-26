-- table creation
-- Guid id
-- created_at, updated_at, deleted_at
CREATE EXTENSION IF NOT EXISTS pgcrypto;

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


-- -- Tạo trigger tự động cập nhật updated_at cho bảng Role
-- CREATE OR REPLACE FUNCTION update_role_updated_at()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     NEW.updated_at = CURRENT_TIMESTAMP;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE TRIGGER role_updated_at_trigger
-- BEFORE UPDATE ON Role
-- FOR EACH ROW
-- EXECUTE FUNCTION update_role_updated_at();

-- Tạo bảng User
CREATE TABLE "User"  (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role_id UUID NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Role(id) ON DELETE CASCADE,
    CONSTRAINT check_user_active_deleted CHECK (deleted_at IS NULL OR is_active = FALSE)
);

-- Tạo trigger tự động cập nhật updated_at cho bảng User
-- CREATE OR REPLACE FUNCTION update_user_updated_at()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     NEW.updated_at = CURRENT_TIMESTAMP;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE TRIGGER user_updated_at_trigger
-- BEFORE UPDATE ON User
-- FOR EACH ROW
-- EXECUTE FUNCTION update_user_updated_at();

-- Tạo chỉ mục để tăng hiệu suất truy vấn cho bảng User
CREATE INDEX idx_user_username ON "User" (username);
CREATE INDEX idx_user_email ON "User" (email);
CREATE INDEX idx_user_role_id ON "User" (role_id);

-- data insertion
-- roles ADMINS, CONSULTOR, DESIGNER, MANAGER, CUSTOMER, CONSTRUCTOR
INSERT INTO Role (name, description) VALUES ('ADMINS', 'Administrators');
INSERT INTO Role (name, description) VALUES ('CONSULTOR', 'Consultants');
INSERT INTO Role (name, description) VALUES ('DESIGNER', 'Designers');
INSERT INTO Role (name, description) VALUES ('MANAGER', 'Managers');
INSERT INTO Role (name, description) VALUES ('CUSTOMER', 'Customers');
INSERT INTO Role (name, description) VALUES ('CONSTRUCTOR', 'Constructors');

-- users
INSERT INTO "User" (username, password, email, role_id) VALUES ('admin', 'admin', 'admin@mail.com', (SELECT id FROM Role WHERE name = 'ADMINS'));
INSERT INTO "User" (username, password, email, role_id) VALUES ('consultor', 'consultor', 'consultor@mail.com', (SELECT id FROM Role WHERE name = 'CONSULTOR'));
INSERT INTO "User" (username, password, email, role_id) VALUES ('designer', 'designer', 'designer@mail.com', (SELECT id FROM Role WHERE name = 'DESIGNER'));
INSERT INTO "User" (username, password, email, role_id) VALUES ('manager', 'manager', 'manager@mail.com'	, (SELECT id FROM Role WHERE name = 'MANAGER'));
INSERT INTO "User" (username, password, email, role_id) VALUES ('customer', 'customer', 'customer@mail.com'	, (SELECT id FROM Role WHERE name = 'CUSTOMER'));
INSERT INTO "User" (username, password, email, role_id) VALUES ('constructor', 'constructor', 'constructor', (SELECT id FROM Role WHERE name = 'CONSTRUCTOR'));
