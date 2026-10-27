use banking_analytics;

/*----K1- Total Credit Amount: ----*/
SELECT 
    SUM(amount) AS Total_Credit_Amount
FROM debit_credit_data
WHERE transaction_type = 'Credit';

/*----K2-Total Debit Amount ----*/
SELECT 
    SUM(amount) AS Total_Debit_Amount
FROM debit_credit_data
WHERE transaction_type = 'Debit';

/*----K3-Credit to Debit Ratio ----*/
SELECT 
    SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END) /
    SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END) 
    AS Credit_to_Debit_Ratio
FROM debit_credit_data;

/*----K4- Net Transaction Amount ----*/
SELECT 
    SUM(CASE 
            WHEN transaction_type = 'Credit' THEN amount
            WHEN transaction_type = 'Debit' THEN -amount
            ELSE 0
        END) AS Net_Transaction_Amount
FROM debit_credit_data;

/*----K5 -Account Activity Ratio ----*/
SELECT 
    `account_number`,
    COUNT(*) AS Number_of_Transactions,
    MAX(balance) AS Account_Balance,
    COUNT(*) / NULLIF(MAX(balance), 0) AS Account_Activity_Ratio
FROM debit_credit_data
GROUP BY `account_number`;

/* you can use this qurey also for same KPI-

WITH ranked AS (
    SELECT 
        `account_number`,
        balance,
        ROW_NUMBER() OVER (
            PARTITION BY `account_number`
            ORDER BY `transaction_date` DESC
        ) AS rn
    FROM debit_credit_data
)
SELECT 
    d.`account_number`,
    COUNT(*) AS Number_of_Transactions,
    r.balance AS Account_Balance,
    COUNT(*) / NULLIF(r.balance, 0) AS Account_Activity_Ratio
FROM debit_credit_data d
JOIN ranked r
    ON d.`account_number` = r.`account_number`
   AND r.rn = 1
GROUP BY d.`account_number`, r.balance;    ---*/


/*----KPI-6 -Transactions per Day/Week/Month---*/
/*--Transactions per Day--*/
SELECT 
    DATE(`transaction_date`) AS Transaction_Day,
    COUNT(*) AS Number_of_Transactions
FROM debit_credit_data
GROUP BY DATE(`transaction_date`)
ORDER BY Transaction_Day;

/*--Transactions per week--*/
SELECT 
    YEAR(`transaction_date`) AS Transaction_Year,
    WEEK(`transaction_date`) AS Transaction_Week,
    COUNT(*) AS Number_of_Transactions
FROM debit_credit_data
GROUP BY 
    YEAR(`transaction_date`),
    WEEK(`transaction_date`)
ORDER BY 
    Transaction_Year,
    Transaction_Week;

/*--Transactions per Month--*/
SELECT 
    YEAR(`transaction_date`) AS Transaction_Year,
    MONTH(`transaction_date`) AS Transaction_Month,
    COUNT(*) AS Number_of_Transactions
FROM debit_credit_data
GROUP BY 
    YEAR(`transaction_date`),
    MONTH(`transaction_date`)
ORDER BY 
    Transaction_Year,
    Transaction_Month;
    
  
  
  /*----KPI-7-Total Transaction Amount by Branch---*/
  
  SELECT 
    Branch,
    SUM(amount) AS Total_Transaction_Amount
FROM debit_credit_data
GROUP BY Branch
ORDER BY Total_Transaction_Amount DESC;