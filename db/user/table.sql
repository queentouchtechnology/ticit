drop table Users 
CREATE TABLE dbo.Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE,
    UserType VARCHAR(20) DEFAULT 'User' NOT NULL,
    CreateDate DATETIME DEFAULT GETDATE(),
    WalletBalance DECIMAL(10,2) DEFAULT 0,
    DiscountPercentage DECIMAL(5,2) DEFAULT 2 CHECK (DiscountPercentage BETWEEN 0 AND 100)
);



INSERT INTO Users (Username,PasswordHash,Email,Phone) VALUES ('RANJITH','RANJITH@22','nitranjith2019@gmail.com','6382824749');

SELECT * FROM Users;