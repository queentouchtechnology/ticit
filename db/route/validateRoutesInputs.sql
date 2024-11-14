CREATE OR ALTER PROCEDURE dbo.ValidateRoutesInput
@RouteID INT,
@BusID INT,
@StartLocation VARCHAR(100),
@EndLocation VARCHAR(100),
@Distance DECIMAL(8,2),
@EstimatedTime VARCHAR(50),
@ResponseMessage NVARCHAR(255) OUTPUT
AS
BEGIN
SET @ResponseMessage = ''

IF @StartLocation =''
   BEGIN
   SET @ResponseMessage = 'THE START LOCATION CANNOT BE EMPTY' 
   RETURN
   END
IF @EndLocation = ''
   BEGIN
   SET @ResponseMessage = 'THE END LOCATION CANNOT BE EMPTY' 
   RETURN
   END
IF TRY_CAST(@Distance AS INT) IS NULL OR CAST(@Distance AS INT) <= 0
   BEGIN
   SET @ResponseMessage = 'THE END LOCATION CANNOT BE EMPTY'
   RETURN
   END
IF @EstimatedTime = ''
   BEGIN
   SET @ResponseMessage = 'THE END LOCATION CANNOT BE EMPTY' 
   RETURN
   END
IF @RouteID IS NOT NULL AND  EXISTS (SELECT 1 FROM dbo.Routes WHERE RouteID = @RouteID)
    BEGIN
    SET @ResponseMessage = 'No record found with the provided RouteID.'
    RETURN  -- Stop execution if an error is found
    END
IF @ResponseMessage = ''
   BEGIN
   SET @ResponseMessage = 'OK'
   END
END