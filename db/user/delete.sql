CREATE OR ALTER PROCEDURE RemoveUserAndRelatedData
    @UserID INT,
    @ResponseMessage NVARCHAR(4000) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Begin transaction
        BEGIN TRANSACTION;

        -- Delete corresponding data in child tables (orders, transactions, etc.)
    

        -- Example: Remove user's transactions
        --DELETE FROM Transactions
        --WHERE UserID = @UserID;

        -- Example: Remove user's profile data (if applicable)
        --DELETE FROM UserProfiles
        --WHERE UserID = @UserID;

        ---- Example: Remove user's preferences (if applicable)
        --DELETE FROM UserPreferences
        --WHERE UserID = @UserID;

        -- Finally, delete the user from the Users table
        DELETE FROM Users
        WHERE UserID = @UserID;

        -- Commit transaction
        COMMIT TRANSACTION;

        -- Set the success response message
        SET @ResponseMessage = 'OK,User and corresponding data deleted successfully.';
    END TRY
    BEGIN CATCH
        -- Rollback transaction if any error occurs
        ROLLBACK TRANSACTION;

        -- Handle errors (optional: log the error message, etc.)
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        
        -- Set the error response message
        SET @ResponseMessage = 'Error,' + @ErrorMessage;
    END CATCH
END;
