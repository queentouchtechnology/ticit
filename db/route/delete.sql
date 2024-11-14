Create OR ALTER PROCEDURE dbo.RemoveRouteDetails
@RouteID INT
AS
BEGIN
    -- Check if the RouteID exists in the Routes table
    IF EXISTS (SELECT 1 FROM dbo.Routes WHERE RouteID = @RouteID)
    BEGIN
        -- Perform the delete operation
        DELETE FROM dbo.Routes WHERE RouteID = @RouteID
        
        -- Return success message
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
        -- Return error message if RouteID does not exist
        SELECT 'Error' AS Response, 'RouteID not found' AS ResponseMessage
    END
END