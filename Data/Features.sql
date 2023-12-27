-- DELETE FROM Feature_ValidTerrains WHERE FeatureType="FEATURE_BURNING_FOREST" AND TerrainType="TERRAIN_TUNDRA"; 
-- DELETE FROM Feature_ValidTerrains WHERE FeatureType="FEATURE_BURNING_FOREST" AND TerrainType="TERRAIN_TUNDRA_HILLS"; 

-- UPDATE RandomEvent_Yields SET Turn="8" WHERE RandomEventType="RANDOM_EVENT_FOREST_FIRE" AND FeatureType="FEATURE_FOREST"; 
-- UPDATE RandomEvent_Yields SET Turn="8" WHERE RandomEventType="RANDOM_EVENT_JUNGLE_FIRE" AND FeatureType="FEATURE_JUNGLE"; 

--All fires have 25% chance to spread (default 50%)
UPDATE RandomEvent_Damages
SET Percentage = '25'
WHERE DamageType = 'SPREAD';

--All fires have 50% chance to increase yields (default 100%)
UPDATE RandomEvent_Yields
SET Percentage = '50'
WHERE FeatureType = 'FEATURE_BURNT_JUNGLE';

UPDATE RandomEvent_Yields
SET Percentage = '50'
WHERE FeatureType = 'FEATURE_JUNGLE';

UPDATE RandomEvent_Yields
SET Percentage = '50'
WHERE FeatureType = 'FEATURE_BURNT_FOREST';

UPDATE RandomEvent_Yields
SET Percentage = '50'
WHERE FeatureType = 'FEATURE_FOREST';
