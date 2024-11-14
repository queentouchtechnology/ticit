SELECT * FROM  dbo.Payments;

EXEC dbo.UpsertPayment
    @PaymentID = NULL,
    @BookingID = 3,
    @PaymentDate = '2024-11-13',
    @Amount = 150.50,
    @PaymentMethod = 'Credit Card',
    @PaymentStatus = 'PENDING'

    EXEC  dbo.RemovePaymentDetails
    @PaymentID = 2

    SELECT * FROM dbo.Bookings;


    --Read procedure call
    EXEC dbo.ReadPayment
    @PaymentID = 1

SELECT * FROM dbo.Payments;