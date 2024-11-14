EXEC dbo.UpsertLoginActivity
@ActivityID = NULL,
@UserName = 'jdoe', 
    @LoginTime = '2024-11-13', 
    @IsSuccess = 0, 
    @IPAddress = '192.168.1.1';


EXEC dbo.RemoveLoginActivityDetails
@ActivityID = 1


--Read Procedure Call
EXEC dbo.ReadLoginDetails
@ActivityID = 2


    SELECT * FROM dbo.Logindetails