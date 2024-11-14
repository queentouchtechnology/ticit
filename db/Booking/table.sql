CREATE TABLE dbo.Bookings(
BookingID INT IDENTITY(1,1) PRIMARY KEY,
UserID INT,
ScheduleID INT,
BookingDate DATETIME,
TotalAmount DECIMAL(10,2),
BookingStatus VARCHAR(50)
FOREIGN KEY (UserID) REFERENCES dbo.Users(UserID),
FOREIGN KEY (ScheduleID) REFERENCES dbo.Schedules(ScheduleID)
)