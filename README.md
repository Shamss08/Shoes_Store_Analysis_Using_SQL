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

1. **Normalization:** The dataset was normalized to remove redundancy and improve data integrity. [Normalization](https://github.com/Shamss08/Shoes_Store_Database_System/blob/main/Normalization.xlsx)
2. **Entity-Relationship Diagram (ERD):** An ERD was created to visualize the relationships between different entities in the dataset. Inline-style: 
![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")
3. **Schema Design:** Based on the ERD, a database schema was designed to represent the dataset in SQL Server. (File: `DB_Diagram.png`)
4. **Importing Data:** The normalized dataset was imported into SQL Server as CSV files. (File: `Dataset.xlsx`)
5. **Database Creation:** A database was created in SQL Server based on the designed schema. (File: `store.bak`)
6. **Analysis:** Various SQL queries were executed to perform analysis on the dataset, such as finding the average price, identifying popular colors, etc. (Files: `analysis_queries.sql`)

## Repository Structure

- **`data/`:** Contains the original and normalized datasets.
- **`sql/`:** Includes SQL scripts for creating tables, importing data, and performing analysis.
- **`docs/`:** Documentation files, including the ERD diagram and schema design.

## How to Use

1. Clone this repository to your local machine.
2. Navigate to the `sql/` directory and execute the SQL scripts in SQL Server Management Studio or any other SQL client.
3. Explore the analysis results and modify the SQL queries as needed for further analysis.

Feel free to contribute to this repository by adding more analysis or improving the existing one.

---

Feel free to adjust the file names and directory structure as needed!
Explore the analysis results and modify the SQL queries as needed for further analysis.
