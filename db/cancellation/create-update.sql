CREATE OR ALTER PROCEDURE dbo.UpsertCancellation
@CancellationID INT,
@BookingID INT,
    @CancellationDate DATETIME,
    @RefundAmount DECIMAL(10,2),
    @Reason VARCHAR(255)
AS
DECLARE @test VARCHAR(200)
BEGIN
EXEC dbo.ValidateCancellationInput @BookingID,@CancellationDate,@RefundAmount,@Reason,@test OUTPUT
IF @test = 'OK'
BEGIN
IF @CancellationID IS NULL
   BEGIN
   INSERT INTO dbo.Cancellations (BookingID,CancellationDate,RefundAmount,Reason)
   VALUES (@BookingID,@CancellationDate,@RefundAmount,@Reason)
   SELECT 'OK' as Response,'ADDED' as ResponseMessage
      END
ELSE
BEGIN
UPDATE dbo.Cancellations
SET 
CancellationDate = @CancellationDate,
RefundAmount = @RefundAmount,
Reason = @Reason
WHERE CancellationID  = @CancellationID
SELECT 'OK' as Response,'UPDATED' as ResponseMessage
END
END
ELSE
    BEGIN
        SELECT 'Error' as Response,@test as ResponseMessage
    END
END