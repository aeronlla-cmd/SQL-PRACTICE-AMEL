-- SCENARIO: Find the top-selling product per country in 2014 (one row per country)
WITH CountryProductSales AS (
SELECT
    dg.EnglishCountryRegionName as Country,
    dp.EnglishProductName as ProductName,
    SUM(fs.SalesAmount) as TotalSales,
    RANK() OVER(
        PARTITION BY dg.EnglishCountryRegionName
        ORDER BY SUM(fs.SalesAmount) DESC
    ) AS ProductRank

FROM FactInternetSales as fs 
    JOIN DimProduct as dp
    ON fs.ProductKey=dp.ProductKey
    JOIN DimCustomer as dc 
    ON fs.CustomerKey=dc.CustomerKey
    JOIN DimGeography as dg 
    ON dc.GeographyKey=dg.GeographyKey

WHERE YEAR(fs.OrderDate) = 2014
    AND fs.SalesAmount>0

GROUP BY dg.EnglishCountryRegionName, dp.EnglishProductName
)
SELECT 
    Country,
    ProductName,
    TotalSales
FROM CountryProductSales
WHERE ProductRank=1
ORDER BY Country ASC