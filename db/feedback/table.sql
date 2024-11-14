CREATE TABLE dbo.Feedbacks(
FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
BookingID INT,
Rating INT,
Comments TEXT,
FeedbackDate DATETIME
FOREIGN KEY  (BookingID) REFERENCES dbo.Bookings(BookingID)
)