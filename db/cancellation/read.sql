CREATE OR ALTER PROCEDURE dbo.ReadCancellation
    @CancellationID  INT
AS
BEGIN
   
    IF @CancellationID  IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Cancellations WHERE CancellationID   = @CancellationID  )
    BEGIN
      
        SELECT 'Invalid CancellationID' AS Response;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
            CancellationID ,
           BookingID,
          CancellationDate ,
          RefundAmount,
           Reason
        FROM 
          dbo.Cancellations
        WHERE 
            CancellationID  = @CancellationID ;
    END
END;

