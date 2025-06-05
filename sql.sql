SELECT
    fullname,
    DATE_PART ('year', AGE (CURRENT_DATE, birthdate)) AS age,
    CASE
        WHEN job IS NULL THEN 'Безработный'
        ELSE job
    END,
    CASE
        WHEN organization IS NULL THEN '-'
        ELSE organization
    END,
    salary,
    SUM(expenses.count * products.price) AS total_price
FROM
    members
    LEFT JOIN member_jobs ON members.id = member_jobs.id_member
    LEFT JOIN expenses ON members.id = expenses.id_member
    LEFT JOIN products ON expenses.id_product = products.id
GROUP BY
    members.fullname,
    birthdate,
    member_jobs.job,
    member_jobs.organization,
    member_jobs.salary,
    members.id
ORDER BY
    members.id;