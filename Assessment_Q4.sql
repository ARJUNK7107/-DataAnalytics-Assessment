WITH customer_transactions AS (
    SELECT
        u.id AS customer_id,
        COALESCE(u.name, CONCAT(u.first_name, ' ', u.last_name)) AS name,
        COUNT(s.id) AS total_transactions,
        COALESCE(SUM(s.confirmed_amount), 0) AS total_amount,
        TIMESTAMPDIFF(MONTH, u.date_joined, NOW()) AS tenure_months
    FROM
        users_customuser u
    LEFT JOIN
        savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY
        u.id, u.name, u.first_name, u.last_name, u.date_joined
),
clv_calculation AS (
    SELECT
        customer_id,
        name,
        tenure_months,
        total_transactions,
        CASE
            WHEN tenure_months = 0 THEN 0
            ELSE ROUND(((total_transactions / tenure_months) * 12 * (0.001 * (total_amount / NULLIF(total_transactions, 0)))), 2)
        END AS estimated_clv
    FROM
        customer_transactions
)
SELECT
    customer_id,
    name,
    tenure_months,
    total_transactions,
    estimated_clv
FROM
    clv_calculation
ORDER BY
    estimated_clv DESC;
