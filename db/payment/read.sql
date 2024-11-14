CREATE OR ALTER PROCEDURE dbo.ReadPayment
    @PaymentID  INT
AS
BEGIN
   
    IF @PaymentID  IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Payments WHERE PaymentID   = @PaymentID  )
    BEGIN
      
        SELECT 'Invalid PaymentID ' AS Response;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
            PaymentID,
           BookingID,
           PaymentDate ,
           Amount,
           PaymentMethod,
           PaymentStatus
        FROM 
          dbo.Payments
        WHERE 
            PaymentID  = @PaymentID ;
    END
END;

