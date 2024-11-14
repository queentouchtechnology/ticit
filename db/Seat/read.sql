CREATE OR ALTER PROCEDURE dbo.ReadSeat
    @SeatID  INT
AS
BEGIN
   
    IF @SeatID  IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Seats WHERE SeatID = @SeatID)
    BEGIN
      
        SELECT 'Invalid SeatID' AS ResponseMessage;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
            SeatID,
            ScheduleID ,
            SeatNumber ,
           IsAvailable
        FROM 
            dbo.Seats
        WHERE 
            SeatID = @SeatID;
    END
END;



