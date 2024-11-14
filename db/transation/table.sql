CREATE TABLE dbo.Transactions (	
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    TransactionDate DATE DEFAULT GETDATE(),
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(50),
    Description VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES dbo.Users(UserID)
);


