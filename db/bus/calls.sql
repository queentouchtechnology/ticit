
-- Call for adding a new bus record
EXEC dbo.AddOrUpdateBusRecord
    @BusID = NULL,  -- New record, so BusID is NULL
    @BusNumber = 'B12345',
    @Capacity = 50,
    @BusType = 'Standard',
    @OperatorName = 'XYZ Bus Services'

-- Call for updating an existing bus record
EXEC dbo.AddOrUpdateBusRecord
    @BusID = 1,  -- Existing BusID to update (replace with actual ID)
    @BusNumber = 'B1234',  -- New BusNumber if changing
    @Capacity = 60,  -- New Capacity if changing
    @BusType = 'Luxury',  -- New BusType if changing
    @OperatorName = 'XYZ Bus Services' -- New OperatorName if changing
   

EXEC RemoveBuseDetais 
    @BusID = 2       

SELECT * FROM dbo.Buses;

--Read Call Procedure 
EXEC dbo.ReadBus
 @BusID = 1

SELECT * FROM dbo.Buses;

