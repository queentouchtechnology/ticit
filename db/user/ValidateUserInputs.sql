CREATE or alter  PROCEDURE dbo.ValidateUserInputs
    @Username VARCHAR(50),
    @PasswordHash VARCHAR(255),
    @Email VARCHAR(100),
    @Phone VARCHAR(15) = NULL,
    @UserType VARCHAR(20) = 'User',
    @WalletBalance DECIMAL(10,2) = 0,
    @DiscountPercentage DECIMAL(5,2) = 2
AS
BEGIN
    -- Username validation
    IF @Username IS NULL OR LEN(@Username) < 3
    BEGIN
        RAISERROR('Username is required and must be at least 3 characters long.', 16, 1);
        RETURN;
    END

    -- PasswordHash validation
    IF @PasswordHash IS NULL OR LEN(@PasswordHash) < 8
    BEGIN
        RAISERROR('PasswordHash is required and must be at least 8 characters long.', 16, 1);
        RETURN;
    END

    -- Email validation
    IF @Email IS NULL OR NOT (@Email LIKE '%_@__%.__%')
    BEGIN
        RAISERROR('A valid Email is required.', 16, 1);
        RETURN;
    END

    -- Phone validation
    IF @Phone IS NOT NULL AND LEN(@Phone) < 10
    BEGIN
        RAISERROR('Phone number must be at least 10 digits long if provided.', 16, 1);
        RETURN;
    END

    -- UserType validation
    IF @UserType NOT IN ('User', 'Admin')
    BEGIN
        RAISERROR('UserType must be either "User" or "Admin".', 16, 1);
        RETURN;
    END

    -- WalletBalance validation
    IF @WalletBalance < 0
    BEGIN
        RAISERROR('WalletBalance cannot be negative.', 16, 1);
        RETURN;
    END

    -- DiscountPercentage validation
    IF @DiscountPercentage < 0 OR @DiscountPercentage > 100
    BEGIN
        RAISERROR('DiscountPercentage must be between 0 and 100.', 16, 1);
        RETURN;
    END
END;
