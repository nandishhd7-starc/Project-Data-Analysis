use banking_analytics;

/*---KPI 1 - Total Loan Amount Funded: Measures the total value of loans disbursed.--------*/
SELECT SUM(`funded_amount`) AS Total_Loan_Amount_Funded
FROM banking_data;

/*---KPI 2 - Total Loans: Tracks the number of loans issued-------*/
SELECT COUNT(DISTINCT `account_id`) AS Total_Loans
FROM banking_data;

/*---K3-Total Collection: Reflects repayment performance, including principal and interest.---*/
SELECT SUM(`total_pymnt`) AS Total_Collection
FROM banking_data;

/*---K4 -Total Interest: Captures revenue from loan interest. --*/
SELECT SUM(`total_rec_int`) AS Total_Interest
FROM banking_data;

/*---K5 - Branch-Wise Performance: Analyzes revenue (interest, fees, total) by branch. --*/
SELECT
    `branch_name`,
    SUM(`total_rec_int`) AS Interest_Revenue,
    SUM(`total_fees`) AS Fee_Revenue,
    SUM(`total_rec_int`) + SUM(`total_fees`) AS Total_Revenue
FROM banking_data
GROUP BY `branch_name`
ORDER BY Total_Revenue DESC;

/*---K6 - State-Wise Loan: Shows geographic distribution of loans --*/
SELECT
    `state_name`,
    COUNT(DISTINCT `account_id`) AS Total_Loans
FROM banking_data
GROUP BY `state_name`
ORDER BY Total_Loans DESC;

/*---K7 - Religion-Wise Loan: Monitors loan distribution across religious demographics. --*/
SELECT
    `religion`,
    COUNT(DISTINCT `account_id`) AS Total_Loans,
    SUM(`funded_amount`) AS Total_Funded_Amount
FROM banking_data
GROUP BY `religion`
ORDER BY Total_Loans DESC;

/*---K8 - Product Group-Wise Loan: Categorizes loans by product types (e.g., personal, auto) --*/
SELECT
    `product_code`,
    COUNT(DISTINCT `account_id`) AS Total_Loans,
    SUM(`funded_amount`) AS Total_Funded_Amount
FROM banking_data
GROUP BY `product_code`
ORDER BY Total_Loans DESC;

/*---K9 -Disbursement Trend: Tracks changes in loan disbursements over time. --*/
SELECT
    DATE_FORMAT(`disbursement_date`, '%Y-%m') AS Disbursement_Month,
    COUNT(DISTINCT `account_id`) AS Total_Loans,
    SUM(`funded_amount`) AS Total_Disbursed
FROM banking_data
WHERE `disbursement_date` IS NOT NULL
GROUP BY DATE_FORMAT(`disbursement_date`, '%Y-%m')
ORDER BY Disbursement_Month;

/*---K10 -Grade-Wise Loan: Assesses portfolio risk by borrower credit grades--*/
SELECT
    `grrade`,
    COUNT(DISTINCT `account_id`) AS Total_Loans,
    SUM(`funded_amount`) AS Total_Funded_Amount
FROM banking_data
GROUP BY `grrade`
ORDER BY `grrade`;

/*---K11 - Default Loan Count: Counts loans in default. --*/
SELECT
    COUNT(DISTINCT `account_id`) AS Default_Loan_Count
FROM banking_data
WHERE `is_default_loan` = 'Y';

/*---K12- Delinquent Client Count: Tracks borrowers with missed payments ---*/
SELECT
    COUNT(DISTINCT `client_id`) AS Delinquent_Client_Count
FROM banking_data
WHERE `is_delinquent_loan` = 'Y';

/*---K13 -Delinquent Loan Rate: Percentage of loans overdue in the portfolio --*/
SELECT
    COUNT(DISTINCT CASE
        WHEN `is_delinquent_loan` = 'Y'
        THEN `account_id`
    END) * 100.0
    / COUNT(DISTINCT `account_id`) AS Delinquent_Loan_Rate
FROM banking_data;

/*---K14 - Default Loan Rate: Proportion of defaulted loans to the total portfolio.--*/
SELECT
    COUNT(DISTINCT CASE
        WHEN `is_default_loan` = 'Y'
        THEN `account_id`
    END) * 100.0
    / COUNT(DISTINCT `account_id`) AS Default_Loan_Rate
FROM banking_data;

/*---K15 - Loan Status-Wise Loan: Breaks down loans by status (active, delinquent, closed) ---*/
SELECT
    `loan_status`,
    COUNT(DISTINCT `account_id`) AS Total_Loans
FROM banking_data
WHERE `loan_status` IS NOT NULL
GROUP BY `loan_status`
ORDER BY Total_Loans DESC;

/*---K16- Age Group-Wise Loan: Categorizes loans by borrowers’ age groups.---*/
SELECT
    `age`,
    COUNT(DISTINCT `account_id`) AS Total_Loans
FROM banking_data
WHERE `age` IS NOT NULL
GROUP BY `age`
ORDER BY `age`;

/*---K17-Loan Maturity: Tracks the timeline until full repayment --*/
SELECT
    `term`,
    COUNT(DISTINCT `account_id`) AS Total_Loans
FROM banking_data
WHERE `term` IS NOT NULL
GROUP BY `term`
ORDER BY `term`;

/*---K18- No Verified Loans: Identifies loans without proper verification --*/
SELECT
    COUNT(DISTINCT `account_id`) AS No_Verified_Loans
FROM banking_data
WHERE `verification_status` = 'Not Verified';