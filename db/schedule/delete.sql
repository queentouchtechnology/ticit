Create OR ALTER PROCEDURE dbo.RemovescheduleDetails
@ScheduleID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM dbo.Schedules WHERE ScheduleID = @ScheduleID)
    BEGIN
        DELETE FROM dbo.Schedules WHERE ScheduleID = @ScheduleID
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
        SELECT 'Error' AS Response, 'ScheduleID not found' AS ResponseMessage
    END
END