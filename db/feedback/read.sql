CREATE OR ALTER PROCEDURE dbo.ReadFeedback
    @FeedbackID  INT
AS
BEGIN
   
    IF @FeedbackID  IS NULL OR NOT EXISTS (SELECT 1 FROM dbo.Feedbacks WHERE FeedbackID   = @FeedbackID  )
    BEGIN
      
        SELECT 'Invalid FeedbackID ' AS Response;
    END
    ELSE
    BEGIN
        SELECT 
         'OK' AS Response,
            FeedbackID ,
           BookingID,
          Rating  ,
           Comments ,
           FeedbackDate
        FROM 
          dbo.Feedbacks
        WHERE 
            FeedbackID  = @FeedbackID ;
    END
END;
