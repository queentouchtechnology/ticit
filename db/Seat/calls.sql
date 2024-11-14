EXEC dbo.UpsertSeat
    @SeatID = 6 ,              
    @ScheduleID = 2,        
    @SeatNumber = 10,          
    @IsAvailable = 0 

EXEC dbo.RemoveSeatDetails
 @SeatID = 4

SELECT * FROM dbo.Seats; 

--Read procedure call
EXEC  dbo.ReadSeat
@SeatID = 1
