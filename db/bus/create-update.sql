CREATE OR ALTER PROCEDURE dbo.UpsertBus
    @BusID INT = NULL,              -- Use NULL for new records, and an integer for updates
    @BusNumber VARCHAR(20),
    @Capacity INT,
    @BusType VARCHAR(50),
    @OperatorName VARCHAR(100)
    --@ResponseMessage NVARCHAR(200) OUTPUT
AS
BEGIN
    DECLARE @test NVARCHAR(255)
   
    -- Validate inputs
    EXEC ValidateBusInput @BusNumber, @BusID, @Capacity, @BusType, @OperatorName, @test OUTPUT

    IF @test = 'OK'
    BEGIN
        -- For new records (BusID is NULL)
        IF @BusID IS NULL
        BEGIN
            INSERT INTO Buses (BusNumber, Capacity, BusType, OperatorName)
            VALUES (@BusNumber, @Capacity, @BusType, @OperatorName)

           -- SET @ResponseMessage = 'ADDED'
           SELECT 'OK' as Response,'ADDED' as ResponseMessage
            
        END
        ELSE
        BEGIN
            -- For updates (BusID is not NULL)
            UPDATE Buses
            SET BusNumber = @BusNumber,
                Capacity = @Capacity,
                BusType = @BusType,
                OperatorName = @OperatorName
            WHERE BusID = @BusID 

            --SET @ResponseMessage = 'UPDATED'
             SELECT 'OK' as Response,'UPDATED' as ResponseMessage
        END
    END
    ELSE
    BEGIN
        -- If validation fails, set the error message
        --SET @ResponseMessage = @test
        SELECT 'Error' as Response,@test as ResponseMessage
    END

     
END
