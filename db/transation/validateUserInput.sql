CREATE OR ALTER PROCEDURE dbo.ValidateTransaction
    @UserID INT,
    @Amount DECIMAL(10,2),
    @TransactionType VARCHAR(50),
    @Description VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate input parameters
    IF @UserID IS NULL
    BEGIN
        RAISERROR('UserID cannot be NULL.', 16, 1);
        RETURN;
    END

    IF @Amount <= 0
    BEGIN
        RAISERROR('Amount must be greater than 0.', 16, 1);
        RETURN;
    END

    IF @TransactionType IS NULL OR LEN(LTRIM(RTRIM(@TransactionType))) = 0
    BEGIN
        RAISERROR('TransactionType cannot be NULL or empty.', 16, 1);
        RETURN;
    END

    IF @Description IS NULL OR LEN(LTRIM(RTRIM(@Description))) = 0
    BEGIN
        RAISERROR('Description cannot be NULL or empty.', 16, 1);
        RETURN;
    END
END;