
-- INSERT OR UPDATE CALL
EXEC dbo.UpsertCancellation
@CancellationID = 2,
    @BookingID = 2, 
    @CancellationDate = '2024-11-13', 
    @RefundAmount = 50.00, 
    @Reason = 'TRIP CANCELLED'

SELECT * FROM dbo.Cancellations;

--DELETE CALLS
 EXEC dbo.RemoveCancellationDetails
 @CancellationID = 1


 --Read Call Procedure 
 EXEC dbo.ReadCancellation
@CancellationID = 2

SELECT * FROM dbo.Cancellations;



