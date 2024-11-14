--Inserting a New Transaction:
DECLARE @ResponseMessage VARCHAR(255);

EXEC dbo.UpsertTransaction 
    @TransactionID = NULL, 
    @UserID = 5, 
    @Amount = 100.00, 
    @TransactionType = 'Deposit', 
    @Description = ' savings',
    @ResponseMessage = @ResponseMessage OUTPUT;

-- Output the response message
SELECT @ResponseMessage AS Response;


--Updating an Existing Transaction:
DECLARE @ResponseMessage VARCHAR(255);

EXEC dbo.UpsertTransaction 
    @TransactionID = NULL, 
    @UserID = 5, 
    @Amount = 200.00, 
    @TransactionType = 'Withdrawal', 
    @Description = 'Withdrawal from checking',
    @ResponseMessage = @ResponseMessage OUTPUT;




SELECT * FROM dbo.Transactions;
SELECT * FROM dbo.Users;

DECLARE @ResponseMessage VARCHAR(255);

EXEC dbo.UpsertTransaction 
    @TransactionID = NULL,         
    @UserID = 1,                    
    @Amount = 100.00,           
    @TransactionType = 'Credit',  
    @Description = 'Initial Deposit', 
    @ResponseMessage = @ResponseMessage OUTPUT; 

-- Check the response message
PRINT @ResponseMessage;

--Read Procedure call
EXEC dbo.ReadTransaction
    @TransactionID = 1