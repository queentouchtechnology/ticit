CREATE OR ALTER PROCEDURE dbo.SetLogin
@Username VARCHAR(50),
@PasswordHash VARCHAR(255),
 @ResponseMessage NVARCHAR(4000) OUTPUT
As
SET  @ResponseMessage =''
BEGIN
IF @Username IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Users WHERE Username = @Username)
    BEGIN
        SET @ResponseMessage = 'UserName is not matching or does not exist.';
        RETURN;
    END
    IF @PasswordHash IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Users WHERE @PasswordHash = @PasswordHash)
    BEGIN
        SET @ResponseMessage = 'Wrong Password';
        RETURN;
    END
END