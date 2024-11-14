Create OR ALTER PROCEDURE dbo.RemovePaymentDetails
@PaymentID INT
AS
BEGIN
    -- Check if the BookingIDexists in the Routes table
    IF EXISTS (SELECT 1 FROM  dbo.Payments WHERE PaymentID = @PaymentID)
    BEGIN
        -- Perform the delete operation
        DELETE FROM dbo.Payments WHERE  PaymentID = @PaymentID
        
        -- Return success message
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
        -- Return error message if BookingID does not exist
        SELECT 'Error' AS Response, 'PaymentID not found' AS ResponseMessage
    END
END