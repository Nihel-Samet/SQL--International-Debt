-- We used in this work world bank's international debt data to analyze international debt. The dataset contains countries name, countries code, indicator_name which specifies the reason of taking the debt, indicator_code which symbolizes the category of these debts, and the amount of debt in USD. 

-- We are going to find the answers to questions like:

--What is the total amount of debt that is owed by the countries listed in the dataset?
--Which country owns the maximum amount of debt and what does that amount look like?
--What is the average amount of debt owed by countries across different debt indicators?


/****** Initial look at the table:  */
SELECT * 
FROM international_debt 
LIMIT 10;
/*** The columns of the international_debt table are: country_name, country_code, indicator_name, indicator_code and	debt*/


/****** How many countries are in the table*/
SELECT 
    COUNT ( DISTINCT country_name ) AS total_distinct_countries 
FROM international_debt;
/*** 124 unique countries */


/****** Total amount of debt owed by countries */
SELECT 
    ROUND(SUM(debt), 2) AS total_debt
FROM international_debt; 
/***  The global debt reached  $307 trillion  ($3079734487675.80) */


/****** Country with the highest debt */
SELECT 
    country_name, 
    SUM(debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 1;
/*** China is the country with the highest debt with total debt of $285793494734.200001568  */


/****** Country with the lowest debt */
 SELECT 
    country_name, 
    SUM(debt) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt 
LIMIT 1;
/*** Sao Tome and Principe an African country with total amount of debt of $44798032.5 */


/****** Countrie with mawimum amount of debt */
SELECT 
    country_name, 
    MAX(debt) AS maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt DESC
LIMIT 10;
/*** China has the maximum amount of debt, then Brasil*/


/******  Finding out the distinct debt indicators to understand more in with area the country is indebted to */
SELECT 
    COUNT(DISTINCT (indicator_code)) AS distinct_debt_indicators 
FROM international_debt 
ORDER BY distinct_debt_indicators;
/* 25 indicators */


/****** Average amount of debt across indicators*/
SELECT 
    indicator_code ,
    indicator_name,
    AVG(debt) AS average_debt
FROM international_debt
GROUP BY indicator_code, indicator_name
ORDER BY average_debt DESC
LIMIT 10;
/*** debt indicator code DT.AMT.DLXF.CD 
/*** Principal repayments on external debt, long-term (AMT, current US$) is the category with the highest average amount of debts with an average debt of $5904868401.499193612 */


/****** which country owes the highest amount of debt in the category of DT.AMT.DLXF.CD */
SELECT 
    country_name, 
    indicator_name
FROM international_debt
WHERE debt = (SELECT 
                  MAX(debt)
              FROM international_debt
              WHERE indicator_code='DT.AMT.DLXF.CD');
/*** China has the highest amount of debt in the principal repayments on external debt, long-term debt category (DT.AMT.DLXF.CD). */


