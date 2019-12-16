/* psql -U postgres -d postgres */

CREATE ROLE hw_sys  WITH LOGIN PASSWORD 'password';
CREATE ROLE hw_app  WITH LOGIN PASSWORD 'password';
CREATE ROLE hw_user WITH LOGIN PASSWORD 'password';

CREATE DATABASE holy_water;

GRANT CONNECT ON DATABASE holy_water TO hw_sys;
GRANT CONNECT ON DATABASE holy_water TO hw_app;
GRANT CONNECT ON DATABASE holy_water TO hw_user;
