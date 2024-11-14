CREATE or ALTER PROCEDURE dbo.UpsertUser
    @UserID INT = NULL,
    @Username VARCHAR(50),
    @PasswordHash VARCHAR(255),
    @Email VARCHAR(100),
    @Phone VARCHAR(15) = NULL,
    @UserType VARCHAR(20) = 'User',
    @WalletBalance DECIMAL(10,2) = 0,
    @DiscountPercentage DECIMAL(5,2) = 2,
    @ResponseMessage NVARCHAR(4000) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Call validation procedure
        EXEC ValidateUserInputs
            @Username = @Username,
            @PasswordHash = @PasswordHash,
            @Email = @Email,
            @Phone = @Phone,
            @UserType = @UserType,
            @WalletBalance = @WalletBalance,
            @DiscountPercentage = @DiscountPercentage;

        -- Begin transaction for insert/update
        BEGIN TRANSACTION;

        DECLARE @CreatedUserID INT;

        IF @UserID IS NULL OR NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
        BEGIN
            -- Insert new user
            INSERT INTO Users (Username, PasswordHash, Email, Phone, UserType, WalletBalance, DiscountPercentage)
            VALUES (@Username, @PasswordHash, @Email, @Phone, @UserType, @WalletBalance, @DiscountPercentage);

            SET @CreatedUserID = SCOPE_IDENTITY();  -- Capture the ID of the newly inserted record
            SET @ResponseMessage = 'OK,User inserted successfully,' + CAST(@CreatedUserID AS NVARCHAR(20));
        END
        ELSE
        BEGIN
            -- Update existing user
            UPDATE Users
            SET
                Username = @Username,
                PasswordHash = @PasswordHash,
                Email = @Email,
                Phone = @Phone,
                UserType = @UserType,
                WalletBalance = @WalletBalance,
                DiscountPercentage = @DiscountPercentage
            WHERE UserID = @UserID;

            SET @ResponseMessage = 'OK,User updated successfully,' + CAST(@UserID AS NVARCHAR(20));
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Handle errors and set response message in desired format
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        SET @ResponseMessage = 'Error,' + @ErrorMessage + ',0';
    END CATCH
END;
