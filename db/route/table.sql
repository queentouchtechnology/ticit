CREATE TABLE dbo.Routes(
RouteID INT IDENTITY(1,1) PRIMARY KEY,
StartLocation VARCHAR(100),
EndLocation VARCHAR(100),
Distance DECIMAL(8,2),
EstimatedTime VARCHAR(50)
)
