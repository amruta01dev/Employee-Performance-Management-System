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
-- 04. Time Periods
CREATE TABLE time_periods (
    period_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    period_start_date DATE NOT NULL,
    period_end_date DATE NOT NULL,
    month_number INTEGER NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter_number INTEGER NOT NULL,
    quarter_name VARCHAR(10) NOT NULL,
    year INTEGER NOT NULL,

    CONSTRAINT chk_period_dates CHECK (period_end_date >= period_start_date),
    CONSTRAINT chk_month_number CHECK (month_number BETWEEN 1 AND 12),
    CONSTRAINT chk_quarter_number CHECK (quarter_number BETWEEN 1 AND 4)
);
-- 05. Performance Ratings
CREATE TABLE performance_ratings (
    rating_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rating_value INTEGER NOT NULL UNIQUE,
    rating_label VARCHAR(100) NOT NULL,
    rating_description TEXT,

    CONSTRAINT chk_rating_value CHECK (rating_value BETWEEN 1 AND 5)
);
-- 06. Employees
CREATE TABLE employees (
    employee_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    date_of_birth DATE,
    gender VARCHAR(20),
    department_id INTEGER NOT NULL,
    job_title_id INTEGER NOT NULL,
    manager_id INTEGER,
    hire_date DATE NOT NULL,
    employment_status VARCHAR(30) NOT NULL DEFAULT 'Active',
    CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_employee_job_title FOREIGN KEY (job_title_id) REFERENCES job_titles(job_title_id),
    CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);
-- 07. Attendance
CREATE TABLE attendance (
    attendance_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    status_id INTEGER NOT NULL,
    attendance_date DATE NOT NULL,
    working_hours NUMERIC(5,2) NOT NULL DEFAULT 0,
    overtime_hours NUMERIC(5,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_attendance_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT fk_attendance_status FOREIGN KEY (status_id) REFERENCES attendance_status(status_id),
    CONSTRAINT uq_employee_attendance_date UNIQUE (employee_id, attendance_date),
    CONSTRAINT chk_working_hours CHECK (working_hours >= 0),
    CONSTRAINT chk_overtime_hours CHECK (overtime_hours >= 0)
);
-- 08. Performance Reviews
CREATE TABLE performance_reviews (
    review_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    period_id INTEGER NOT NULL,
    rating_id INTEGER NOT NULL,
    review_date DATE NOT NULL,
    manager_comments TEXT,
    CONSTRAINT fk_review_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT fk_review_period FOREIGN KEY (period_id) REFERENCES time_periods(period_id),
    CONSTRAINT fk_review_rating FOREIGN KEY (rating_id) REFERENCES performance_ratings(rating_id),
    CONSTRAINT uq_employee_review_period UNIQUE (employee_id, period_id)
);
-- 09. Productivity
CREATE TABLE productivity (
    productivity_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    period_id INTEGER NOT NULL,
    tasks_assigned INTEGER NOT NULL DEFAULT 0,
    tasks_completed INTEGER NOT NULL DEFAULT 0,
    target_tasks INTEGER NOT NULL DEFAULT 0,
    working_hours NUMERIC(7,2) NOT NULL DEFAULT 0,
    CONSTRAINT fk_productivity_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT fk_productivity_period FOREIGN KEY (period_id) REFERENCES time_periods(period_id),
    CONSTRAINT uq_employee_productivity_period UNIQUE (employee_id, period_id),
    CONSTRAINT chk_tasks_assigned CHECK (tasks_assigned >= 0),
    CONSTRAINT chk_tasks_completed CHECK (tasks_completed >= 0),
    CONSTRAINT chk_target_tasks CHECK (target_tasks >= 0),
    CONSTRAINT chk_productivity_working_hours CHECK (working_hours >= 0),
    CONSTRAINT chk_completed_not_greater_than_assigned CHECK (tasks_completed <= tasks_assigned)
);