-----------------------------------------------
-- Create Tables
-----------------------------------------------

CREATE TABLE IF NOT EXISTS PTW_Resources_GiantEarth
	 (	ResourceType TEXT NOT NULL,
		ResourceClass TEXT NOT NULL,
		ResourceRegion TEXT NOT NULL );
		
CREATE TABLE IF NOT EXISTS PTW_Regions_GiantEarth
	 (	RegionName TEXT NOT NULL,
		Continent TEXT NOT NULL,
		StartX INTEGER NOT NULL,
		StartY INTEGER NOT NULL,
		EndX INTEGER NOT NULL,
		EndY INTEGER NOT NULL		);