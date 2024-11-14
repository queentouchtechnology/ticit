CREATE OR ALTER PROCEDURE dbo.ReadBus
    @BusID  INT
AS
BEGIN
   
    IF @BusID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Buses WHERE BusID   = @BusID  )
    BEGIN
      
        SELECT 'Invalid BusID' AS Response;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
          BusID,
          BusNumber,
          Capacity,
          BusType,
          OperatorName
        FROM 
          dbo.Buses
        WHERE 
            BusID  = @BusID ;
    END
END;


