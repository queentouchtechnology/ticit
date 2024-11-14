CREATE TABLE dbo.Cancellations(
CancellationID INT IDENTITY(1,1) PRIMARY KEY,
BookingID INT,
CancellationDate DATETIME,
RefundAmount DECIMAL(10,2),
Reason VARCHAR(255),
FOREIGN KEY (BookingID) REFERENCES dbo.Bookings(BookingID)
)