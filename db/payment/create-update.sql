CREATE OR ALTER PROCEDURE dbo.UpsertPayment
@PaymentID INT,
@BookingID INT,
@PaymentDate DATETIME,
@Amount DECIMAL(10,2),
@PaymentMethod VARCHAR(50),
@PaymentStatus VARCHAR(50)
AS
DECLARE @test VARCHAR(200)
BEGIN
EXEC dbo.ValidatePaymentInputs @BookingID,@PaymentDate,@Amount,@PaymentMethod,@PaymentStatus,@test OUTPUT
IF @test = 'OK'
BEGIN
IF @PaymentID IS NULL
   BEGIN
   INSERT INTO dbo.Payments (BookingID,PaymentDate,Amount,PaymentMethod,PaymentStatus)
   VALUES (@BookingID,@PaymentDate,@Amount,@PaymentMethod,@PaymentStatus)
   SELECT 'OK' as Response,'ADDED' as ResponseMessage
      END
ELSE
BEGIN
UPDATE dbo.Payments
SET 
PaymentDate = @PaymentDate,
Amount = @Amount,
PaymentMethod = @PaymentMethod,
PaymentStatus = @PaymentStatus
WHERE PaymentID  = @PaymentID 
SELECT 'OK' as Response,'UPDATED' as ResponseMessage
END
END
ELSE
    BEGIN
        SELECT 'Error' as Response,@test as ResponseMessage
    END
END