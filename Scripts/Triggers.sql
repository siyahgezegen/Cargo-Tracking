CREATE TRIGGER shipment_calculate_dim 
ON Shipments 
AFTER INSERT 
AS
BEGIN
    DECLARE @price INT;
    DECLARE @shipmentId INT;

    UPDATE Shipments
    SET
        DimensionalWeight = calc_dim,
        Price = calc_dim * 5
    FROM
        Shipments s
        INNER JOIN (
            SELECT
                ShipmentId,
                (Length * Width * Height) / 5000 AS calc_dim
            FROM
                inserted
        ) i ON s.ShipmentId = i.ShipmentId;

END;
