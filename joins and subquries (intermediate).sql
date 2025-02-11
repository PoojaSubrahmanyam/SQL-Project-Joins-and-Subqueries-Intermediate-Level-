/*Find employees earning above their department’s average salary.*/
SELECT 
    e.emp_id, e.emp_name, e.department_id, e.salary
FROM
    employees e
WHERE
    e.salary > (SELECT 
            AVG(e1.salary)
        FROM
            employees e1
        GROUP BY e1.department_id
        HAVING e.department_id = e1.department_id)
ORDER BY e.department_id ASC

/*List employees who do not earn the highest salary in their department.*/
SELECT 
    e.emp_id, e.emp_name, e.department_id, e.salary
FROM
    employees e
WHERE
    e.salary NOT IN (SELECT 
            MAX(e1.salary)
        FROM
            employees e1
        GROUP BY e1.department_id);

/*Get employees earning more than the highest-paid HR employee.*/
SELECT 
    E1.emp_name, E1.SALARY
FROM
    EMPLOYEES E1
WHERE
    E1.salary > (SELECT 
            MAX(e.salary)
        FROM
            employees e
                JOIN
            departments d ON e.department_id = d.department_id
        WHERE
            d.department_name = 'HR');

/*Retrieve employees who have a salary higher than Bob but work in a different department.
salery >bob
emp dep<> bob dep*/
SELECT 
    E1.EMP_NAME, E1.SALARY, E1.department_id
FROM
    employees E1
WHERE
    E1.SALARY > (SELECT 
            E.SALARY
        FROM
            EMPLOYEES E
        WHERE
            E.EMP_NAME = 'Bob')
        AND E1.DEPARTMENT_ID <> (SELECT 
            E.DEPARTMENT_ID
        FROM
            employees E
        WHERE
            e.emp_name = 'Bob');

/*Find employees who work in a department that has more than two employees.*/
SELECT 
    e1.emp_id, e1.department_id
FROM
    employees e1
        JOIN
    (SELECT 
        e.department_id
    FROM
        employees e
    GROUP BY e.department_id
    HAVING COUNT(e.emp_id) > 2) AS dept_count ON e1.department_id = dept_count.department_id
ORDER BY e1.department_id;
/*Get projects handled by employees who earn the highest salary in their department.*/
SELECT 
    p.emp_id,
    p.department_id,
    p.project_name,
    highsal_emp.salary
FROM
    projects p
        JOIN
    (SELECT 
        e.emp_id, e.department_id, e.salary
    FROM
        employees e
    WHERE
        e.salary = (SELECT 
                MAX(e1.salary)
            FROM
                employees e1
            WHERE
                e.department_id = e1.department_id)) AS highsal_emp ON p.department_id = highsal_emp.department_id
ORDER BY highsal_emp.department_id;
/*List the employees who were hired before all employees in Finance.*/
select e1.emp_id,e1.hire_date from employees e1 where e1.hire_date< (SELECT 
    MIN(e.hire_date)
FROM
    employees e
WHERE
    e.department_id = (SELECT 
            d.department_id
        FROM
            departments d
        WHERE
            department_name = 'finance'));
/*Find employees who receive a salary greater than at least one IT employee.*/
SELECT 
    e1.emp_id, e1.department_id, e1.emp_name, e1.salary
FROM
    employees e1
WHERE
    e1.salary > (SELECT 
            MIN(e.salary)
        FROM
            employees e
        WHERE
            e.department_id = (SELECT 
                    d.department_id
                FROM
                    departments d
                WHERE
                    department_name = 'IT') ) and e1.department_id<>(SELECT 
                    d.department_id
                FROM
                    departments d
                WHERE
                    department_name = 'IT');











        







                  




