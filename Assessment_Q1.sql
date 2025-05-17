SELECT u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT s.id) AS savings_count,( SELECT COUNT(*) FROM plans_plan p2 WHERE p2.owner_id = u.id AND p2.is_a_fund = 1) AS investment_count,
    SUM(s.confirmed_amount) / 100.0 AS total_deposits
FROM 
    users_customuser u 
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
JOIN 
    plans_plan p ON s.plan_id = p.id
WHERE 
    p.is_regular_savings = 1
    AND EXISTS (
        SELECT 1 
        FROM plans_plan p2 
        WHERE p2.owner_id = u.id AND p2.is_a_fund = 1
    )
GROUP BY 
    u.id, u.first_name, u.last_name
ORDER BY 
    total_deposits DESC;
