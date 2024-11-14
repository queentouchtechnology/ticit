Create OR ALTER PROCEDURE dbo.RemoveCancellationDetails
@CancellationID INT
AS
BEGIN
   
    IF EXISTS (SELECT 1 FROM dbo.Cancellations WHERE CancellationID= @CancellationID)
    BEGIN
    
        DELETE FROM dbo.Cancellations WHERE CancellationID = @CancellationID
        
     
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
        
        SELECT 'Error' AS Response, 'CancellationID not found' AS ResponseMessage
    END
END