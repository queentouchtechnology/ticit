CREATE OR ALTER PROCEDURE dbo.ReadRoute
    @RouteID  INT
AS
BEGIN
   
    IF @RouteID   IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Routes WHERE RouteID   = @RouteID  )
    BEGIN
      
        SELECT 'Invalid RouteID ' AS ResponseMessage;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
            RouteID,
           StartLocation,
           EndLocation ,
           Distance ,
           EstimatedTime
        FROM 
          dbo.Routes
        WHERE 
            RouteID  = @RouteID ;
    END
END;

