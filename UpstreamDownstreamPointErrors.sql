--This query provides result sets for incorrect upstream (F_NODE) & downstream (T_NODE) manhole AssetIDs 
--A variation of this can be used in an update routine to batch update incorrect AssetIDs

--Incorrect T_NODE
SELECT  g.[ASSETID] as GravityPipeAssetID
	  ,(g.Shape.STEndPoint()).STX as PipeEndX
	  ,case isnull(m.Shape.STX,0) WHEN 0 THEN mxy.Shape.STX ELSE m.Shape.STX END as ManholeX
	  ,(g.Shape.STEndPoint()).STY as PipeEndY
	  ,case isnull(m.Shape.STY,0) WHEN 0 THEN mxy.Shape.STY ELSE m.Shape.STY END as ManholeY
      ,g.[T_NODE] as Current_T_Node
	  ,case isnull(mxy.ASSETID,'') WHEN '' THEN 'Spatial Mismatch' ELSE mxy.ASSETID END as Correct_T_Node

  FROM [dbo].[SampleLines] g
  left outer join [dbo].[SamplePoints] m on g.T_NODE = m.ASSETID
  left outer join [dbo].[SamplePoints] mxy on (g.Shape.STEndPoint()).STX = mxy.Shape.STX and (g.Shape.STEndPoint()).STY = mxy.Shape.STY
  where (mxy.ASSETID <> g.[T_NODE]) or mxy.AssetID is null

  --Incorrect F_NODE
SELECT  g.[ASSETID] as GravityPipeAssetID
	  --,g.Shape.STEndPoint().ToString() as PipeStartXasString
	  ,(g.Shape.STEndPoint()).STX as PipeStartX
	  ,case isnull(m.Shape.STX,0) WHEN 0 THEN mxy.Shape.STX ELSE m.Shape.STX END as ManholeX
	  ,(g.Shape.STEndPoint()).STY as PipeStartY
	  ,case isnull(m.Shape.STY,0) WHEN 0 THEN mxy.Shape.STY ELSE m.Shape.STY END as ManholeY
      ,g.[F_NODE] as Current_F_Node
	  ,case isnull(mxy.ASSETID,'') WHEN '' THEN 'Spatial Mismatch' ELSE mxy.ASSETID END as Correct_F_Node

  FROM [dbo].[SampleLines] g
  left outer join [dbo].[SamplePoints] m on g.F_NODE = m.ASSETID
  left outer join [dbo].[SamplePoints] mxy on (g.Shape.STStartPoint()).STX = mxy.Shape.STX and (g.Shape.STStartPoint()).STY = mxy.Shape.STY
  where (mxy.ASSETID <> g.[F_NODE]) or mxy.AssetID is null



