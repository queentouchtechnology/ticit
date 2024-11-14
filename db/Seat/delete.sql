Create OR ALTER PROCEDURE dbo.RemoveSeatDetails
@SeatID INT 
AS
BEGIN
   
    IF EXISTS (SELECT 1 FROM dbo.Seats WHERE SeatID = @SeatID)
    BEGIN
        DELETE FROM dbo.Seats WHERE SeatID = @SeatID
        
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
        SELECT 'Error' AS Response, 'SeatID not found' AS ResponseMessage
    END
END