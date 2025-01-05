CREATE PROCEDURE UpdateShipmentTracking
(   @ShipmentId int,
    @Location char(2),
    @StatusId int
)
AS
BEGIN
    INSERT INTO ShipmentTracking(ShipmentId,Location,StatusId,Timestamp) VALUES(@ShipmentId,@Location,@StatusId,GETDATE());
END

CREATE PROCEDURE CargoInformation
(
    @ShipmentId int
)
AS
BEGIN
    SELECT st.TrackingId,st.Location,ss.StatusName,st.Timestamp FROM ShipmentTracking as st
    inner join ShipmentStatus ss
    on ss.Id = st.StatusId
    WHERE st.tra
END

