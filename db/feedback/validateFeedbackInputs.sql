CREATE OR ALTER PROCEDURE dbo.ValidateFeedbackInputs
    @BookingID INT,
    @Rating INT,
    @Comments TEXT,
    @FeedbackDate DATETIME,
    @ResponseMessage VARCHAR(255) OUTPUT
AS
BEGIN
    -- Initialize the response message as 'OK' (successful validation)
    SET @ResponseMessage = '';

    -- Check if the BookingID exists in the Bookings table
      IF @BookingID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Bookings WHERE BookingID = @BookingID)
    BEGIN
        SET @ResponseMessage = 'Invalid BookingID. ';
    END
    -- Check if the Rating is between 1 and 5
    IF @Rating < 1 OR @Rating > 5
    BEGIN
        SET @ResponseMessage = 'Error: Rating must be between 1 and 5.';
        RETURN;
    END

    -- Check if Comments is not null or empty (optional)
    IF @Comments IS NULL 
    BEGIN
        SET @ResponseMessage = 'Error: Comments cannot be empty.';
        RETURN;
    END

    -- Check if FeedbackDate is not a future date (optional validation)
    IF @FeedbackDate > GETDATE()
    BEGIN
        SET @ResponseMessage = 'Error: FeedbackDate cannot be in the future.';
        RETURN;
    END
    IF @ResponseMessage = ''
    BEGIN
    SET @ResponseMessage = 'OK';
    END
END;
