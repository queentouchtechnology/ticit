CREATE OR ALTER PROCEDURE dbo.UpsertSchedule
    @ScheduleID INT ,
    @BusID INT,
    @RouteID INT,
    @DepartureTime DATETIME,
    @ArrivalTime DATETIME,
    @Fare DECIMAL(10, 2)
AS
DECLARE @test VARCHAR(200)
BEGIN 
EXEC dbo.ValidateScheduleInput @BusID,@RouteID,@DepartureTime,@ArrivalTime,@Fare,@test OUTPUT
--SET @test='OK'
IF @test ='OK'
BEGIN
   IF @ScheduleID IS NULL
BEGIN
   INSERT INTO dbo.Schedules (BusID,RouteID,DepartureTime,ArrivalTime,Fare) 
   VALUES (@BusID,@RouteID,@DepartureTime,@ArrivalTime,@Fare)
   SELECT 'OK' as Response,'ADDED' as ResponseMessage
END
ELSE 
BEGIN
UPDATE dbo.Schedules 
SET 
BusID = @BusID,
RouteID = @RouteID,
DepartureTime = @DepartureTime,
ArrivalTime = @ArrivalTime,
Fare = @Fare
WHERE ScheduleID = @ScheduleID
SELECT 'OK' as Response,'UPDATED' as ResponseMessage
END
END
ELSE
    BEGIN
        SELECT 'Error' as Response,@test as ResponseMessage
    END
END