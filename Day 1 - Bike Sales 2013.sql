-- OBJECTIVE: Analyze Bike product sales in 2013 using SELECT, WHERE, and ORDER BY from the AdventureWorksDW data warehouse.
-- SCENARIO: You’re a data analyst at Adventure Works. Your manager needs a quick report showing Bike sales in 2013 — including which customers and regions generated the highest profits.
SELECT TOP(10)
    CONCAT(dc.FirstName, dc.LastName) as CustomerName,
    dg.EnglishCountryRegionName as Country,
    dp.EnglishProductName as ProductName,
    fs.OrderDate as OrderDate,
    SUM(fs.SalesAmount) as SalesAmount,
    SUM(fs.TotalProductCost) as TotalProductCost,
    SUM(fs.SalesAmount) - SUM(fs.TotalProductCost) as Profit

FROM FactInternetSales as fs
    JOIN DimProduct as dp
    ON fs.ProductKey = dp.ProductKey
    JOIN DimCustomer as dc 
    ON fs.CustomerKey = dc.CustomerKey
    JOIN DimGeography as dg
    ON dc.GeographyKey = dg.GeographyKey

WHERE dp.EnglishProductName LIKE '%Bike%'
    AND YEAR(fs.OrderDate) = 2013

GROUP BY dc.FirstName, dc.LastName, dg.EnglishCountryRegionName, dp.EnglishProductName, fs.OrderDate

ORDER BY Profit Desc