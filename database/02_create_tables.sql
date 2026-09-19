-- 01. Departments
CREATE TABLE departments (
    department_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, --the text INTEGER GENERATED ALWAYS AS IDENTITY is used to automatically generate id for depratment
    department_name VARCHAR(50) NOT NULL UNIQUE,
    department_description TEXT,
    created_date DATE NOT NULL DEFAULT CURRENT_DATE  -- the CURRENT_DATE automatically inserte the todays date by default if not provided  
);

-- 02. Job Titles
CREATE TABLE job_titles (
    job_title_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    job_title_name VARCHAR(50) NOT NULL,
    job_level VARCHAR(50) NOT NULL
);


-- 03. Attendance Status
CREATE TABLE attendance_status (
    status_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    counts_as_present BOOLEAN NOT NULL DEFAULT FALSE,
    counts_as_working_day BOOLEAN NOT NULL DEFAULT TRUE
);

