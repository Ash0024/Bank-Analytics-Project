CREATE DATABASE bank_analytics;
USE bank_analytics;

-- Table for Finance_1
CREATE TABLE finance_1 (
    id INT,
    member_id INT,
    loan_amnt INT,
    funded_amnt INT,
    funded_amnt_inv DECIMAL(15,5),
    term INT,
    int_rate DECIMAL(10,5),
    installment DECIMAL(10,2),
    grade VARCHAR(5),
    sub_grade VARCHAR(5),
    emp_title VARCHAR(255),
    emp_length VARCHAR(50),
    home_ownership VARCHAR(50),
    annual_inc DECIMAL(15,2),
    verification_status VARCHAR(50),
    issue_d DATE,
    loan_status VARCHAR(50),
    pymnt_plan VARCHAR(5),
    purpose VARCHAR(100),
    title VARCHAR(255),
    zip_code VARCHAR(10),
    addr_state VARCHAR(10),
    dti DECIMAL(10,2),
    Year INT,
    Month VARCHAR(20)
);




SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/finance_1.csv'
INTO TABLE finance_1
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


CREATE TABLE finance_2 (
    id INT,
    delinq_2yrs INT,
    
    earliest_cr_line DATE,
    
    inq_last_6mths INT,
    
    mths_since_last_delinq VARCHAR(50),
    mths_since_last_record VARCHAR(50),
    
    open_acc INT,
    pub_rec INT,
    
    revol_bal BIGINT,
    
    revol_util VARCHAR(20),
    
    total_acc INT,
    
    initial_list_status VARCHAR(5),
    
    out_prncp DECIMAL(15,2),
    out_prncp_inv DECIMAL(15,2),
    
    total_pymnt DECIMAL(15,5),
    total_pymnt_inv DECIMAL(15,5),
    
    total_rec_prncp DECIMAL(15,5),
    total_rec_int DECIMAL(15,5),
    
    total_rec_late_fee DECIMAL(15,2),
    
    recoveries DECIMAL(15,2),
    
    collection_recovery_fee DECIMAL(15,2),
    
    last_pymnt_d VARCHAR(20),
    
    last_pymnt_amnt DECIMAL(15,2),
    
    last_credit_pull_d VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/finance_2.csv'
INTO TABLE finance_2
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

select * from finance_1;

-- QUERY 1 : TOTAL LOAN APPLICATIONS
-- Purpose:
-- This query calculates total number of loan applications.
-- Business Use:
-- Helps measure overall customer demand for loans.

SELECT 
    COUNT(id) AS Total_Loan_Applications
FROM finance_1;

-- QUERY 2 : TOTAL FUNDED AMOUNT
-- Purpose:
-- This query calculates total loan amount funded by bank.
-- Business Use:
-- Helps understand total lending exposure.

SELECT 
    SUM(loan_amnt) AS Total_Funded_Amount
FROM finance_1;

-- QUERY 3 : TOTAL AMOUNT RECEIVED
-- Purpose:
-- This query calculates total repayment amount received.
-- Business Use:
-- Helps track loan recovery performance.

SELECT 
    ROUND(SUM(total_pymnt),2) AS Total_Amount_Received
FROM finance_2;

-- QUERY 4 : AVERAGE INTEREST RATE
-- Purpose:
-- This query calculates average interest rate on loans.
-- Business Use:
-- Helps analyze lending profitability.

SELECT 
    ROUND(AVG(int_rate),2) AS Average_Interest_Rate
FROM finance_1;

-- QUERY 5 : AVERAGE DEBT TO INCOME RATIO
-- Purpose:
-- This query calculates average customer DTI ratio.
-- Business Use:
-- Higher DTI may indicate higher loan default risk.

SELECT 
    ROUND(AVG(dti),2) AS Average_DTI
FROM finance_1;

-- QUERY 6 : LOAN STATUS ANALYSIS
-- Purpose:
-- This query shows loan count by loan status.
-- Business Use:
-- Helps evaluate portfolio health and risk.
SELECT 
    loan_status,
    COUNT(*) AS Total_Loans
FROM finance_1
GROUP BY loan_status
ORDER BY Total_Loans DESC;

-- QUERY 7 : STATE WISE LOAN ANALYSIS
-- Purpose:
-- This query analyzes loan distribution by state.
-- Business Use:
-- Helps identify high performing lending regions.
SELECT 
    addr_state,
    COUNT(id) AS Total_Loans,
    SUM(loan_amnt) AS Total_Loan_Amount
FROM finance_1
GROUP BY addr_state
ORDER BY Total_Loan_Amount DESC;

-- QUERY 8 : GRADE WISE LOAN ANALYSIS
-- Purpose:
-- This query calculates loan amount by loan grade.
-- Business Use:
-- Helps understand risk category distribution.
SELECT 
    grade,
    ROUND(SUM(loan_amnt),2) AS Total_Loan_Amount
FROM finance_1
GROUP BY grade
ORDER BY Total_Loan_Amount DESC;

-- QUERY 9 : HOME OWNERSHIP ANALYSIS
-- Purpose:
-- This query counts customers based on home ownership.
-- Business Use:
-- Helps in customer segmentation analysis.

SELECT 
    home_ownership,
    COUNT(*) AS Total_Customers
FROM finance_1
GROUP BY home_ownership
ORDER BY Total_Customers DESC;

-- QUERY 10 : YEAR WISE LOAN TREND
-- Purpose:
-- This query shows yearly loan funding trend.
-- Business Use:
-- Helps analyze business growth over time.

SELECT 
    Year,
    SUM(loan_amnt) AS Total_Loan_Amount
FROM finance_1
GROUP BY Year
ORDER BY Year;

-- QUERY 11 : PURPOSE WISE LOAN ANALYSIS
-- Purpose:
-- This query analyzes loan purpose categories.
-- Business Use:
-- Helps identify major reasons customers take loans.

SELECT 
    purpose,
    COUNT(*) AS Total_Loans,
    SUM(loan_amnt) AS Total_Loan_Amount
FROM finance_1
GROUP BY purpose
ORDER BY Total_Loan_Amount DESC;

-- QUERY 12 : JOIN ANALYSIS OF BOTH TABLES
-- Purpose:
-- This query combines loan details and payment details.
-- Business Use:
-- Helps perform complete customer loan performance analysis.

SELECT 
    f1.id,
    f1.loan_amnt,
    f1.grade,
    f1.loan_status,
    f2.total_pymnt,
    f2.recoveries
FROM finance_1 f1
JOIN finance_2 f2
ON f1.id = f2.id;


-- QUERY 13 : VERIFIED VS NON VERIFIED CUSTOMERS
-- Purpose:
-- This query compares verification status of customers.
-- Business Use:
-- Helps understand customer verification distribution.

SELECT 
    verification_status,
    COUNT(*) AS Total_Customers
FROM finance_1
GROUP BY verification_status;


-- QUERY 14 : TOP 10 HIGHEST LOANS
-- Purpose:
-- This query finds highest loan amounts.
-- Business Use:
-- Helps identify high value borrowers.
SELECT 
    id,
    loan_amnt,
    grade,
    annual_inc
FROM finance_1
ORDER BY loan_amnt DESC
LIMIT 10;

-- QUERY 15 : MONTH WISE LOAN ANALYSIS
-- Purpose:
-- This query analyzes monthly loan trends.
-- Business Use:
-- Helps identify seasonal loan demand patterns.

SELECT 
    Month,
    COUNT(*) AS Total_Loans,
    SUM(loan_amnt) AS Total_Loan_Amount
FROM finance_1
GROUP BY Month
ORDER BY Total_Loan_Amount DESC;