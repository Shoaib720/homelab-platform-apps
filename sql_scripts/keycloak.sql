-- Connect as the 'postgres' superuser or a user with CREATEDB privileges
-- Example: psql -U postgres -h <your-db-host> -p 5432

-- 1. Create a dedicated database for Keycloak
CREATE DATABASE keycloak;

ALTER DATABASE keycloak OWNER TO kcadmin;

-- 2. Create a dedicated user for Keycloak
CREATE USER kcadmin WITH ENCRYPTED PASSWORD 'lab-kcadmin-1999';

-- 3. Grant privileges to the user on the database
GRANT ALL PRIVILEGES ON DATABASE keycloak TO kcadmin;

GRANT kcadmin TO current_user WITH SET OPTION;

-- 4. (Optional but recommended) Create a schema owned by Keycloak
\connect keycloak;
CREATE SCHEMA IF NOT EXISTS keycloak AUTHORIZATION kcadmin;

-- 5. Grant schema privileges
ALTER ROLE kcadmin SET search_path TO keycloak, public;
GRANT ALL ON SCHEMA keycloak TO kcadmin;
