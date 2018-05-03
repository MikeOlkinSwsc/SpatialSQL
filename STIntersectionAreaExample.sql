 DECLARE @g geometry = 'CURVEPOLYGON (CIRCULARSTRING (0 -4, 4 0, 0 4, -4 0, 0 -4))';  
 DECLARE @h geometry = 'POLYGON ((1 -1, 5 -1, 5 3, 1 3, 1 -1))';  
 SELECT format( @h.STIntersection(@g).STArea() / @h.STArea(), 'P1') as IntersectArea
		,@h.STIntersection(@g) as Shape
		,@g as Circle
		,@h as Polygon

