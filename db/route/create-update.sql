
CREATE OR ALTER PROCEDURE dbo.UpsertRoute 
@RouteID INT = NULL,
@StartLocation VARCHAR(100),
@EndLocation VARCHAR(100),
@Distance DECIMAL(8,2),
@EstimatedTime VARCHAR(50)

AS
DECLARE @test VARCHAR(100)
BEGIN
EXEC dbo.ValidateRoutesInput @RouteID,@StartLocation,@EndLocation,@Distance,EstimatedTime,@test OUTPUT
IF @test ='OK'
BEGIN
   IF @RouteID IS NULL
   BEGIN
     INSERT INTO dbo.Routes (StartLocation,EndLocation,Distance,EstimatedTime)
     VALUES (@StartLocation,@EndLocation,@Distance,@EstimatedTime)
     SELECT 'OK' as Response,'ADDED' as ResponseMessage
   END
   ELSE
   BEGIN
   UPDATE dbo.Routes
   SET StartLocation = @StartLocation,
       EndLocation = @EndLocation,
       Distance = @Distance,
       EstimatedTime = @EstimatedTime
       WHERE RouteID = @RouteID
       SELECT 'OK' as Response,'UPDATED' as ResponseMessage
   END
END
ELSE
    BEGIN
        SELECT 'Error' as Response,@test as ResponseMessage
    END


END