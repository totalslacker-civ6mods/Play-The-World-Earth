-- UPDATE Features SET RemoveTech="TECH_METAL_CASTING" WHERE FeatureType="FEATURE_JUNGLE";

-- Features
-- INSERT OR REPLACE INTO Feature_ValidTerrains (FeatureType, TerrainType) VALUES ('FEATURE_MARSH', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Feature_ValidTerrains (FeatureType, TerrainType) VALUES ('FEATURE_MARSH', 'TERRAIN_TUNDRA');
-- INSERT OR REPLACE INTO Feature_ValidTerrains (FeatureType, TerrainType) VALUES ('FEATURE_MARSH', 'TERRAIN_DESERT');
-- INSERT OR REPLACE INTO Feature_ValidTerrains (FeatureType, TerrainType) VALUES ('FEATURE_ICE', 'TERRAIN_SNOW');

-- Valid Terrains
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_ALUMINUM', 'TERRAIN_GRASS_HILLS');
INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_ALUMINUM', 'TERRAIN_PLAINS_HILLS');
INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_ALUMINUM', 'TERRAIN_TUNDRA_HILLS');
INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_ALUMINUM', 'TERRAIN_SNOW_HILLS');
INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_CATTLE', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_CATTLE', 'TERRAIN_TUNDRA');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_CATTLE', 'TERRAIN_TUNDRA_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_CATTLE', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_CATTLE', 'TERRAIN_DESERT_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_CATTLE', 'TERRAIN_GRASS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_CITRUS', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_CITRUS', 'TERRAIN_DESERT');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_COAL', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_COAL', 'TERRAIN_TUNDRA_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_COAL', 'TERRAIN_DESERT_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_COFFEE', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_COFFEE', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_COPPER', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_COTTON', 'TERRAIN_DESERT');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_DIAMONDS', 'TERRAIN_DESERT');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_HORSES', 'TERRAIN_DESERT');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_HORSES', 'TERRAIN_TUNDRA');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_HORSES', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_INCENSE', 'TERRAIN_DESERT_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_INCENSE', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_IRON', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_JADE', 'TERRAIN_TUNDRA_HILLS');
INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_JADE', 'TERRAIN_DESERT_HILLS');
INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_MARBLE', 'TERRAIN_DESERT_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_MERCURY', 'TERRAIN_GRASS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_MERCURY', 'TERRAIN_TUNDRA');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_MERCURY', 'TERRAIN_DESERT');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_MERCURY', 'TERRAIN_DESERT_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_NITER', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_OIL', 'TERRAIN_TUNDRA_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_OIL', 'TERRAIN_GRASS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_OIL', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_OIL', 'TERRAIN_OCEAN');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_OLIVES', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_OLIVES', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_SALT', 'TERRAIN_DESERT_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_SHEEP', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_SILVER', 'TERRAIN_GRASS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_SILVER', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_STONE', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_STONE', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_STONE', 'TERRAIN_DESERT');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_STONE', 'TERRAIN_DESERT_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_STONE', 'TERRAIN_TUNDRA_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_SUGAR', 'TERRAIN_PLAINS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_SUGAR', 'TERRAIN_GRASS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_TEA', 'TERRAIN_PLAINS_HILLS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_WHALES', 'TERRAIN_OCEAN');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_WHEAT', 'TERRAIN_GRASS');
-- INSERT OR REPLACE INTO Resource_ValidTerrains (ResourceType, TerrainType) VALUES ('RESOURCE_WHEAT', 'TERRAIN_PLAINS_HILLS');

-- Valid Features
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_CRABS', 'FEATURE_REEF');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_PEARLS', 'FEATURE_REEF');

INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) 
SELECT ('RESOURCE_PEARLS'), ('FEATURE_REEF')
WHERE EXISTS (SELECT * FROM Resources WHERE ResourceType = 'RESOURCE_PEARLS')
AND EXISTS (SELECT * FROM Features WHERE FeatureType = 'FEATURE_REEF');

-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_CATTLE', 'FEATURE_MARSH');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_DEER', 'FEATURE_MARSH');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_IVORY', 'FEATURE_MARSH');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_NITER', 'FEATURE_MARSH');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_TEA', 'FEATURE_MARSH');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_WHEAT', 'FEATURE_MARSH');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_SALT', 'FEATURE_MARSH');

-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_STONE', 'FEATURE_FLOODPLAINS');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_SALT', 'FEATURE_FLOODPLAINS');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_SALT', 'FEATURE_FLOODPLAINS');

INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) 
SELECT ('RESOURCE_MAIZE'), ('FEATURE_FLOODPLAINS')
WHERE EXISTS (SELECT * FROM Resources WHERE ResourceType = 'RESOURCE_MAIZE');

INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) 
SELECT ('RESOURCE_MAIZE'), ('FEATURE_FLOODPLAINS_PLAINS')
WHERE EXISTS (SELECT * FROM Resources WHERE ResourceType = 'RESOURCE_MAIZE')
AND EXISTS (SELECT * FROM Features WHERE FeatureType = 'FEATURE_FLOODPLAINS_PLAINS');

INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) 
SELECT ('RESOURCE_MAIZE'), ('FEATURE_FLOODPLAINS_GRASSLAND')
WHERE EXISTS (SELECT * FROM Resources WHERE ResourceType = 'RESOURCE_MAIZE')
AND EXISTS (SELECT * FROM Features WHERE FeatureType = 'FEATURE_FLOODPLAINS_GRASSLAND');

-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_STONE', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_SUGAR', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_CITRUS', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_COAL', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_COPPER', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_IRON', 'FEATURE_JUNGLE');
INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_JADE', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_NITER', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_ALUMINUM', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_INCENSE', 'FEATURE_JUNGLE');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_OIL', 'FEATURE_JUNGLE');

-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_ALUMINUM', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_CITRUS', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_COAL', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_COFFEE', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_COPPER', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_DIAMONDS', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_GYPSUM', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_IRON', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_JADE', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_NITER', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_OIL', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_OLIVES', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_SILVER', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_STONE', 'FEATURE_FOREST');
-- INSERT OR REPLACE INTO Resource_ValidFeatures (ResourceType, FeatureType) VALUES ('RESOURCE_TEA', 'FEATURE_FOREST');

--No river requirement unlocked in Worldbuilder
/* UPDATE Resources SET NoRiver='0' 
WHERE ResourceType ='RESOURCE_COPPER'
OR ResourceType ='RESOURCE_IRON'
OR ResourceType ='RESOURCE_ALUMINUM'
OR ResourceType ='RESOURCE_COAL'
OR ResourceType ='RESOURCE_MARBLE'
OR ResourceType ='RESOURCE_DEER'; */

--No river requirement unlocked for Reefs in Worldbuilder
/* UPDATE Features SET NoRiver='0'
WHERE FeatureType = 'FEATURE_REEF'; */