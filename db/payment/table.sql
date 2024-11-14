CREATE TABLE dbo.Payments(
PaymentID INT IDENTITY(1,1) PRIMARY KEY,
BookingID INT,
PaymentDate DATETIME,
Amount DECIMAL(10,2),
PaymentMethod VARCHAR(50),
PaymentStatus VARCHAR(50)
FOREIGN KEY (BookingID) REFERENCES dbo.Bookings(BookingID)
)
