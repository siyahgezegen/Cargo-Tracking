CREATE PROCEDURE UpdateShipmentTracking
(   @ShipmentId int,
    @Location VARCHAR(100),
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
    SELECT st.ShipmentId,st.TrackingId,st.Location,ss.StatusName,st.Timestamp FROM ShipmentTracking as st
    inner join ShipmentStatus as ss
    on ss.Id = st.StatusId
    WHERE st.ShipmentId =@ShipmentId 
END