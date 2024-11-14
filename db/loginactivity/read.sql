CREATE OR ALTER PROCEDURE dbo.ReadLoginDetails
    @ActivityID INT
AS
BEGIN
   
    IF @ActivityID  IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Logindetails WHERE ActivityID  = @ActivityID )
    BEGIN
      
        SELECT 'Invalid ActivityID ' AS Response;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
            ActivityID ,
           UserName,
          LoginTime ,
           IsSuccess,
           IPAddress
        FROM 
          dbo.Logindetails
        WHERE 
            ActivityID  = @ActivityID ;
    END
END;