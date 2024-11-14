Create OR ALTER PROCEDURE dbo.RemoveBookingDetails
@BookingID INT
AS
BEGIN
    -- Check if the BookingIDexists in the Routes table
    IF EXISTS (SELECT 1 FROM dbo.Bookings WHERE BookingID = @BookingID)
    BEGIN
        -- Perform the delete operation
        DELETE FROM dbo.Bookings WHERE BookingID= @BookingID
        
        -- Return success message
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
        -- Return error message if BookingID does not exist
        SELECT 'Error' AS Response, 'BookingID not found' AS ResponseMessage
    END
END