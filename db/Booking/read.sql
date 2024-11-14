CREATE OR ALTER PROCEDURE dbo.ReadBooking
    @BookingID  INT
AS
BEGIN
   
    IF @BookingID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Bookings WHERE BookingID  = @BookingID  )
    BEGIN
      
        SELECT 'Invalid BookingID' AS Response;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
          BookingID,
          UserID,
          ScheduleID,
          BookingDate,
          TotalAmount,
          BookingStatus
        FROM 
          dbo.Bookings
        WHERE 
            BookingID  = @BookingID ;
    END
END;



