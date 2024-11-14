CREATE OR ALTER PROCEDURE dbo.UpsertTransaction
    @TransactionID INT = NULL,  -- NULL means insert a new record
    @UserID INT,
    @Amount DECIMAL(10, 2),
    @TransactionType VARCHAR(50),
    @Description VARCHAR(255),
    @ResponseMessage VARCHAR(255) OUTPUT-- Output parameter to return the message
AS
BEGIN
    BEGIN 
        -- Initialize the response message with a default validation message     

        -- Step 1: Validate the inputs
        EXEC dbo.ValidateTransactionInput @UserID, @Amount, @TransactionType, @Description, @ResponseMessage OUTPUT;
          IF @ResponseMessage='OK' 
    BEGIN

    IF @TransactionID IS NULL
    BEGIN
      INSERT INTO dbo.Transactions (UserID, Amount, TransactionType, Description)
        VALUES (@UserID, @Amount, @TransactionType, @Description);
        SET @ResponseMessage = 'Transaction successfully Addedd.';
        END
        ELSE
        BEGIN
         -- Update the existing record
        UPDATE dbo.Transactions
        SET 
            UserID = @UserID,
            Amount = @Amount,
            TransactionType = @TransactionType,
            Description = @Description
        WHERE TransactionID = @TransactionID;

        -- Set response message for update
        SET @ResponseMessage = 'Transaction successfully updated.';
        END
    END 
     ELSE
    BEGIN
       select @ResponseMessage;
    END
    END
END;
