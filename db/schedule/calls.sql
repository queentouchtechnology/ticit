
SELECT * FROM dbo.Schedules;

EXEC dbo.UpsertSchedule
    @ScheduleID = NULL ,                      
    @BusID = 1,                           
    @RouteID = 2,                         
    @DepartureTime = '2024-11-12 12:00',  
    @ArrivalTime = '2024-11-12 14:00',     
    @Fare = 20.00 


    DECLARE @ResponseMessage VARCHAR(200);
EXEC dbo.ValidateScheduleInput 
    @ScheduleID = NUll ,
    @BusID = 3,
    @RouteID = 4,
    @DepartureTime = '2024-01-01 08:00:00',
    @ArrivalTime = '2024-01-01 12:00:00',
    @Fare = 100.00,
    @ResponseMessage = @ResponseMessage OUTPUT;

SELECT @ResponseMessage AS ResponseMessage;

EXEC dbo.UpsertSchedule
@ScheduleID = 1 ,
    @BusID = 3,
    @RouteID = 3,
    @DepartureTime = '2024-01-01 08:00:00.000',
    @ArrivalTime = '2024-01-01 12:00:00.000',
    @Fare = 100.00


    -- REMOVE RECORED IN TABLE 
 EXEC dbo.RemovescheduleDetails
 @ScheduleID = 1

SELECT * FROM dbo.Schedules;

--Read procedure Call
EXEC dbo.ReadSchedule
@ScheduleID = 2 

SELECT * FROM dbo.Schedules;
