CREATE OR ALTER PROCEDURE dbo.UpsertBooking
    @BookingID  INT ,
    @UserID INT,
    @ScheduleID INT,
    @BookingDate DATETIME,
    @TotalAmount DECIMAL(10, 2),
    @BookingStatus VARCHAR(50)
AS
BEGIN
DECLARE @test VARCHAR(200)
EXEC dbo.ValidateInputsBooking @UserID,@ScheduleID,@BookingDate,@TotalAmount,@BookingStatus, @test OUTPUT
IF @test ='OK'
BEGIN
   IF  @BookingID IS NULL
BEGIN
   INSERT INTO dbo.Bookings (UserID,ScheduleID,BookingDate,TotalAmount,BookingStatus) 
   VALUES (@UserID,@ScheduleID,@BookingDate,@TotalAmount,@BookingStatus)
   SELECT 'OK' as Response,'ADDED' as ResponseMessage
END 
ELSE 
BEGIN
UPDATE dbo.Bookings 
SET 
UserID = @UserID,
ScheduleID = @ScheduleID,
BookingDate = @BookingDate,
TotalAmount = @TotalAmount,
BookingStatus  = @BookingStatus 
WHERE BookingID = @BookingID
SELECT 'OK' as Response,'UPDATED' as ResponseMessage
END
END
ELSE
    BEGIN
        SELECT 'Error' as Response,@test as ResponseMessage
    END

END