EXEC dbo.UpsertRoute
@RouteID  = NULL,
@StartLocation ='Chennai',
@EndLocation = 'Coimbatore' ,
@Distance = 147,
@EstimatedTime = '10hrs'

EXEC dbo.UpsertRoute
@RouteID  = 3,
@StartLocation ='Chennai',
@EndLocation = 'Coimbatore' ,
@Distance = 147,
@EstimatedTime = '20hrs'

EXEC dbo.RemoveRouteDetails
@RouteID  = 2


SELECT * FROM  dbo.Routes;

--Read Procedure  Call
EXEC  dbo.ReadRoute
@RouteID = 1


SELECT * FROM  dbo.Routes;