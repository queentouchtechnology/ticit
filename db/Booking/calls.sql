
EXEC  dbo.UpsertBooking
@BookingID = 1,
@UserID = 5,                   
    @ScheduleID = 5,                
    @BookingDate = '2024-12-01',     
    @TotalAmount = 150.00,           
    @BookingStatus = 'Confirmed'


SELECT * FROM dbo.Bookings;



EXEC dbo.RemoveBookingDetails
@BookingID = 1


--Read Call procedure 
EXEC dbo.ReadBooking
    @BookingID = 2
    
SELECT * FROM dbo.Bookings;

