CREATE OR ALTER PROCEDURE dbo.UpsertSeat
@SeatID INT,
@ScheduleID INT,
@SeatNumber INT,
@IsAvailable BIT
AS
DECLARE @test VARCHAR(200)
BEGIN
EXEC dbo.ValidateInputsSeat @SeatID,@ScheduleID,@SeatNumber,@IsAvailable,@test OUTPUT
IF @test ='OK'
BEGIN
IF  @SeatID IS NULL
BEGIN
   INSERT INTO dbo.Seats (ScheduleID,SeatNumber,IsAvailable) 
   VALUES (@ScheduleID,@SeatNumber,@IsAvailable)
   SELECT 'OK' as Response,'ADDED' as ResponseMessage
END
ELSE
BEGIN
UPDATE dbo.Seats 
SET 
SeatNumber = @SeatNumber,
IsAvailable = @IsAvailable
WHERE SeatID  = @SeatID 
SELECT 'OK' as Response,'UPDATED' as ResponseMessage
END
END
ELSE
    BEGIN
        SELECT 'Error' as Response,@test as ResponseMessage
    END
END 

