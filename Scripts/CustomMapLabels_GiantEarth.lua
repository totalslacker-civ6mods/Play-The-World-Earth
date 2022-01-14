-- ===========================================================================
--	Custom Map Labels for Play The World (Giant Earth) 
--	author: totalslacker
-- ===========================================================================
------------------------------------------------------------------------------

local CLASS_MOUNTAIN = GameInfo.TerrainClasses["TERRAIN_CLASS_MOUNTAIN"].Index;
local CLASS_DESERT   = GameInfo.TerrainClasses["TERRAIN_CLASS_DESERT"].Index;
local CLASS_WATER    = GameInfo.TerrainClasses["TERRAIN_CLASS_WATER"].Index;
local bOceanLabel = false
local bDesertLabel = false
local bMountainLabel = false
local bLakeLabel = false
local bSeaLabel = false

-- ===========================================================================
-- Custom Map Label Regions for Giant Earth
-- ===========================================================================

function GetCustomMapLabel_PTW_GiantEarth(eTerritory, pTerritory, szName)
	local iPlotIndex;
	local iTerritory;
	local matchingID;
	local isWater = false;
	--Logic
	if (pTerritory:GetTerrainClass() == CLASS_WATER) and not (pTerritory:IsLake() or pTerritory:IsSea()) then
		bOceanLabel = true;
	end
	if (pTerritory:GetTerrainClass() == CLASS_DESERT) then
		bDesertLabel = true;
	end	
	if (pTerritory:GetTerrainClass() == CLASS_MOUNTAIN) then
		bMountainLabel = true;
	end	
	if (pTerritory:GetTerrainClass() == CLASS_WATER) and (pTerritory:IsLake()) then
		bLakeLabel = true;
	end
	if (pTerritory:GetTerrainClass() == CLASS_WATER) and (pTerritory:IsSea()) then
		bSeaLabel = true;
	end
	--Labels
	if bOceanLabel then
		--Antarctic
		-- iPlotIndex = Map.GetPlot(5,13):GetIndex();
		-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		-- matchingID = iTerritory:GetID();
		-- if eTerritory == matchingID then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_PACIFIC_OCEAN_NAME"));
			-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			-- return szName;
		-- end
		--Arctic
		iPlotIndex = Map.GetPlot(65,78):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Altantic
		iPlotIndex = Map.GetPlot(44,46):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_ATLANTIC_OCEAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		iPlotIndex = Map.GetPlot(52,8):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_ATLANTIC_OCEAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Indian Ocean
		iPlotIndex = Map.GetPlot(107,12):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_INDIAN_OCEAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Pacific Ocean
		iPlotIndex = Map.GetPlot(7,29):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_PACIFIC_OCEAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
	end
	if bSeaLabel then
		--Baffin Bay
		iPlotIndex = Map.GetPlot(36,78):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAFFIN_BAY_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Beaufort Sea
		iPlotIndex = Map.GetPlot(27,75):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BEAUFORT_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Bay of Bengal
		iPlotIndex = Map.GetPlot(113,37):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BENGAL_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Baltic Sea
		iPlotIndex = Map.GetPlot(76,64):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Banda Sea
		iPlotIndex = Map.GetPlot(128,22):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BANDA_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Bay of Biscay
		iPlotIndex = Map.GetPlot(59,52):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BISCAY_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Bering Sea
		iPlotIndex = Map.GetPlot(146,70):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BERING_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Black Sea
		iPlotIndex = Map.GetPlot(86,53):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BLACK_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Caribbean Sea
		iPlotIndex = Map.GetPlot(33,37):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CARIBBEAN_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Caspian Sea
		iPlotIndex = Map.GetPlot(94,53):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CASPIAN_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Coral Sea
		iPlotIndex = Map.GetPlot(120,26):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CORAL_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--East China Sea
		iPlotIndex = Map.GetPlot(131,48):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_EAST_CHINA_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--English Channel
		iPlotIndex = Map.GetPlot(61,58):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ENGLISH_CHANNEL_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Greenland Sea
		iPlotIndex = Map.GetPlot(55,75):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREENLAND_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Gulf of Cadiz
		iPlotIndex = Map.GetPlot(54,43):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CADIZ_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Gulf of California
		iPlotIndex = Map.GetPlot(15,44):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CALIFORNIA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Gulf of Guinea
		iPlotIndex = Map.GetPlot(68,20):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_GUINEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Gulf of Mexico
		iPlotIndex = Map.GetPlot(25,45):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_MEXICO_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Gulf of Panama
		iPlotIndex = Map.GetPlot(27,30):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_PANAMA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Gulf of Saint Lawrence
		iPlotIndex = Map.GetPlot(35,61):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_SAINT_LAWRENCE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Gulf of Thailand
		-- iPlotIndex = Map.GetPlot(101,37):GetIndex();
		-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		-- matchingID = iTerritory:GetID();
		-- if eTerritory == matchingID then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_THAILAND_NAME"));
			-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			-- return szName;
		-- end	
		--Hudson Bay
		iPlotIndex = Map.GetPlot(27,69):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_HUDSON_BAY_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Kara Sea
		iPlotIndex = Map.GetPlot(97,76):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_KARA_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Labrador Sea
		-- iPlotIndex = Map.GetPlot(43,67):GetIndex();
		-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		-- matchingID = iTerritory:GetID();
		-- if eTerritory == matchingID then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LABRADOR_SEA_NAME"));
			-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			-- return szName;
		-- end	
		--Laptev Sea
		-- iPlotIndex = Map.GetPlot(100,77):GetIndex();
		-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		-- matchingID = iTerritory:GetID();
		-- if eTerritory == matchingID then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LAPTEV_SEA_NAME"));
			-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			-- return szName;
		-- end
		--Mozambique Channel
		iPlotIndex = Map.GetPlot(86,11):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MOZAMBIQUE_CHANNEL_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Mediterranean Sea
		iPlotIndex = Map.GetPlot(66,46):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MEDITERRANEAN_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		iPlotIndex = Map.GetPlot(81,44):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MEDITERRANEAN_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--North Sea
		iPlotIndex = Map.GetPlot(64,66):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Norwegian Sea
		iPlotIndex = Map.GetPlot(79,82):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORWEGIAN_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Persian Gulf
		iPlotIndex = Map.GetPlot(98,39):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ARABIAN_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Phillipine Sea
		iPlotIndex = Map.GetPlot(138,30):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_PHILIPPINE_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Red Sea
		iPlotIndex = Map.GetPlot(87,30):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_RED_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Sargasso Sea
		iPlotIndex = Map.GetPlot(35,53):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SARGASSO_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Scotia Sea
		iPlotIndex = Map.GetPlot(38,2):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SCOTIA_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Sea of Japan
		iPlotIndex = Map.GetPlot(136,56):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_JAPAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Sea of Okhotsk
		iPlotIndex = Map.GetPlot(138,68):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_OKHOTSK_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--South China Sea
		iPlotIndex = Map.GetPlot(126,37):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SOUTH_CHINA_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Sulu Sea
		-- iPlotIndex = Map.GetPlot(113,36):GetIndex();
		-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		-- matchingID = iTerritory:GetID();
		-- if eTerritory == matchingID then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SULU_SEA_NAME"));
			-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			-- return szName;
		-- end
		--White Sea
		iPlotIndex = Map.GetPlot(85,74):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_WHITE_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
	end
	if bDesertLabel then
		--Arabian Desert
		iPlotIndex = Map.GetPlot(92,36):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_ARABIAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Atacama Desert
		iPlotIndex = Map.GetPlot(32,16):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_ATACAMA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Great Basin Desert
		iPlotIndex = Map.GetPlot(13,55):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GREAT_BASIN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Gobi Desert
		iPlotIndex = Map.GetPlot(119,56):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GOBI_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Kalahari Desert
		iPlotIndex = Map.GetPlot(76,9):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KALAHARI_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Karakum Desert
		iPlotIndex = Map.GetPlot(97,53):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KARAKUM_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Kyzylkum Desert
		iPlotIndex = Map.GetPlot(101,58):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KARAKUM_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Ogaden Desert
		iPlotIndex = Map.GetPlot(89,25):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_OGADEN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Patagonian Desert
		iPlotIndex = Map.GetPlot(36,6):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_PATAGONIAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Sahara Desert
		iPlotIndex = Map.GetPlot(71,35):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_SAHARA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Taklamakan Desert
		iPlotIndex = Map.GetPlot(109,52):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_TAKLAMAKAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Thar Desert
		iPlotIndex = Map.GetPlot(103,41):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_THAR_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end			
	end
	if bLakeLabel then
		--Aral Sea
		iPlotIndex = Map.GetPlot(97,56):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ARAL_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Dal Lake
		iPlotIndex = Map.GetPlot(107,48):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_DAL_LAKE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Hulun Lake
		iPlotIndex = Map.GetPlot(124,61):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_HULUN_LAKE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Khovsgol Lake
		iPlotIndex = Map.GetPlot(115,60):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_KHOVSGOL_LAKE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Great Bear Lake
		iPlotIndex = Map.GetPlot(15,72):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_GREAT_BEAR_LAKE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Great Slave Lake
		iPlotIndex = Map.GetPlot(16,69):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_GREAT_SLAVE_LAKE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Issyk Kul Lake
		iPlotIndex = Map.GetPlot(105,54):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ISSYK_KUL_LAKE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Alakol
		iPlotIndex = Map.GetPlot(107,56):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALAKOL_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Albert
		iPlotIndex = Map.GetPlot(82,24):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALBERT_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Athabasca
		iPlotIndex = Map.GetPlot(18,67):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ADAPASKAW_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Baikal
		iPlotIndex = Map.GetPlot(118,63):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_BAIKAL_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Lake Balkhash
		iPlotIndex = Map.GetPlot(104,57):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_BALKHASH_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Lake Champlain
		iPlotIndex = Map.GetPlot(32,59):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_CHAMPLAIN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Lake Erie
		iPlotIndex = Map.GetPlot(28,58):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ERIE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Lake Inari
		iPlotIndex = Map.GetPlot(79,78):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_INARI_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Lake Khanka
		iPlotIndex = Map.GetPlot(134,59):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KHANKA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Kivu
		iPlotIndex = Map.GetPlot(82,22):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KIVU_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Ladoga
		iPlotIndex = Map.GetPlot(82,69):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_LADOGA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Maracaibo
		iPlotIndex = Map.GetPlot(32,33):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LAKE_MARACAIBO_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Nicaragua
		iPlotIndex = Map.GetPlot(26,34):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_NICARAGUA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Nyasa
		iPlotIndex = Map.GetPlot(83,17):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_NYASA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake of the Woods
		-- iPlotIndex = Map.GetPlot(30,62):GetIndex();
		-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		-- matchingID = iTerritory:GetID();
		-- if eTerritory == matchingID then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_OF_THE_WOODS_NAME"));
			-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			-- return szName;
		-- end	
		--Lake Ontario
		iPlotIndex = Map.GetPlot(30,59):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ONTARIO_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Onega
		iPlotIndex = Map.GetPlot(84,70):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ONEGA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Lake Oulujarvi
		iPlotIndex = Map.GetPlot(81,72):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_OULUJARVI_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Lake Peipus
		iPlotIndex = Map.GetPlot(81,66):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_PEIPUS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Retba
		isWater = Map.GetPlot(55,31):IsWater()
		if isWater then
			iPlotIndex = Map.GetPlot(59,42):GetIndex();
			iTerritory = Territories.GetTerritoryAt(iPlotIndex);
			matchingID = iTerritory:GetID();
			if eTerritory == matchingID then
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_NIANGAY_NAME"));
				print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
				return szName;
			end			
		end
		--Lake Saimaa
		iPlotIndex = Map.GetPlot(81,70):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_SAIMAA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Lake Superior
		iPlotIndex = Map.GetPlot(26,60):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_SUPERIOR_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Tahoe
		isWater = Map.GetPlot(12,56):IsWater()
		if isWater then
			iPlotIndex = Map.GetPlot(12,56):GetIndex();
			iTerritory = Territories.GetTerritoryAt(iPlotIndex);
			matchingID = iTerritory:GetID();
			if eTerritory == matchingID then
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TAHOE_NAME"));
				print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
				return szName;
			end			
		end
		--Lake Tanganyika
		iPlotIndex = Map.GetPlot(81,20):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TANGANYIKA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Lake Taymyr
		iPlotIndex = Map.GetPlot(115,75):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TAYMYR_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Texcoco
		iPlotIndex = Map.GetPlot(19,42):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TEXCOCO_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Lake Turkana
		-- iPlotIndex = Map.GetPlot(75,37):GetIndex();
		-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		-- matchingID = iTerritory:GetID();
		-- if eTerritory == matchingID then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TURKANA_NAME"));
			-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			-- return szName;
		-- end	
		--Lake Urmia
		iPlotIndex = Map.GetPlot(92,48):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_URMIA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Van
		iPlotIndex = Map.GetPlot(90,48):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_VAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Victoria
		iPlotIndex = Map.GetPlot(84,22):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_VICTORIA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Vygozero
		iPlotIndex = Map.GetPlot(82,71):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_VYGOZERO_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Lake Winnipeg
		iPlotIndex = Map.GetPlot(22,63):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_WINNIPEG_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Lake Zaysan
		iPlotIndex = Map.GetPlot(109,58):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ZAYSAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Mjosa
		iPlotIndex = Map.GetPlot(72,73):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_MJOSA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Okavango Delta
		iPlotIndex = Map.GetPlot(77,11):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("NAMED_LAKE_OKAVANGO_DELTA"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Pangtong So
		iPlotIndex = Map.GetPlot(112,48):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_PANGONG_TSO_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Poyang Lake
		iPlotIndex = Map.GetPlot(126,44):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_POYANG_LAKE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Qinghai Lake
		iPlotIndex = Map.GetPlot(116,52):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_QINGHAI_LAKE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Reindeer Lake
		-- iPlotIndex = Map.GetPlot(26,64):GetIndex();
		-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		-- matchingID = iTerritory:GetID();
		-- if eTerritory == matchingID then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_REINDEER_LAKE_NAME"));
			-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			-- return szName;
		-- end	
		--Sea of Galilee
		isWater = Map.GetPlot(86,41):IsWater()
		if isWater then
			iPlotIndex = Map.GetPlot(77,50):GetIndex();
			iTerritory = Territories.GetTerritoryAt(iPlotIndex);
			matchingID = iTerritory:GetID();
			if eTerritory == matchingID then
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_SEA_OF_GALILEE_NAME"));
				print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
				return szName;
			end			
		end
		--Tonle Sap
		iPlotIndex = Map.GetPlot(120,33):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_TONLE_SAP_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Vannern
		iPlotIndex = Map.GetPlot(73,69):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_VANERN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Vattern
		iPlotIndex = Map.GetPlot(75,68):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_VATTERN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end			
		--West Nubian Lake (Lake Chad)
		iPlotIndex = Map.GetPlot(74,30):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_CHAD_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
	end
	if bMountainLabel then
		--Alaskan Range (using this name twice for two mountain ranges)
		iPlotIndex = Map.GetPlot(14,66):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALASKAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		iPlotIndex = Map.GetPlot(11,70):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALASKAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Alborz
		iPlotIndex = Map.GetPlot(96,48):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALBORZ_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Alps
		iPlotIndex = Map.GetPlot(70,54):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALPS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Altai
		iPlotIndex = Map.GetPlot(111,60):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALTAI_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Arctic Cordillera
		iPlotIndex = Map.GetPlot(37,77):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_CORDILLERA_CENTRAL_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Andes
		iPlotIndex = Map.GetPlot(34,15):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ANDES_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Atlas Mts
		iPlotIndex = Map.GetPlot(57,39):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ATLAS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		iPlotIndex = Map.GetPlot(61,39):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ATLAS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		iPlotIndex = Map.GetPlot(66,41):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ATLAS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Baffin Island
		iPlotIndex = Map.GetPlot(34,76):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ASIR_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Baikal Mts
		iPlotIndex = Map.GetPlot(123,65):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_BAIKAL_MOUNTAINS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Caucasus
		iPlotIndex = Map.GetPlot(89,55):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_CAUCASUS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Chersky
		iPlotIndex = Map.GetPlot(138,75):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_CHERSKY_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		iPlotIndex = Map.GetPlot(140,75):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_CHERSKY_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Coast Range
		iPlotIndex = Map.GetPlot(11,62):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_COAST_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		iPlotIndex = Map.GetPlot(10,67):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_COAST_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Crystal Mountains
		iPlotIndex = Map.GetPlot(71,24):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_CRYSTAL_MOUNTAINS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Drakensberg Mountains
		iPlotIndex = Map.GetPlot(80,5):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_DRAKENSBERG_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Great Dividing Rang
		iPlotIndex = Map.GetPlot(140,5):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_GREAT_DIVIDING_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Himalayas
		iPlotIndex = Map.GetPlot(109,45):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HIMALAYAS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Hindu Kush
		iPlotIndex = Map.GetPlot(102,48):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HINDU_KUSH_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Jotunheim
		iPlotIndex = Map.GetPlot(69,72):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_JOTUNHEIMEN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Karakorum
		iPlotIndex = Map.GetPlot(108,49):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("NAMED_MOUNTAIN_KARAKORAM"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Khangai
		iPlotIndex = Map.GetPlot(115,58):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KHANGAI_MOUNTAINS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Khentii
		iPlotIndex = Map.GetPlot(120,60):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KHENTII_MOUNTAINS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Khingan
		iPlotIndex = Map.GetPlot(122,53):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KHINGAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		iPlotIndex = Map.GetPlot(126,60):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KHINGAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Kunlun
		iPlotIndex = Map.GetPlot(110,51):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KUNLUN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Mackenzie Mts
		iPlotIndex = Map.GetPlot(17,68):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_MACKENZIE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
		--Pacairama Mts
		iPlotIndex = Map.GetPlot(35,29):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_PACARAIMA_MOUNTAINS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Qinlin Mts
		iPlotIndex = Map.GetPlot(118,49):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_QINLING_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Rocky Mts
		iPlotIndex = Map.GetPlot(17,51):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ROCKIES_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		iPlotIndex = Map.GetPlot(15,59):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ROCKIES_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		iPlotIndex = Map.GetPlot(14,63):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ROCKIES_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Sayan
		iPlotIndex = Map.GetPlot(114,61):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_SAYAN_MOUNTAINS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Scandes
		iPlotIndex = Map.GetPlot(73,75):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_SCANDES_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end
		--Stanovoy
		iPlotIndex = Map.GetPlot(129,66):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_STANOVOY_MOUNTAINS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--TienShan
		iPlotIndex = Map.GetPlot(105,53):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_TIEN_SHAN_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Verkhoyansk
		iPlotIndex = Map.GetPlot(126,70):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_VERKHOYANSK_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end	
		--Zagros
		iPlotIndex = Map.GetPlot(94,44):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ZAGROS_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
	end
	print("No matching territory label detected, returning original label")
	return szName;
end

-- ===========================================================================
-- ===========================================================================