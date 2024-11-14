EXEC  dbo.UpsertFeedback
@FeedbackID = NULL,
@BookingID = 2, 
    @Rating = 5, 
    @Comments = 'Great', 
    @FeedbackDate = '2024-11-13'

SELECT * FROM dbo.Feedbacks;

EXEC dbo.RemoveFeedbackDetails
@FeedbackID = 1

--Read Procedure Call


EXEC dbo.ReadFeedback
    @FeedbackID = ''


    SELECT * FROM  dbo.Feedbacks