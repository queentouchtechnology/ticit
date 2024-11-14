CREATE OR ALTER PROCEDURE dbo.UpsertFeedback
@FeedbackID INT,
@BookingID INT,
@Rating INT,
@Comments TEXT,
@FeedbackDate DATETIME

AS
DECLARE @test VARCHAR(200)
BEGIN
EXEC dbo.ValidateFeedbackInputs  @BookingID,@Rating,@Comments,@FeedbackDate,@test OUTPUT
IF @test = 'OK'
BEGIN
IF @FeedbackID IS NULL
   BEGIN
   INSERT INTO dbo.Feedbacks (BookingID,Rating,Comments,FeedbackDate)
   VALUES (@BookingID,@Rating,@Comments,@FeedbackDate)
   SELECT 'OK' as Response,'ADDED' as ResponseMessage
      END
ELSE
BEGIN
UPDATE dbo.Feedbacks
SET 
Rating = @Rating,
Comments = @Comments,
FeedbackDate = @FeedbackDate
WHERE FeedbackID  = @FeedbackID AND BookingID = @BookingID
SELECT 'OK' as Response,'UPDATED' as ResponseMessage
END
END
ELSE
    BEGIN
        SELECT 'Error' as Response,@test as ResponseMessage
    END
END
