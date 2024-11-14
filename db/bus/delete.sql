
Create OR ALTER PROCEDURE dbo.RemoveBuseDetais
@BusID INT
AS
BEGIN

    IF EXISTS (SELECT 1 FROM dbo.Buses WHERE BusID = @BusID)
    BEGIN

        DELETE FROM dbo.Buses WHERE  BusID = @BusID
        
  
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
      
        SELECT 'Error' AS Response, 'BusID not found' AS ResponseMessage
    END
END
