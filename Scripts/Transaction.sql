BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @AddressId INT;
    DECLARE @ReceiverId INT;
    DECLARE @SenderId INT;
    DECLARE @ShipmentId INT;

    INSERT INTO Addresses (AddressLine, CityId, PostalCode)
        VALUES 
            ('Atatürk Mahallesi Cumhuriyet Caddesi 330.sokak no 13 daire 4 Çayırova', '41', 00041);

    SET @AddressId = SCOPE_IDENTITY();

    INSERT INTO Users (Name, Surname, PhoneNumber, Email, CreatedAt, AddressId)
        VALUES 
            ('ÖMER', 'Karaman', '+905060528330', 'drakken120@gmail.com', GETDATE(), @AddressId);

    SET @ReceiverId = SCOPE_IDENTITY();

    INSERT INTO Addresses (AddressLine, CityId, PostalCode)
        VALUES 
            ('Sanat Mahallesi Nazım Hikmet Caddesi 3 Haziran sokak no 60 daire 1', '06', 00006);

    SET @AddressId = SCOPE_IDENTITY();

    INSERT INTO Users (Name, Surname, PhoneNumber, Email, CreatedAt, AddressId)
        VALUES 
            ('Nazım', 'Hikmet', '+905060526060', 'nazimhikmetci@gmail.com', GETDATE(), @AddressId);

    SET @SenderId = SCOPE_IDENTITY();

    INSERT INTO Shipments (SenderId, ReceiverId, Weight, Length, Height, Width, CreatedAt)
        VALUES 
            (@SenderId, @ReceiverId, 160, 30.0, 30.0, 50.0, GETDATE());

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
