-----------------------------------------------
-- Double movement on Ocean
-- Credit: Gedemon
-----------------------------------------------
UPDATE Terrains SET MovementCost = 2 WHERE TerrainType="TERRAIN_COAST"; 
UPDATE GlobalParameters SET Value = Value * 2 WHERE Name ='MOVEMENT_WHILE_EMBARKED_BASE';
UPDATE Units SET BaseMoves = BaseMoves * 2 WHERE Domain = 'DOMAIN_SEA';