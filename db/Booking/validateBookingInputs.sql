CREATE OR ALTER PROCEDURE dbo.ValidateInputsBooking
    @UserID INT,
    @ScheduleID INT,
    @BookingDate DATETIME,
    @TotalAmount DECIMAL(10, 2),
    @BookingStatus VARCHAR(50),
    @ResponseMessage NVARCHAR(4000) OUTPUT
As
SET  @ResponseMessage =''
BEGIN
IF @UserID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Users WHERE UserID = @UserID)
    BEGIN
        SET @ResponseMessage = 'UserID ID is not matching or does not exist.';
        RETURN;
    END
IF @ScheduleID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Schedules WHERE ScheduleID = @ScheduleID)
    BEGIN
        SET @ResponseMessage = 'UserID ID is not matching or does not exist.';
        RETURN;
    END
IF @BookingDate < GETDATE()
        BEGIN
            SET @ResponseMessage = 'Booking date cannot be in the past.';
            RETURN;
        END
IF @TotalAmount <= 0
        BEGIN
            SET @ResponseMessage = 'Error: Total amount must be greater than zero.';
            RETURN;
        END
IF @BookingStatus NOT IN ('Pending', 'Confirmed', 'Cancelled')
        BEGIN
            SET @ResponseMessage = 'Invalid booking status. Use Pending, Confirmed, or Cancelled.';
            RETURN;
        END

IF @ResponseMessage = ''
    BEGIN
        SET @ResponseMessage = 'OK';
    END
END