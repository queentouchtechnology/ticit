Create OR ALTER PROCEDURE dbo.RemoveFeedbackDetails
@FeedbackID INT
AS
BEGIN

    IF EXISTS (SELECT 1 FROM dbo.Feedbacks WHERE FeedbackID = @FeedbackID)
    BEGIN

        DELETE FROM dbo.Feedbacks WHERE  FeedbackID = @FeedbackID
        
  
        SELECT 'OK' AS Response, 'DELETED' AS ResponseMessage
    END
    ELSE
    BEGIN
      
        SELECT 'Error' AS Response, 'FeedbackID not found' AS ResponseMessage
    END
END