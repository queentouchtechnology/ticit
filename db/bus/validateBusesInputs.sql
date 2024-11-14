CREATE OR ALTER PROCEDURE dbo.ValidateBusInput
    @BusNumber NVARCHAR(20),
    @BusID INT,
    @Capacity NVARCHAR(20),
    @BusType VARCHAR(50),
    @OperatorName VARCHAR(100),
    @ResponseMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    SET @ResponseMessage = ''

    -- Check if Capacity is a positive integer
    IF TRY_CAST(@Capacity AS INT) IS NULL OR CAST(@Capacity AS INT) <= 0
    BEGIN
        SET @ResponseMessage = 'Capacity must be a positive integer.'
        RETURN  -- Stop execution if an error is found
    END

    -- Check if BusNumber is unique (consider @BusID for updates)
    IF EXISTS (SELECT 1 FROM Buses WHERE BusNumber = @BusNumber AND (@BusID IS NULL OR BusID <> @BusID))
    BEGIN
        SET @ResponseMessage = 'BusNumber must be unique.'
        RETURN  -- Stop execution if an error is found
    END

    -- Check if BusType is not empty
    IF @BusType = ''
    BEGIN
        SET @ResponseMessage = 'BusType cannot be empty.'
        RETURN  -- Stop execution if an error is found
    END

    -- Check if OperatorName is not empty
    IF @OperatorName = ''
    BEGIN
        SET @ResponseMessage = 'OperatorName cannot be empty.'
        RETURN  -- Stop execution if an error is found
    END

    -- Check if BusID exists for update scenario
    IF @BusID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Buses WHERE BusID = @BusID)
    BEGIN
        SET @ResponseMessage = 'No bus record found with the provided BusID.'
        RETURN  -- Stop execution if an error is found
    END

    -- If all validations pass, set OK
    IF @ResponseMessage = ''
    BEGIN
        SET @ResponseMessage = 'OK'
    END
END
