# Financial Data Analysis Project: Database Creation, Insertion, and Utilization

<p align="center">
<img src="https://th.bing.com/th/id/OIG4.X0nn0DWcE_P2GtYBOhEE?w=1024&h=1024&rs=1&pid=ImgDetMain" alt="Database Image" width="50%">
</p>

## Introduction

This project aims to design, create, and utilize a database to efficiently manage financial data, including information on Bitcoin, Gold, and the S&P 500. The goal is to analyze how these assets behave in relation to various economic factors such as inflation, interest rates, and market volatility (VIX). Through this project, we demonstrate the process of database design, data insertion, advanced querying, and data visualization.

## Data Sources

The data used in this project originates from a previous project where we consolidated financial data from multiple sources, resulting in the df_combined.csv file. This file includes:

- **Assets Data**: Historical prices of Bitcoin, Gold, and the S&P 500.
- **Economic Factors**:  Information on market volatility (VIX), interest rates, CPI, and inflation.

### Challenges Addressed

- **Data Integrity**: Ensuring the consistency and accuracy of data transferred from the CSV to the database. Our data comes from the previous project [multi-asset-financial-analysis
](https://github.com/adrianlardies/multi-asset-financial-analysis)
- **Efficient Queries**: Optimizing SQL queries for speed and accuracy, especially with large datasets.

## Key Questions Addressed

1. **How to design an efficient database to manage dates, assets, and key economic metrics?**
   - **Solution**: Implement a relational database model with well-defined tables and relationships, leveraging foreign keys to maintain data integrity.

2. **How to insert data securely and efficiently into the database?**
   - **Solution**: Use Python scripts to automate the data insertion process, ensuring that data is inserted securely and efficiently, with integrity constraints enforced.

3. **How to perform queries to retrieve relevant information from the database?**
   - **Solution**: Utilize SQL features like JOIN, GROUP BY, ORDER BY, CASE, and subqueries to extract and analyze the data. Use indexes to optimize query performance.

## Methodology

### 1. Problem Definition and Hypothesis Formulation
The project began with defining the problem: efficiently managing and analyzing financial data. Hypotheses were formulated on how to design the database structure to facilitate this analysis, focusing on optimizing the database for financial queries.

### 2. Database Creation
The database was designed using a relational model with three main tables:
- `dates`: Stores unique dates and their corresponding `id_date`.
- `assets`: Contains data on the prices and changes of Bitcoin, Gold, and the S&P 500, linked to `id_date`.
- `economic_factors`: Stores economic indicators such as VIX, interest rates, CPI, and inflation, also linked to `id_date`.

The SQL scripts for creating these tables are included in the `create_database.sql` file.

### 3. Data Insertion
Data from df_combined.csv was inserted into the database using Python and SQLAlchemy. The insertion process was handled with care to maintain data integrity, utilizing foreign keys and ensuring correct relationships between tables.

### 4. Analysis and Queries
Five advanced SQL queries were developed to analyze the data:
1. **Annual Growth Analysis**: Calculated the yearly growth rates of Bitcoin, Gold, and the S&P 500.
2. **Monthly Average and Volatility**: Analyzed the monthly average prices and volatility of the assets.
3. **Impact of Interest Rates on Bitcoin**: Investigated how low and high interest rates affect Bitcoin's price and volatility.
4. **S&P 500 Growth and Inflation**: Explored the relationship between the growth of the S&P 500 and inflation rates.
5. **Bitcoin Performance under High Volatility and Inflation**: Analyzed Bitcoin's average performance and volatility during periods of high market volatility (VIX > 30) and inflation (inflation > 3%).

### 5. Visualization
Two detailed visualizations were created to illustrate the results of the SQL queries:
- **Annual Growth Visualization**: A line graph showing the annual growth of Bitcoin, Gold, and the S&P 500.
- **S&P 500 Growth vs. Inflation**: A dual-axis line chart comparing the S&P 500’s growth rate with the average inflation rate over the years.

These visualizations provide a clear and comprehensive view of the financial data, helping to understand the trends and relationships between the variables.

## Key Findings and Conclusions
- **Efficient Database Design**: A well-structured relational database is crucial for managing and analyzing financial data effectively.
- **Secure and Efficient Data Insertion**: Using Python and SQLAlchemy for data insertion ensures data integrity and efficiency.
- **Powerful Querying Capabilities**: Advanced SQL queries, when properly optimized, can yield deep insights into financial data.
- **Visualization for Insight**: Visualizing the results of queries is essential for interpreting and communicating the data's story.

## Future Directions
- **Scalability**: Investigate ways to scale the database to handle even larger datasets, ensuring continued performance efficiency.
- **Enhanced Security**: Explore additional security measures to protect sensitive financial data, such as encryption and advanced access controls.

## Data Sources and Links

- **Presentation**: [Project Presentation](https://gamma.app/docs/Analisis-de-Activos-Financieros-con-SQL-dar1neyyi37mk7f?mode=present#card-08caant46xa6859)
- **Database Creation Script**: [create_database.sql](https://github.com/adrianlardies/from-data-to-insight/blob/48a08e9707e174a4b6f33536632535a1861e2bc4/scripts/create_database.sql)  
- **Query History**: [query_history.sql](https://github.com/adrianlardies/from-data-to-insight/tree/48a08e9707e174a4b6f33536632535a1861e2bc4/scripts)

This README provides an overview of the project, detailing the methodology, analysis, and key findings. For more information, please refer to the provided resources.
