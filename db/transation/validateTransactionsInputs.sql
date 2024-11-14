CREATE OR ALTER PROCEDURE dbo.ValidateTransactionInput
    @UserID INT,
    @Amount DECIMAL(10,2),
    @TransactionType VARCHAR(50),
    @Description VARCHAR(255),
    @ResponseMessage VARCHAR(100) OUTPUT  -- Output parameter to store the validation message
AS
BEGIN
    -- Initialize the response message variable
    SET @ResponseMessage = '';

    -- Validate UserID (Ensure the user exists in the Users table)
    IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE UserID = @UserID)
    BEGIN
        SET @ResponseMessage = @ResponseMessage + 'Invalid UserID. The user does not exist. ';
    END
    
    -- Validate Amount (Ensure Amount is greater than 0)
    IF @Amount <= 0
    BEGIN
        SET @ResponseMessage = @ResponseMessage + 'Invalid Amount. The amount must be greater than zero. ';
    END

    -- Validate TransactionType (Ensure it's not NULL or empty)
    IF @TransactionType IS NULL OR LTRIM(RTRIM(@TransactionType)) = ''
    BEGIN
        SET @ResponseMessage = @ResponseMessage + 'Invalid TransactionType. It cannot be null or empty. ';
    END
    
    -- Validate Description (Ensure it's not too long)
    IF LEN(@Description) > 255
    BEGIN
        SET @ResponseMessage = @ResponseMessage + 'Invalid Description. It cannot exceed 255 characters. ';
    END

    -- If no errors were found, set success message
    IF @ResponseMessage = ''
    BEGIN
        SET @ResponseMessage = 'OK';
    END
END;
