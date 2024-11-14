CREATE OR ALTER PROCEDURE dbo.ValidateLoginDetails
    @UserName NVARCHAR(255),
    @LoginTime DATETIME,
    @IsSuccess BIT,
    @IPAddress NVARCHAR(50),
    @ResponseMessage VARCHAR(255) OUTPUT
AS
BEGIN
     SET @ResponseMessage = '';

    -- Check if UserName is NULL or empty
    IF @UserName IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Users WHERE Username = @UserName)
    BEGIN
        SET @ResponseMessage = 'Error: UserName Not Matching.';
    END
    -- Check if LoginTime is NULL or in the future
     IF (@LoginTime IS NULL OR @LoginTime > GETDATE())
    BEGIN
        SET @ResponseMessage = 'Error: LoginTime is invalid or set in the future.';
    END
    -- Check if IsSuccess is not a valid BIT value (this is rarely needed but shown here for completeness)
     IF (@IsSuccess NOT IN (0, 1))
    BEGIN
        SET @ResponseMessage = 'Error: IsSuccess must be 0 (failure) or 1 (success).';
    END
    -- Check if IPAddress is NULL or empty
     IF (@IPAddress IS NULL OR LTRIM(RTRIM(@IPAddress)) = '')
    BEGIN
        SET @ResponseMessage = 'Error: IPAddress cannot be empty.';
    END
     IF @ResponseMessage = ''
    BEGIN
    SET @ResponseMessage = 'OK';
    END
END;
