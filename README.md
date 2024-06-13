# Shoes Store Dataset Analysis

This repository contains an analysis of the shoes store dataset, which includes information about various shoes available in the store. The dataset was normalized, imported into SQL Server, and analyzed using SQL queries.

## Dataset Information

The dataset includes the following fields:

- **ProductName:** Name of the shoe.
- **Usage:** Usage type (e.g., casual).
- **Category:** Category of users (Men, Women, Kids).
- **Manufacturer:** Manufacturer of the shoe.
- **Factory Branch:** Location of the manufacturing branch.
- **Color:** Available color options.
- **Price:** Price of the shoe.
- **Size:** Size of the shoe.
- **Description:** Description of the shoe.
- **Number in Stock:** Quantity of the shoe in stock.

## Analysis Steps

1. **Normalization:** The dataset was normalized to remove redundancy and improve data integrity. [Normalization](https://github.com/Shamss08/Shoes_Store_Analysis_Using_SQL/blob/main/Normalization.xlsx)
2. **Entity-Relationship Diagram (ERD):** An ERD was created to visualize the relationships between different entities in the dataset.
![alt text](https://github.com/Shamss08/Shoes_Store_Analysis_Using_SQL/blob/main/ERD.jpg "ERD")
3. **Schema Design:** Based on the ERD, a database schema was designed to represent the dataset in SQL Server. ![alt text](https://github.com/Shamss08/Shoes_Store_Analysis_Using_SQL/blob/main/DB_Diagram.png "Database Schema")
4. **Importing Data:** The normalized dataset was imported into SQL Server as CSV files. [Dataset](https://github.com/Shamss08/Shoes_Store_Analysis_Using_SQL/blob/main/Dataset.xlsx)
5. **Database Creation:** A database was created in SQL Server based on the designed schema. [Database](https://github.com/Shamss08/Shoes_Store_Analysis_Using_SQL/blob/main/store.bak)
6. **Analysis:** Various SQL queries were executed to perform analysis on the dataset, such as finding the average price, identifying popular colors, etc. [Analysis Queries](https://github.com/Shamss08/Shoes_Store_Analysis_Using_SQL/blob/main/Shoes_Store.sql)
