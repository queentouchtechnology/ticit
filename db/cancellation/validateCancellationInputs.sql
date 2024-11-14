CREATE OR ALTER PROCEDURE dbo.ValidateCancellationInput
    @BookingID INT,
    @CancellationDate DATETIME,
    @RefundAmount DECIMAL(10,2),
    @Reason VARCHAR(255),
    @ResponseMessage VARCHAR(255) OUTPUT
AS
SET @ResponseMessage = ''
BEGIN

  IF @BookingID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Bookings WHERE BookingID = @BookingID)
    BEGIN
        SET @ResponseMessage = 'Invalid BookingID. ';
    END
   -- Validate the RefundAmount (should not be negative)
    IF @RefundAmount < 0
    BEGIN
        SET @ResponseMessage = 'Refund amount cannot be negative.';
        RETURN;
    END

    -- Validate the CancellationDate (should not be in the future)
    IF @CancellationDate > GETDATE()
    BEGIN
        SET @ResponseMessage = 'Cancellation date cannot be in the future.';
        RETURN;
    END

    -- Validate that the Reason is not empty
    IF @Reason IS NULL OR LTRIM(RTRIM(@Reason)) = ''
    BEGIN
        SET @ResponseMessage = 'Cancellation reason cannot be empty.';
        RAISERROR(@ResponseMessage, 16, 1);
        RETURN;
    END

IF @ResponseMessage = ''
    BEGIN
    SET @ResponseMessage = 'OK';
    END
END;