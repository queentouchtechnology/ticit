CREATE TABLE dbo.Seats(
SeatID INT IDENTITY(1,1) PRIMARY KEY,
ScheduleID INT,
SeatNumber INT,
IsAvailable BIT
FOREIGN KEY (ScheduleID) REFERENCES dbo.Schedules(ScheduleID)
)

