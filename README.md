# -DataAnalytics-Assessment

-High-Value Customers with Multiple Products
Approach:
I identified customers who have both a funded savings plan (is_regular_savings = 1) and an investment plan (is_a_fund = 1). I used JOINs and GROUP BY to count product types and calculate total deposits from the confirmed_amount column. I filtered only those who had at least one of each type and sorted by total deposits.
Challenge:
Working with conditions from different plan types in one query was tricky, but combining aggregate functions with conditional filtering solved.

-Transaction Frequency Analysis
I started by calculating how many times each customer transacted per month by grouping their transactions by both customer and month.Then, I averaged those monthly transaction counts to get each customer's typical transaction activity.Based on that average, I categorized customers into three meaningful groups:
High Frequency – customers who make 10 or more transactions per month
Medium Frequency – those with 3 to 9 transactions per month
Low Frequency – customers who transact 2 or fewer times monthly
Finally, I counted how many customers fall into each group and also showed the average number of transactions for each group.

 – Account Inactivity Alert
Approach:
I looked at the last time each customer had a transaction.
For investment plans, I used the created_on date from the plans_plan table to check when the plan was last set up or updated.
For savings accounts, I used the transaction_date from the savings_savingsaccount table to find their most recent transaction.
Then, I calculated how many days have passed since that last activity. If it’s been more than 365 days, I flagged the account as inactive.
In the final result, I included the account ID (plan_id), who owns it (owner_id), whether it’s a savings or investment account, the date of the last activity, and how many days it's been inactive.

-Customer Lifetime Value (CLV) Estimation
 Approach:
I first gathered each customer's total number of savings transactions and the total confirmed transaction amount.
Then, I calculated their account tenure in months using their signup date.
CLV was estimated using the formula:
  CLV = (transactions per month) * 12 * average profit per transaction
where profit per transaction = 0.1% of transaction amount
To ensure the name isn't missing, I used the name field directly, or combined first_name and last_name when name was empty.
Finally, I ordered all customers by their estimated CLV (from highest to lowest) to identify the top value users.
