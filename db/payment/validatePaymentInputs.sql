CREATE OR ALTER PROCEDURE dbo.ValidatePaymentInputs

@BookingID INT,
@PaymentDate DATETIME,
@Amount DECIMAL(10,2),
@PaymentMethod VARCHAR(50),
@PaymentStatus VARCHAR(50),
@ResponseMessage NVARCHAR(4000) OUTPUT
AS 
SET  @ResponseMessage =''
BEGIN
    -- Check if BookingID is provided
    IF @BookingID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Bookings WHERE BookingID = @BookingID)
    BEGIN
        SET @ResponseMessage = 'Invalid BookingID. ';
    END

    -- Check if PaymentDate is valid (cannot be in the future, for example)
    IF @PaymentDate IS NULL OR @PaymentDate > GETDATE()
    BEGIN
        SET @ResponseMessage = 'Invalid PaymentDate. ';
         RETURN;
    END

    -- Check if Amount is valid (e.g., greater than zero)
    IF @Amount IS NULL OR @Amount <= 0
    BEGIN
        SET @ResponseMessage = 'Invalid Amount. ';
         RETURN;
    END

    -- Validate PaymentMethod (e.g., should be one of several predefined methods)
    IF @PaymentMethod IS NULL OR NOT EXISTS (
        SELECT 1 FROM (VALUES ('Credit Card'), ('Debit Card'), ('Cash'), ('Online')) AS ValidMethods(Method)
        WHERE Method = @PaymentMethod
    )
    BEGIN
        SET @ResponseMessage = 'Invalid PaymentMethod. ';
         RETURN;
    END

    -- Validate PaymentStatus (e.g., should be one of several predefined statuses)
    IF @PaymentStatus IS NULL OR NOT EXISTS (
        SELECT 1 FROM (VALUES ('Pending'), ('Completed'), ('Failed'), ('Cancelled')) AS ValidStatuses(Status)
        WHERE Status = @PaymentStatus
    )
    BEGIN
        SET @ResponseMessage = 'Invalid PaymentStatus. ';
         RETURN;
    END
 


    -- If no errors, set success message
    IF @ResponseMessage = ''
    BEGIN
        SET @ResponseMessage = 'OK';
    END
END
