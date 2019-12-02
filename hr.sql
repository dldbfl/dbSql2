--join8 
select * FROM countries;
select * From regions;

SELECT regions.region_id, region_name, country_name
FROM regions, countries 
WHERE regions.region_id = countries.region_id 
AND region_name IN ('Europe');
    
--join9 
--8번과 비교해서 France, Denmark, Belgium 3개 국가에 속하는 locations 정보가 미존재
--나머지 5개중에 다수의 locations 정보를 갖고있는 국가가 존재해오..
select * from locations;

SELECT regions.region_id, region_name, country_name, city
FROM regions, countries, locations
WHERE regions.region_id = countries.region_id
AND countries.COUNTRY_ID = LOCATIONS.country_id 
AND region_name IN ('Europe');
    
--join10  
select * from DEPARTMENTS;

SELECT regions.region_id, region_name, country_name, city, departments.DEPARTMENT_NAME
FROM regions, countries, locations, departments
WHERE regions.region_id = countries.region_id
AND countries.COUNTRY_ID = LOCATIONS.country_id 
AND locations.location_id = departments.location_id
AND region_name IN ('Europe');
    
--join11
select * from employees;

SELECT regions.region_id, region_name, country_name, city, departments.DEPARTMENT_NAME, (employees.FIRST_NAME||employees.LAST_NAME) name
FROM regions, countries, locations, departments,employees
WHERE regions.region_id = countries.region_id
AND countries.COUNTRY_ID = LOCATIONS.country_id 
AND locations.location_id = departments.location_id
AND departments.DEPARTMENT_ID = employees.DEPARTMENT_ID
AND region_name IN ('Europe');

--join12
select * from jobs;

SELECT employee_id,(employees.first_name||employees.last_name) name, jobs.job_id, job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id;

--join13
select * from employees;
select * from jobs; 

SELECT m.manager_id mng_id,(e.first_name||e.last_name) mgr_name ,m.employee_id,(m.first_name||m.last_name) name, jobs.job_id, job_title
FROM employees e, employees m,jobs
WHERE m.job_id = jobs.job_id
AND m.manager_id = e.employee_id
ORDER BY mng_id;