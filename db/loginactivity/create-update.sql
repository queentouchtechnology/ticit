CREATE OR ALTER PROCEDURE dbo.UpsertLoginActivity
@ActivityID INT,
@UserName NVARCHAR(255),
    @LoginTime DATETIME,
    @IsSuccess BIT,
    @IPAddress NVARCHAR(50)
AS
DECLARE @test VARCHAR(200)
BEGIN
EXEC dbo.ValidateLoginDetails @UserName,@LoginTime,@IsSuccess,@IPAddress,@test OUTPUT
IF @test = 'OK'
BEGIN
IF @ActivityID IS NULL
BEGIN
INSERT INTO dbo.Logindetails (UserName,LoginTime,IsSuccess,IPAddress)
VALUES (@UserName,@LoginTime,@IsSuccess,@IPAddress)
SELECT 'OK' as Response,'ADDED' as ResponseMessage
END
ELSE 
BEGIN
UPDATE dbo.Logindetails
SET 
UserName = @UserName,
LoginTime = @LoginTime,
IsSuccess = @IsSuccess,
IPAddress = @IPAddress
WHERE ActivityID  = @ActivityID
SELECT 'OK' as Response,'UPDATED' as ResponseMessage
END
END
ELSE
    BEGIN
        SELECT 'Error' as Response,@test as ResponseMessage
    END
END

