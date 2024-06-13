

/*******************************************************************FUNCTIONS*******************************************************************/
--Function to get the number of products for a given category
CREATE OR ALTER FUNCTION GetProductCountByCategory (@categoryName VARCHAR(100))
RETURNS INT
AS
BEGIN
    DECLARE @count INT;
    SELECT @count = COUNT(*)
    FROM Product p
    INNER JOIN Category c ON p.CategoryID = c.CategoryID
    WHERE c.CategoryName = @categoryName;
    RETURN @count;
END;

select dbo.GetProductCountByCategory('Kids') as NumOfCategoryProducts;

--Calculate the total value of products in stock for a given category.
CREATE OR ALTER FUNCTION GetTotalStockValueByCategory (@CategoryID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalValue DECIMAL(10, 2);
    SELECT @TotalValue = SUM(Price * number_in_stock)
    FROM Product
    WHERE CategoryID = @CategoryID;
    RETURN @TotalValue;
END;

select dbo.GetTotalStockValueByCategory(101) as TotalStockValueByCategory;


--Find the most expensive product:
CREATE FUNCTION GetMostExpensiveProduct()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 ProductName,price
    FROM product
    ORDER BY price DESC
)

select * from GetMostExpensiveProduct()


-- Function to calculate the average price of products in a specific category
CREATE OR ALTER FUNCTION GetAveragePriceByCategory (@CategoryID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @AveragePrice DECIMAL(10,2);
    SELECT @AveragePrice = AVG(price)
    FROM Product
    WHERE CategoryID = @CategoryID;
    RETURN @AveragePrice;
END;


select dbo.GetAveragePriceByCategory(101) as AveragePriceByCategory;

/*******************************************************************VIEWS*******************************************************************/

--View to display product details along with category name and manufacturer name
CREATE OR ALTER VIEW ProductDetails AS
SELECT p.ProductID, p.ProductName, p.UsageID, c.CategoryName, m.ManufacturerName, 
       p.ColorID, p.Price, p.SizeID, p.Description, p.number_in_stock
FROM Product p
INNER JOIN Category c ON p.CategoryID = c.CategoryID
INNER JOIN Manufacturer m ON p.ManufacturerID = m.ManufacturerID;

SELECT * FROM ProductDetails

--View to get products with low stock (products with stock less than the average stock number)
CREATE OR ALTER VIEW LowStockProducts
AS
SELECT *
FROM Product
WHERE Number_in_stock < (SELECT AVG(Number_in_stock) FROM product);

SELECT * FROM LowStockProducts;

/*******************************************************************STORED PROCEDURE*******************************************************************/

--Procedure to insert a new product into the database
CREATE OR ALTER PROC sp_InsertProduct
	@ProductID INT,
    @ProductName VARCHAR(100),
    @UsageID INT,
    @CategoryID INT,
    @ManufacturerID INT,
    @ColorID INT,
    @Price DECIMAL(10, 2),
    @SizeID INT,
    @Description VARCHAR(MAX),
    @NumberInStock INT
AS
BEGIN
    INSERT INTO Product (ProductID, ProductName, UsageID, CategoryID, ManufacturerID, ColorID, Price, SizeID, Description, number_in_stock)
    VALUES (@ProductID,@ProductName, @UsageID, @CategoryID, @ManufacturerID, @ColorID, @Price, @SizeID, @Description, @NumberInStock);
END;

sp_InsertProduct 526,'ShoeAireForce', 1, 102, 200,301,103.67,400,'skajksfhswefoiqpfjweiofjwieofjquio',48;



--Stored procedure to update product price
CREATE OR ALTER PROC sp_UpdateProductPrice 
    @productId INT,
    @newPrice DECIMAL(10,2)
AS
BEGIN
    UPDATE Product
    SET Price = @newPrice
    WHERE ProductID = @productId;
END;

sp_UpdateProductPrice 501, 210.75

select * from product

--Get products by factory branch:
CREATE OR ALTER PROCEDURE GetProductsByFactoryBranch
    @FactoryBranch VARCHAR(50)
AS
BEGIN
    SELECT ProductName,FactoryBranch
    FROM product inner join Manufacturer on product.ManufacturerID = Manufacturer.ManufacturerID
	inner  join Factory_branch on Manufacturer.ManufacturerID = Factory_branch.ManufacturerID
    WHERE FactoryBranch = @FactoryBranch
END

exec GetProductsByFactoryBranch @FactoryBranch = 'East'


--GET PRICE RANGE OF PRODUCTS
CREATE OR ALTER VIEW PriceRangeProducts
AS
SELECT 
    ProductName, 
    price,
    CASE 
        WHEN price < 50 THEN 'Budget'
        WHEN price BETWEEN 50 AND 150 THEN 'Midrange'
        WHEN price > 150 THEN 'Premium'
    END AS PriceRange
FROM 
    product;

SELECT * FROM PriceRangeProducts

-- Stored Procedure to restock a product
CREATE OR ALTER PROC RestockProduct
    @ProductID INT,
    @RestockAmount INT
AS
BEGIN
    UPDATE product
    SET number_in_stock = number_in_stock + @RestockAmount
    WHERE ProductID = @ProductID
END

RestockProduct 508, 5

SELECT * FROM product


/*******************************************************************CURSOR*******************************************************************/

--Cursor to update product prices when stock is less than 50 increase price by 10%
DECLARE @ProductID INT;
DECLARE @NewPrice DECIMAL(10, 2);

DECLARE product_cursor CURSOR 
FOR
SELECT ProductID, Price
FROM Product
WHERE number_in_stock < 50;

OPEN product_cursor;

FETCH NEXT FROM product_cursor INTO @ProductID, @NewPrice;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @NewPrice = @NewPrice * 1.1;
    UPDATE Product
    SET Price = @NewPrice
    WHERE ProductID = @ProductID;

    FETCH NEXT FROM product_cursor INTO @ProductID, @NewPrice;
END

CLOSE product_cursor;
DEALLOCATE product_cursor;

/*******************************************************************TRIGGER*******************************************************************/

-- Trigger to check for low stock and notify
CREATE OR ALTER TRIGGER CheckLowStock
ON product
AFTER INSERT
AS
BEGIN
    DECLARE @ProductID INT, @Stock INT, @ProductName NVARCHAR(100);
    SELECT @ProductID = INSERTED.ProductID, @Stock = INSERTED.number_in_stock, @ProductName = INSERTED.ProductName
    FROM INSERTED
    WHERE INSERTED.number_in_stock < 10;

    IF @Stock IS NOT NULL
    BEGIN
        PRINT 'Alert: Product ' + @ProductName + ' (ID: ' + CAST(@ProductID AS NVARCHAR) + ') is low on stock. Only ' + CAST(@Stock AS NVARCHAR) + ' left.';
        END
END

insert into product values(528,'ShoeAireForce', 1, 102, 200,301,103.67,400,'skajksfhswefoiqpfjweiofjwieofjquio',8);
--delete from product where ProductID=527


/*******************************************************************INDEX*******************************************************************/


--Create an index on the CategoryID column of the Product table
CREATE INDEX CategoryID_Index ON product(CategoryID);


--Create a non_clustered index on productName column
CREATE NONCLUSTERED INDEX ProductName_Index ON product (ProductName);





