-- Creating a table for handling missing data
CREATE TABLE MissingValueTable (
    ID Integer(20) PRIMARY KEY,
    Name VARCHAR(50),
    Age Integer(20),
    Salary decimal(10, 2),
    City varchar(50),
    Gender varchar(10)
);

-- Inserting sample data with missing values
INSERT INTO MissingValueTable VALUES
(1, 'John Doe', 28, 50000.00, 'New York', 'Male'),
(2, 'Jane Smith', NULL, 60000.00, 'Chicago', 'Female'),
(3, 'Bob Johnson', 35, 75000.00, NULL, 'Male'),
(4, 'Alice White', 42, NULL, 'Los Angeles', 'Female'),
(5, 'Charlie Brown', 30, 55000.00, 'San Francisco', 'Male'),
(6, 'Emma Davis', NULL, 70000.00, 'Boston', 'Female'),
(7, 'Michael Wilson', 45, 80000.00, 'Miami', 'Male'),
(8, 'Sophia Lee', 28, 62000.00, 'Seattle', 'Female');

-- Displaying the table
-- SELECT * FROM MissingValueTable;

-- Remove Rows with Missing Values
select * from MissingValueTable
    where age is null;

-- Impute with Default Values

UPDATE MissingValueTable
SET age = COALESCE(age, 25);

select * from MissingValueTable;


-- Impute missing age values with the mean
SELECT
  id, Name,
  COALESCE(salary, AVG(salary) OVER ()) AS avg_salary
FROM MissingValueTable;

-- Interpolate missing values for time series data
SELECT
  id,
  Name,
  COALESCE(Age, LAG(Age) OVER (ORDER BY id)) AS Imputed_Age,
  COALESCE(Salary, LAG(Salary) OVER (ORDER BY id)) AS Imputed_Salary,
  COALESCE(City, 'Unknown') AS Imputed_City,
  Gender
FROM MissingValueTable;

-- COUNT and COUNT DISTINCT

SELECT
  COUNT(id) AS Non_Missing_Count,
  COUNT(DISTINCT City) AS Non_Missing_Distinct_City_Count
FROM MissingValueTable;


-- Handling missing data in AVG and SUM
SELECT
  AVG(COALESCE(Age, 0)) AS Avg_Age,
  SUM(COALESCE(Salary, 0)) AS Sum_Salary
FROM MissingValueTable;



