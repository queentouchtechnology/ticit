--Insert a New User
DECLARE @Response NVARCHAR(4000);
EXEC UpsertUser 
    @Username = 'jdoe', 
    @PasswordHash = 'hashed_password', 
    @Email = 'jdoe@example.com', 
    @Phone = '1234567890', 
    @UserType = 'User', 
    @WalletBalance = 50.00, 
    @DiscountPercentage = 5,
    @ResponseMessage = @Response OUTPUT;
PRINT @Response;  -- Outputs: "OK,User inserted successfully,NewUserID" or "Error,error_message,0"


--Update an Existing User
DECLARE @Response NVARCHAR(4000);
    EXEC UpsertUser 
    @UserID = 1,  -- Assume this user already exists
    @Username = 'jdoe_updated', 
    @PasswordHash = 'new_hashed_password', 
    @Email = 'jdoe@example.com', 
    @Phone = '0987654321', 
    @UserType = 'Admin', 
    @WalletBalance = 100.00, 
    @DiscountPercentage = 10,
    @ResponseMessage = @Response OUTPUT;
   PRINT @Response;  -- Outputs: "OK,User inserted successfully,NewUserID" or "Error,error_message,0"

   --RemoveUserAndRelatedData 
   DECLARE @Response NVARCHAR(4000);
EXEC RemoveUserAndRelatedData 
    @UserID = 1,
    @ResponseMessage = @Response OUTPUT;

-- Print the response message
PRINT @Response;  -- Outputs: "OK,User and corresponding data deleted successfully." or "Error,error_message"

SELECT * FROM Users;

--Read User procedure
EXEC dbo.ReadUser 
    @UserID = 5 