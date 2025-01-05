BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @AddressId INT;
    DECLARE @ReceiverId INT;
    DECLARE @SenderId INT;
    DECLARE @ShipmentId INT;

    INSERT INTO Addresses (AddressLine, CityId, PostalCode)
        VALUES 
            ('Kazım Karabekir Mahallesi 1923 sokak no 06 daire 3', '06', 00006);

    SET @AddressId = SCOPE_IDENTITY();

    INSERT INTO Users (Name, Surname, PhoneNumber, Email, CreatedAt, AddressId)
        VALUES 
            ('Ahmet Yasin', 'Durakcı', '+905366666638', 'crazyboy_38@gmail.com', GETDATE(), @AddressId);

    SET @ReceiverId = SCOPE_IDENTITY();

    INSERT INTO Addresses (AddressLine, CityId, PostalCode)
        VALUES 
            ('Yayla Mahallesi Erler sokak no 13 daire 4', '34', 00034);

    SET @AddressId = SCOPE_IDENTITY();

    INSERT INTO Users (Name, Surname, PhoneNumber, Email, CreatedAt, AddressId)
        VALUES 
            ('Ömer', 'Karaman', '+905555555155', 'omerkaraman1@windowslive.com', GETDATE(), @AddressId);

    SET @SenderId = SCOPE_IDENTITY();

    INSERT INTO Shipments (SenderId, ReceiverId, Weight, Length, Height, Width, CreatedAt)
        VALUES 
            (@SenderId, @ReceiverId, 200, 30.0, 60.0, 90.0, GETDATE());

    SET @ShipmentId = SCOPE_IDENTITY();

    INSERT INTO Payments (ShipmentId, PaymentMethodId, PaymentDate)
        VALUES 
            (@ShipmentId, 2, GETDATE());

    INSERT INTO ShipmentTracking (ShipmentId, Location, StatusId, Timestamp)
        VALUES 
            (@ShipmentId, 'Kocaeli', 1, GETDATE());

    COMMIT TRANSACTION;
    PRINT 'Transaction completed successfully.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed. All changes have been rolled back.';
END CATCH;
