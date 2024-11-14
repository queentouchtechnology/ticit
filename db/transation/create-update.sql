
CREATE OR ALTER PROCEDURE dbo.UpsertTransaction
    @TransactionID INT = NULL,          -- Input: NULL for new transactions
    @UserID INT,
    @TransactionDate DATE = NULL,       -- Optional: You can provide the transaction date
    @Amount DECIMAL(10,2),
    @TransactionType VARCHAR(50),
    @Description VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate input parameters by calling the validation procedure
    EXEC dbo.ValidateTransaction @UserID = UserID, @Amount = Amount, @TransactionType = Transactions, @Description = Description;

    -- Start a transaction to ensure atomicity
    BEGIN TRY
        BEGIN TRANSACTION;

        -- If @TransactionID is provided, check if the transaction exists for UPDATE
        IF @TransactionID IS NOT NULL AND EXISTS (SELECT 1 FROM dbo.Transactions WHERE TransactionID = @TransactionID)
        BEGIN
            -- If exists, update the record
            UPDATE dbo.Transactions
            SET 
                UserID = @UserID,
                TransactionDate = ISNULL(@TransactionDate, GETDATE()),  -- Default to current date if not provided
                Amount = @Amount,
                TransactionType = @TransactionType,
                Description = @Description
            WHERE TransactionID = @TransactionID;
        END
        ELSE
        BEGIN
            -- If not exists, insert a new record
            INSERT INTO dbo.Transactions (UserID, TransactionDate, Amount, TransactionType, Description)
            VALUES (@UserID, ISNULL(@TransactionDate, GETDATE()), @Amount, @TransactionType, @Description);
        END

        -- Commit the transaction if no errors
        COMMIT TRANSACTION;

        -- Optionally, return the TransactionID of the upserted record
        IF @TransactionID IS NULL
        BEGIN
            SET @TransactionID = SCOPE_IDENTITY();  -- Get the newly inserted TransactionID
        END

        -- Return the result
        SELECT @TransactionID AS TransactionID;

    END TRY
    BEGIN CATCH
        -- If any error occurs, roll back the transaction
        ROLLBACK TRANSACTION;
        RAISERROR('An error occurred while processing the transaction.', 16, 1);
    END CATCH
END;

EXEC dbo.UpsertTransaction 
    @TransactionID = NULL, 
    @UserID = 123, 
    @Amount = 100.00, 
    @TransactionType = 'Credit', 
    @Description = 'Payment for invoice #123';



