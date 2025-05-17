SELECT
    CASE
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM (
    SELECT
        owner_id,
        AVG(monthly_transaction_count) AS avg_transactions_per_month
    FROM (
        SELECT
            owner_id,
            YEAR(transaction_date) AS trans_year,
            MONTH(transaction_date) AS trans_month,
            COUNT(*) AS monthly_transaction_count
        FROM
            savings_savingsaccount
        GROUP BY
            owner_id, YEAR(transaction_date), MONTH(transaction_date)
    ) AS monthly_summary
    GROUP BY owner_id
) AS customer_summary
GROUP BY frequency_category
ORDER BY customer_count DESC;
