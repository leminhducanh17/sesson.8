SELECT COUNT(employee_id) AS number_of_employees
FROM Employees;
SELECT SUM(salary) AS total_monthly_salary
FROM Employees;
SELECT AVG(salary) AS average_salary
FROM Employees;
SELECT MAX(salary) AS highest_salary
FROM Employees;
SELECT MIN(salary) AS lowest_salary
FROM Employees;
SELECT MIN(hire_date) AS earliest_hire_date
FROM Employees;
SELECT SUM(salary) AS it_department_salary
FROM Employees
WHERE department = 'IT';
