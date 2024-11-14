CREATE OR ALTER PROCEDURE dbo.ReadUser
    @UserID INT
AS
BEGIN
    -- Check if @UserID is NULL or does not exist in dbo.Users
    IF @UserID IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Users WHERE UserID = @UserID)
    BEGIN
        -- Return a message if the UserID is invalid
        SELECT 'Invalid UserID or User Not Found' AS ResponseMessage;
    END
    ELSE
    BEGIN
        -- Retrieve and return user information if UserID exists
        SELECT 
         'OK' AS Response,
            UserID,
            Username,
            Email,
            Phone,
            UserType,
            CreateDate,
            WalletBalance,
            DiscountPercentage
        FROM 
            dbo.Users
        WHERE 
            UserID = @UserID;
    END
END;




           

