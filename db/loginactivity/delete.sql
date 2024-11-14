Create OR ALTER PROCEDURE dbo.RemoveLoginActivityDetails
@ActivityID INT
AS
BEGIN

    IF EXISTS (SELECT 1 FROM dbo.Logindetails WHERE ActivityID = @ActivityID)
    BEGIN

        DELETE FROM dbo.Logindetails WHERE  ActivityID = @ActivityID
        
  
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
      
        SELECT 'Error' AS Response, 'ActivityID not found' AS ResponseMessage
    END
END