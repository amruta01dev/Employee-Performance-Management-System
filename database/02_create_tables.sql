-- 01. Departments
CREATE TABLE departments (
    department_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, --the text INTEGER GENERATED ALWAYS AS IDENTITY is used to automatically generate id for depratment
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_description TEXT,
    created_date DATE NOT NULL DEFAULT CURRENT_DATE  -- the CURRENT_DATE automatically inserte the todays date by default if not provided  
);