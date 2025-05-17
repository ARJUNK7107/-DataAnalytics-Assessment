
SELECT 
    p.id AS plan_id,
    p.owner_id,
    'investment' AS type,
    MAX(p.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(p.created_on)) AS inactivity_days
FROM plans_plan p
WHERE p.is_a_fund = 1
GROUP BY p.id, p.owner_id
HAVING inactivity_days > 365
UNION
SELECT   -- Savings Accounts with no transaction in last 365 days
    s.plan_id AS plan_id,
    s.owner_id,
    'savings' AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM savings_savingsaccount s
WHERE s.confirmed_amount IS NOT NULL
GROUP BY s.plan_id, s.owner_id
HAVING inactivity_days > 365;
