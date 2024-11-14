CREATE OR ALTER PROCEDURE dbo.ReadSchedule
    @ScheduleID   INT
AS
BEGIN
   
    IF @ScheduleID   IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Schedules WHERE ScheduleID  = @ScheduleID )
    BEGIN
      
        SELECT 'Invalid ScheduleID' AS ResponseMessage;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
            ScheduleID,
            BusID,
            RouteID ,
           DepartureTime,
           ArrivalTime,
           Fare
        FROM 
          dbo.Schedules
        WHERE 
            ScheduleID = @ScheduleID;
    END
END;


