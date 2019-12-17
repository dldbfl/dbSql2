CREATE TABLE regions(
    region_id NUMBER ,
    region_name VARCHAR2(25),
    CONSTRAINT REG_ID_PK PRIMARY KEY (region_id)
    );
    
    commit;
    
DROP TABLE regions;
DROP TABLE countries;
DROP TABLE locations;
DROP TABLE jobs;
DROP TABLE departments;
DROP TABLE employees;  
DROP TABLE job_history;  

    
CREATE TABLE countries (
    country_id CHAR(2) ,
    country_name VARCHAR2(40),
    region_id NUMBER ,
    CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY (country_id),
    CONSTRAINT COUNTR_REG_FK REFERENCES regions (region_id)
    );   

CREATE TABLE locations (
    location_id NUMBER(4) ,
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30) NOT NULL,
    state_province VARCHAR2(25),
    country_id CHAR(2),
    CONSTRAINT LOC_ID_PK PRIMARY KEY (location_id),
    CONSTRAINT LOC_C_ID_FK REFERENCES countries (country_id)
    
    );    
        
CREATE TABLE jobs (
    job_id VARCHAR2(10) ,
    job_title VARCHAR(35) NOT NULL,
    min_salary NUMBER(6),
    max_salary NUMBER(6),
    CONSTRAINT JOB_ID_PK PRIMARY KEY (job_id)
    );
        
CREATE TABLE departments (
    department_id NUMBER(4),
    department_name VARCHAR(30) NOT NULL,
    manager_id NUMBER(6),
    location_id NUMBER(4),
    CONSTRAINT DEPT_ID_PK PRIMARY KEY (department_id),
--    CONSTRAINT DEPT_MGR_FK FOREIGN KEY (manager_id) REFERENCES employees (employee_id), 이친구는 알터로
    CONSTRAINT DEPT_LOC_FK FOREIGN KEY (location_id) REFERENCES locations (location_id)
    
    );
        
CREATE TABLE employees (
    employee_id NUMBER(6),
    first_name VARCHAR2(20),
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(25) NOT NULL,
    phone_number VARCHAR2(20),
    hire_date date NOT NULL,
    job_id VARCHAR2(10),
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    manager_id NUMBER(6),
    department_id NUMBER(4),
    CONSTRAINT EMP_EMP_ID_PK PRIMARY KEY (employee_id),
    CONSTRAINT EMP_JOB_FK FOREIGN KEY (job_id) REFERENCES jobs (job_id),
    CONSTRAINT EMP_MANAGER_FK FOREIGN KEY (manager_id) REFERENCES employees (employee_id),
    CONSTRAINT EMP_DEPT_FK FOREIGN KEY (department_id) REFERENCES departments (department_id)
    );
         
CREATE TABLE job_history (
    employee_id  NUMBER(6),
    start_date DATE,
    end_date DATE NOT NULL,
    job_id VARCHAR2(10) NOT NULL,
    department_id NUMBER(4),
    CONSTRAINT JHIST_EMP_ID_ST_DATE_PK PRIMARY KEY (employee_id,start_date),
    CONSTRAINT JHIST_JOB_FK FOREIGN KEY (job_id) REFERENCES jobs (job_id),
    CONSTRAINT JHIST_DEPT_FK FOREIGN KEY (department_id) REFERENCES departments (department_id),
    CONSTRAINT JHIST_EMP_FK FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
    );
    
    

ALTER TABLE departments ADD CONSTRAINT DEPT_MGR_FK
                                        FOREIGN KEY(manager_id) REFERENCES employees(employee_id);    



select *
from user_constraints
where table_name IN ('LOCATIONS', 'JOB_HISTORY', 'JOBS', 'COUNTRIES', 'REGIONS', 'DEPARTMENTS', 'EMPLOYEES')
and constraint_type in ('P','R');
    
    