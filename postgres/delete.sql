CREATE OR REPLACE FUNCTION drop_all_tables() RETURNS void AS $$
DECLARE
    table_name text;
BEGIN
    -- Disable triggers to avoid issues with foreign keys
    SET session_replication_role = 'replica';

    -- Loop through all tables in the current schema
    FOR table_name IN (SELECT tablename FROM pg_tables WHERE schemaname = current_schema()) LOOP
        EXECUTE 'DROP TABLE IF EXISTS "' || table_name || '" CASCADE';
    END LOOP;

    -- Re-enable triggers
    SET session_replication_role = 'origin';
END;
$$ LANGUAGE plpgsql;
SELECT drop_all_tables()