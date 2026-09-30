# Bank Loan Analytics Dashboard

Analysis of a bank loan portfolio using **MySQL, Tableau, Power BI and Excel**: how loans are distributed, how repayment performs, and which borrower segments carry the most default risk.

**Project type:** Group project
**Period:** Completed during my Data Analyst internship at Aivariant (Nov 2025 – May 2026)

---

## Dataset

- Publicly available loan dataset, split into two tables: **loan details** (`finance_1`) and **repayment history** (`finance_2`), joined on loan `id`.
- **39,717 loans**, **$445.6M** total loan value, **51 columns** after consolidation.
- The cleaned dataset is in the `Dataset` folder.

## Tools Used

| Tool | Used for |
|---|---|
| MySQL | Database setup, CSV import, KPI and breakdown queries |
| Tableau | Interactive dashboard |
| Power BI | Dashboard |
| Excel | Dashboard |

## Key Findings

- **Lower-grade loans carry much higher default risk.** Grade D–G loans defaulted at **23.68%**, versus **11.17%** for Grade A–C.
- **Small share of loans, large share of losses.** Grade D–G loans were **24%** of all loans but **48%** of charged-off value (**$33.0M of $68.1M**).
- **Verification did not lower default rates.** Loans marked "Verified" defaulted at **16.01%**, higher than "Not Verified" loans at **12.66%**.

**Limitation:** the verification result shows a correlation only. Verification is probably applied more often to riskier borrowers, so it should not be read as verification *causing* more defaults. Testing this would need controls for grade, income and loan amount.

## SQL Analysis

All queries are in the `SQL` folder. The script creates both tables, loads the CSVs and runs 15 queries:

- **KPIs:** total loan applications, total funded amount, total amount received, average interest rate, average DTI
- **Portfolio health:** loans by loan status
- **Breakdowns:** by state, grade, home ownership, purpose, verification status, year and month
- **Joins:** loan details combined with repayment details
- **Top loans:** ten largest loans

> To run it, change the file paths in the `LOAD DATA INFILE` statements to where your CSV files are saved.

## Dashboard Screenshots

### Excel Dashboard
![Excel Dashboard](Screenshots/excel_dashboard.png)

### Power BI Dashboard
![Power BI Dashboard](Screenshots/powerbi_dashboard.png)

### Tableau Dashboard
![Tableau Dashboard](Screenshots/tableau_dashboard.png)

## Repository Structure

```
Dataset/        Cleaned dataset
SQL/            MySQL script (schema, import, queries)
Power Bi/       Power BI dashboard file
Tableau/        Tableau dashboard file
Presentation/   Project presentation
Screenshots/    Dashboard images
```

## My Contribution

- Data cleaning and preparation
- SQL query development
- Dashboard creation and visualization
- Data analysis and reporting
