Create OR ALTER PROCEDURE dbo.RemoveTransactionDetails
@TransactionID INT
AS
BEGIN

    IF EXISTS (SELECT 1 FROM dbo.Transactions WHERE TransactionID = @TransactionID)
    BEGIN

        DELETE FROM dbo.Transactions WHERE  TransactionID = @TransactionID
        
  
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
      
        SELECT 'Error' AS Response, 'TransactionID not found' AS ResponseMessage
    END
END