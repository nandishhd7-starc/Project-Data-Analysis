Create database banking_analytics;
use banking_analytics;


CREATE TABLE banking_data (
    state_abbr VARCHAR(10),
    account_id VARCHAR(50),
    age INT,
    bh_name VARCHAR(100),
    bank_name VARCHAR(100),
    branch_name VARCHAR(150),
    caste VARCHAR(100),
    center_id VARCHAR(50),
    city VARCHAR(100),
    client_id VARCHAR(50),
    client_name VARCHAR(150),
    close_client VARCHAR(20),
    closed_date  date,
    credif_officer_name VARCHAR(150),
    dateof_birth  date,
    disb_by VARCHAR(100),
    disbursement_date  date,
    disbursement_date_year Int,
    gender_id VARCHAR(20),
    home_ownership VARCHAR(50),
    loan_status VARCHAR(50),
    loan_transferdate  date,
    next_meeting_date  date,
    product_code VARCHAR(50),
    grrade VARCHAR(20),
    sub_grade VARCHAR(20),
    product_id VARCHAR(50),
    purpose_category VARCHAR(100),
    region_name VARCHAR(100),
    religion VARCHAR(100),
    verification_status VARCHAR(50),
    state_abbr_2 VARCHAR(10),
    state_name VARCHAR(100),
    tranfer_logic VARCHAR(50),
    is_delinquent_loan INT,
    is_default_loan INT,
    age_t INT,
    delinq_2_yrs INT,
    application_type VARCHAR(50),
    loan_amount DECIMAL(15,2),
    funded_amount DECIMAL(15,2),
    funded_amount_inv DECIMAL(15,2),
    term VARCHAR(50),
    int_rate DECIMAL(10,4),
    total_pymnt DECIMAL(15,2),
    total_pymnt_inv DECIMAL(15,2),
    total_rec_prncp DECIMAL(15,2),
    total_fees DECIMAL(15,2),
    total_rec_int DECIMAL(15,2),
    total_rec_late_fee DECIMAL(15,2),
    recoveries DECIMAL(15,2),
    collection_recovery_fee DECIMAL(15,2)
);
ALTER TABLE banking_data
MODIFY closed_date VARCHAR(30),
MODIFY dateof_birth VARCHAR(30),
MODIFY disbursement_date VARCHAR(30),
MODIFY loan_transferdate VARCHAR(30),
MODIFY next_meeting_date VARCHAR(30),
MODIFY age VARCHAR(20),
MODIFY disbursement_date_year VARCHAR(20),
MODIFY is_delinquent_loan VARCHAR(1),
MODIFY is_default_loan VARCHAR(1),
MODIFY age_t VARCHAR(20);

select * from banking_data;

SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/Users/RADHIKA/Downloads/Banking Project/Banking Project/Data/banking_data.csv'
INTO TABLE banking_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'local_infile';

select * from banking_data;

/*---TRUNCATE TABLE banking_data;
ALTER TABLE banking_data
ADD COLUMN disbursement_date_new DATE;

SET SQL_SAFE_UPDATES = 0;
UPDATE banking_data
SET disbursement_date_new =
    CASE
        WHEN disbursement_date IS NULL
             OR TRIM(disbursement_date) = ''
        THEN NULL
        ELSE STR_TO_DATE(
            REPLACE(TRIM(disbursement_date), '-', '/'),
            '%e/%c/%Y'
        )
    END;
    SELECT
    disbursement_date,
    disbursement_date_new
FROM banking_data
LIMIT 20;
ALTER TABLE banking_data
DROP COLUMN disbursement_date;
ALTER TABLE banking_data
CHANGE disbursement_date_new disbursement_date DATE;
DESCRIBE banking_data; ---*/

CREATE TABLE debit_credit_data (
    customer_id VARCHAR(50),
    customer_name VARCHAR(150),
    account_number VARCHAR(50),
    transaction_date date,
    transaction_type VARCHAR(20),
    amount DECIMAL(15,2),
    balance DECIMAL(15,2),
    description VARCHAR(255),
    branch VARCHAR(150),
    transaction_method VARCHAR(100),
    currency VARCHAR(10),
    bank_name VARCHAR(100)
);

select * from debit_credit_data;

LOAD DATA LOCAL INFILE 'C:/Users/RADHIKA/Downloads/Banking Project/Banking Project/Data/Debit and Credit banking_data.csv'
INTO TABLE debit_credit_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from debit_credit_data;