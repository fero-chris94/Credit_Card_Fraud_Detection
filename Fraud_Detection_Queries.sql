-- Explore the data

-- 1. View the first 10 rows of the dataset
SELECT TOP 10 *
FROM fraudTrain;

-- 2. Calculate the total number of transactions
SELECT
    COUNT(*) AS total_transactions
FROM fraudTrain;

-- 3. Calculate the total number of fraudulent transactions
SELECT
    COUNT(*) AS total_fraudulent_transactions
FROM fraudTrain
WHERE is_fraud = 1;

-- 4. Calculate the average transaction amount
SELECT
    AVG(amt) AS average_transaction_amount
FROM fraudTrain;

-- 5. Identify the top 5 merchants with the highest transaction amounts
SELECT TOP 5
    merchant,
    SUM(amt) AS total_transaction_amount
FROM fraudTrain
GROUP BY merchant
ORDER BY total_transaction_amount DESC;

-- 6. Determine the most common transaction category
SELECT TOP 1
    category,
    COUNT(*) AS category_count
FROM fraudTrain
GROUP BY category
ORDER BY category_count DESC;

-- 7. Calculate the average transaction amount for each category
SELECT
    category,
    AVG(amt) AS average_transaction_amount
FROM fraudTrain
GROUP BY category
ORDER BY average_transaction_amount DESC;

-- 8. Identify the gender distribution of transactions
SELECT
    gender,
    COUNT(*) AS gender_count
FROM fraudTrain
GROUP BY gender;

-- 9. Determine the average city population for fraudulent transactions
SELECT
    AVG(city_pop) AS average_city_population_fraudulent
FROM fraudTrain
WHERE is_fraud = 1;

-- 10. Find the age distribution of individuals involved in transactions
SELECT
    FLOOR(DATEDIFF(YEAR, dob, GETDATE())) AS age,
    COUNT(*) AS age_group_count
FROM fraudTrain
GROUP BY FLOOR(DATEDIFF(YEAR, dob, GETDATE()))
ORDER BY age;


-- 11. Calculate the total transaction amount per state
SELECT
    state,
    SUM(amt) AS total_transaction_amount
FROM fraudTrain
GROUP BY state
ORDER BY total_transaction_amount DESC;

-- 12. Identify the most common occupations of individuals involved in transactions
SELECT TOP 5
    job,
    COUNT(*) AS job_count
FROM fraudTrain
GROUP BY job
ORDER BY job_count DESC;

-- 13. Determine the average transaction amount for each gender
SELECT
    gender,
    AVG(amt) AS average_transaction_amount
FROM fraudTrain
GROUP BY gender;

-- 14. Find the peak transaction hours during the day
SELECT TOP 5
    DATEPART(HOUR, trans_date_trans_time) AS transaction_hour,
    COUNT(*) AS transaction_count
FROM fraudTrain
GROUP BY DATEPART(HOUR, trans_date_trans_time)
ORDER BY transaction_count DESC;


-- 15. Identify transactions with amounts above a certain threshold
SELECT
    *
FROM fraudTrain
WHERE amt > 500;

-- 16. Calculate the average transaction amount for POS and .NET transactions
SELECT
    transaction_type,
    AVG(amt) AS average_transaction_amount
FROM (
    SELECT
        *,
        CASE
            WHEN category IN ('grocery_pos', 'shopping_pos', 'misc_pos') THEN 'Positive'
            WHEN category IN ('grocery_net', 'shopping_net', 'misc_net') THEN 'Negative'
            ELSE 'Other'
        END AS transaction_type
    FROM fraudTrain
) AS categorized_transactions
GROUP BY transaction_type;

-- 17. Identify transactions with unusually high latitudes or longitudes
SELECT
    *
FROM fraudTrain
WHERE lat > 50 OR long < -120;

-- 18. Determine the average transaction amount for each merchant
SELECT
    merchant,
    AVG(amt) AS average_transaction_amount
FROM fraudTrain
GROUP BY merchant
ORDER BY average_transaction_amount DESC;

-- 19. Find transactions with duplicate transaction numbers
SELECT
    trans_num,
    COUNT(*) AS duplicate_count
FROM fraudTrain
GROUP BY trans_num
HAVING COUNT(*) > 1;

-- 20. Identify transactions where the merchant is also the first or last name of the individual
SELECT
    *
FROM fraudTrain
WHERE merchant = first OR merchant = last;
