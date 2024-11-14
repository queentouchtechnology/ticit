CREATE TABLE dbo.Buses(
BusID INT IDENTITY(1,1) PRIMARY KEY,
BusNumber varchar(20),
Capacity INT,
BusType VARCHAR(50),
OperatorName VARCHAR(100)
);