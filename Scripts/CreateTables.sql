CREATE TABLE
    City (
        code char(2) PRIMARY KEY NOT NULL,
        name nvarchar (50) NOT NULL
    )
CREATE TABLE
    ShipmentStatus (
        Id INT PRIMARY KEY IDENTITY (1, 1),
        StatusName VARCHAR(50) NOT NULL
    );

CREATE TABLE
    PaymentMethods (
        PaymentMethodId INT PRIMARY KEY IDENTITY (1, 1),
        MethodName VARCHAR(50) NOT NULL
    );

CREATE TABLE
    Addresses (
        AddressId INT PRIMARY KEY IDENTITY (1, 1),
        AddressLine VARCHAR(255) NOT NULL,
        CityId char(2) NOT NULL,
        PostalCode VARCHAR(10),
        CONSTRAINT FK_Addresses_City FOREIGN KEY (CityId) REFERENCES City (code) ON DELETE NO ACTION
    );

CREATE TABLE
    Users (
        UserId INT PRIMARY KEY IDENTITY (1, 1),
        Name VARCHAR(100) NOT NULL,
        Surname VARCHAR(100) NOT NULL,
        PhoneNumber VARCHAR(15) UNIQUE,
        Email VARCHAR(100) UNIQUE,
        CreatedAt DATETIME DEFAULT GETDATE (),
        AddressId INT NULL,
        CONSTRAINT FK_Users_Addresses FOREIGN KEY (AddressId) REFERENCES Addresses (AddressId) ON DELETE SET NULL
    );

CREATE TABLE
    Shipments (
        ShipmentId INT PRIMARY KEY IDENTITY (1, 1),
        SenderId INT NOT NULL,
        ReceiverId INT NOT NULL,
        Weight DECIMAL(5, 2) NOT NULL,
        Price DECIMAL(10, 2) NULL,
        CreatedAt DATETIME DEFAULT GETDATE (),
        Length DECIMAL(5, 2) NULL,
        Width DECIMAL(5, 2) NULL,
        Height DECIMAL(5, 2) NULL,
        DimensionalWeight DECIMAL(5, 2) NULL,
        CONSTRAINT FK_Shipments_Sender FOREIGN KEY (SenderId) REFERENCES Users (UserId) ON DELETE NO ACTION,
        CONSTRAINT FK_Shipments_Receiver FOREIGN KEY (ReceiverId) REFERENCES Users (UserId) ON DELETE NO ACTION
    );

CREATE TABLE
    ShipmentTracking (
        TrackingId INT PRIMARY KEY IDENTITY (1, 1),
        ShipmentId INT NOT NULL,
        Location VARCHAR(100) NOT NULL,
        StatusId INT NULL,
        Timestamp DATETIME DEFAULT GETDATE (),
        CONSTRAINT FK_Tracking_Shipments FOREIGN KEY (ShipmentId) REFERENCES Shipments (ShipmentId) ON DELETE CASCADE,
        CONSTRAINT FK_Tracking_Status FOREIGN KEY (StatusId) REFERENCES ShipmentStatus (Id) ON DELETE SET NULL
    );

CREATE TABLE
    Payments (
        PaymentId INT PRIMARY KEY IDENTITY (1, 1),
        ShipmentId INT NOT NULL,
        PaymentMethodId INT NOT NULL,
        PaymentDate DATETIME DEFAULT GETDATE (),
        CONSTRAINT FK_Payments_Shipments FOREIGN KEY (ShipmentId) REFERENCES Shipments (ShipmentId) ON DELETE CASCADE,
        CONSTRAINT FK_Payments_Method FOREIGN KEY (PaymentMethodId) REFERENCES PaymentMethods (PaymentMethodId) ON DELETE NO ACTION
    );

CREATE INDEX IX_Shipments_SenderId ON Shipments (SenderId);

CREATE INDEX IX_Shipments_ReceiverId ON Shipments (ReceiverId);

CREATE INDEX IX_ShipmentTracking_ShipmentId ON ShipmentTracking (ShipmentId);