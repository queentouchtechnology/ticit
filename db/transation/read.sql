CREATE OR ALTER PROCEDURE dbo.ReadTransaction
    @TransactionID INT
AS
BEGIN
   
    IF @TransactionID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Transactions WHERE TransactionID  = @TransactionID  )
    BEGIN
      
        SELECT 'Invalid TransactionID' AS Response;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
          TransactionID,
           UserID,
          TransactionDate,
            Amount,
         TransactionType,
          Description
        FROM 
          dbo.Transactions
        WHERE 
            TransactionID  = @TransactionID;
    END
END;








