CREATE OR ALTER PROCEDURE dbo.ValidateInputsSeat
@SeatID INT,
@ScheduleID INT,
@SeatNumber INT,
@IsAvailable BIT,
@ResponseMessage NVARCHAR(4000) OUTPUT
AS 
SET  @ResponseMessage =''
BEGIN
IF @ScheduleID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Schedules WHERE ScheduleID = @ScheduleID)
   BEGIN
      SET @ResponseMessage = 'ScheduleID is not matching or does not exist.';
       RETURN;
  END
IF @SeatNumber IS NULL OR EXISTS (SELECT 1 FROM dbo.Seats WHERE ScheduleID = @ScheduleID AND SeatNumber = @SeatNumber)
BEGIN
 SET @ResponseMessage = 'Invalid SeatNumber. It must be a positive integer. Seat airedy Booked';
 RETURN;
END
IF @IsAvailable IS NULL OR (@IsAvailable NOT IN (0, 1))
    BEGIN
        SET @ResponseMessage = ' Invalid IsAvailable value. It must be 0 (not available) or 1 (available).';
        RETURN;
    END
IF @SeatID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Seats WHERE SeatID = @SeatID)
    BEGIN
        SET @ResponseMessage = 'Error: SeatID does not exist in the Seats table.';
        RETURN;
    END
IF @ResponseMessage = ''
    BEGIN
        SET @ResponseMessage = 'OK';
    END
END
