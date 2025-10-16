-- SCENARIO: Your manager wants a quick snapshot of which products performed best in each country during the year 2014, based on total SalesAmount.
SELECT
    dg.EnglishCountryRegionName as Country,
    dp.EnglishProductName as ProductName,
    SUM(fs.SalesAmount) as TotalSales

FROM FactInternetSales as fs 
    JOIN DimProduct as dp
    ON fs.ProductKey=dp.ProductKey
    JOIN DimCustomer as dc 
    ON fs.CustomerKey=dc.CustomerKey
    JOIN DimGeography as dg 
    ON dc.GeographyKey=dg.GeographyKey

WHERE YEAR(fs.OrderDate) = 2014
    AND fs.SalesAmount IS NOT NULL

GROUP BY dg.EnglishCountryRegionName, dp.EnglishProductName

ORDER BY dg.EnglishCountryRegionName ASC, TotalSales DESC