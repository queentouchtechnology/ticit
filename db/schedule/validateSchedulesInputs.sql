CREATE OR ALTER PROCEDURE dbo.ValidateScheduleInput
  
    @BusID INT,
    @RouteID INT,
    @DepartureTime DATETIME,
    @ArrivalTime DATETIME,
    @Fare DECIMAL(10, 2),
    @ResponseMessage VARCHAR(200) OUTPUT
AS
BEGIN
    SET @ResponseMessage = '';

    -- Check if BusID exists
    IF @BusID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Buses WHERE BusID = @BusID)
    BEGIN
        SET @ResponseMessage = 'Bus ID is not matching or does not exist.';
        RETURN;
    END

    -- Check if RouteID exists
    IF @RouteID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Routes WHERE RouteID = @RouteID)
    BEGIN
        SET @ResponseMessage = 'Route ID is not matching or does not exist.';
        RETURN;
    END

    -- Validate that DepartureTime is earlier than ArrivalTime
    IF @DepartureTime >= @ArrivalTime
    BEGIN
        SET @ResponseMessage = 'DepartureTime must be earlier than ArrivalTime.';
        RETURN;
    END

    -- Validate that Fare is positive
    IF @Fare <= 0
    BEGIN
        SET @ResponseMessage = 'Fare must be a positive value.';
        RETURN;
    END

    -- If ScheduleID is provided, ensure it exists
    

    -- If no issues, return OK
    IF @ResponseMessage = ''
    BEGIN
        SET @ResponseMessage = 'OK';
    END
END
