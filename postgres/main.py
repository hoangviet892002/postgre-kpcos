import json
import psycopg2

# Database connection settings
DB_HOST = "34.81.244.146"
DB_PORT = "5432"
DB_USER = "root"
DB_PASSWORD = "exevipvl"
DB_NAME = "exe201"

# Load data from JSON file
file_path = './vietnam-banks.json'
with open(file_path, 'r', encoding='utf-8') as file:
    data = json.load(file)['banksnapas']

# Establish database connection
conn = psycopg2.connect(
    host=DB_HOST,
    port=DB_PORT,
    user=DB_USER,
    password=DB_PASSWORD,
    dbname=DB_NAME
)
cursor = conn.cursor()

# SQL to create the table with snake_case naming convention
create_table_query = '''
CREATE TABLE IF NOT EXISTS banks (
    id SERIAL PRIMARY KEY,
    en_name VARCHAR(255),
    vn_name VARCHAR(255),
    bank_id VARCHAR(50) UNIQUE,
    atm_bin VARCHAR(50),
    card_length INT,
    short_name VARCHAR(50),
    bank_code VARCHAR(50)
);
'''
cursor.execute(create_table_query)

# SQL to insert data into the table
insert_query = '''
INSERT INTO banks (en_name, vn_name, bank_id, atm_bin, card_length, short_name, bank_code)
VALUES (%s, %s, %s, %s, %s, %s, %s)

'''

# Insert each entry in the JSON file
for bank in data:
    cursor.execute(insert_query, (
        bank.get('en_name'),
        bank.get('vn_name'),
        bank.get('bankId'),
        bank.get('atmBin'),
        bank.get('cardLength'),
        bank.get('shortName'),
        bank.get('bankCode')
    ))

# Commit changes and close the connection
conn.commit()
cursor.close()
conn.close()

print("Data has been successfully inserted into the banks table.")
