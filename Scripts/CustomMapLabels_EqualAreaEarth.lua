-- ===========================================================================
--	Custom Map Labels for Play The World (Equal Area Earth) 
--	author: totalslacker
-- ===========================================================================

local bScotland		= MapConfiguration.GetValue("Scotland");

-- ===========================================================================
-- Custom Map Label Regions for Equal Area Earth
-- ===========================================================================

function GetCustomMapLabel_EqualAreaEarth(eTerritory, szName)
	local iPlotIndex;
	local iTerritory;
	local matchingID;
	--Oceans
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
	-- iPlotIndex = Map.GetPlot(3,76):GetIndex();
	-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	-- matchingID = iTerritory:GetID();
	-- if eTerritory == matchingID then
		-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_ARCTIC_OCEAN_NAME"));
		-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		-- return szName;
	-- end
	--Altantic
	iPlotIndex = Map.GetPlot(48,47):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_ATLANTIC_OCEAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Banda Sea
	iPlotIndex = Map.GetPlot(109,31):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BANDA_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Bay of Bengal
	iPlotIndex = Map.GetPlot(95,48):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BENGAL_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Bay of Biscay
	iPlotIndex = Map.GetPlot(61,68):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BISCAY_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Bering Sea
	iPlotIndex = Map.GetPlot(1,73):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BERING_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Black Sea
	iPlotIndex = Map.GetPlot(77,66):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BLACK_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Caribbean Sea
	iPlotIndex = Map.GetPlot(38,48):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CARIBBEAN_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Caspian Sea
	iPlotIndex = Map.GetPlot(82,65):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CASPIAN_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Coral Sea
	iPlotIndex = Map.GetPlot(119,26):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CORAL_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--East China Sea
	iPlotIndex = Map.GetPlot(108,59):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_EAST_CHINA_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Gulf of California
	iPlotIndex = Map.GetPlot(24,56):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CALIFORNIA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Gulf of Mexico
	iPlotIndex = Map.GetPlot(31,55):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_MEXICO_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Gulf of Saint Lawrence
	iPlotIndex = Map.GetPlot(42,70):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_SAINT_LAWRENCE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Hudson Bay
	iPlotIndex = Map.GetPlot(33,75):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_HUDSON_BAY_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Kara Sea
	iPlotIndex = Map.GetPlot(79,78):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_KARA_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Indian Ocean
	iPlotIndex = Map.GetPlot(90,19):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_INDIAN_OCEAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Laptev Sea
	iPlotIndex = Map.GetPlot(111,79):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LAPTEV_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Mozambique Channel
	iPlotIndex = Map.GetPlot(78,22):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MOZAMBIQUE_CHANNEL_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Mediterranean Sea
	iPlotIndex = Map.GetPlot(70,61):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MEDITERRANEAN_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Greenland Sea
	if bScotland then
		iPlotIndex = Map.GetPlot(59,75):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREENLAND_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
	end
	--North Sea
	iPlotIndex = Map.GetPlot(65,74):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Norwegian Sea
	if bScotland then
		iPlotIndex = Map.GetPlot(65,79):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORWEGIAN_SEA_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end		
	end	
	--Pacific Ocean
	iPlotIndex = Map.GetPlot(1,33):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_PACIFIC_OCEAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Persian Gulf
	iPlotIndex = Map.GetPlot(87,52):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ARABIAN_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Philippine Sea
	iPlotIndex = Map.GetPlot(113,40):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_PHILIPPINE_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	-- Sargasso Sea
	iPlotIndex = Map.GetPlot(37,59):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SARGASSO_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Scotia Sea
	iPlotIndex = Map.GetPlot(41,3):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SCOTIA_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Sea of Japan
	iPlotIndex = Map.GetPlot(112,65):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_JAPAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Sea of Okhotsk
	iPlotIndex = Map.GetPlot(116,73):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_OKHOTSK_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--South China Sea
	iPlotIndex = Map.GetPlot(105,44):GetIndex();
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
	
	--Deserts
	--Arabian Desert
	iPlotIndex = Map.GetPlot(82,52):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_ARABIAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Atacama Desert
	iPlotIndex = Map.GetPlot(38,19):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_ATACAMA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Chihuahuan Desert
	iPlotIndex = Map.GetPlot(24,58):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_CHIHUAHUAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Gibson Desert
	iPlotIndex = Map.GetPlot(107,19):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GIBSON_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Great Basin Desert
	iPlotIndex = Map.GetPlot(24,62):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GREAT_BASIN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Great Victoria Desert
	iPlotIndex = Map.GetPlot(111,15):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GREAT_VICTORIA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Gobi Desert
	iPlotIndex = Map.GetPlot(101,61):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GOBI_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Kalahari Desert
	iPlotIndex = Map.GetPlot(71,17):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KALAHARI_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Karakum Desert
	iPlotIndex = Map.GetPlot(87,68):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KARAKUM_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Namib Desert
	iPlotIndex = Map.GetPlot(69,24):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_NAMIB_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Ogaden Desert
	iPlotIndex = Map.GetPlot(81,42):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_OGADEN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Patagonian Desert
	iPlotIndex = Map.GetPlot(40,6):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_PATAGONIAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Registan Desert
	iPlotIndex = Map.GetPlot(85,57):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_REGISTAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Sahara Desert
	iPlotIndex = Map.GetPlot(68,52):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_SAHARA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Sechura Desert
	iPlotIndex = Map.GetPlot(36,28):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_SECHURA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Simpson Desert
	iPlotIndex = Map.GetPlot(113,19):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_SIMPSON_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Taklamakan Desert
	iPlotIndex = Map.GetPlot(94,64):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_TAKLAMAKAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Thar Desert
	iPlotIndex = Map.GetPlot(90,56):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_THAR_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	
	--Lakes
	--Aral Sea
	iPlotIndex = Map.GetPlot(85,67):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ARAL_SEA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Dal Lake
	iPlotIndex = Map.GetPlot(92,61):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_DAL_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Hulun Lake
	iPlotIndex = Map.GetPlot(106,70):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_HULUN_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Issyk Kul Lake
	iPlotIndex = Map.GetPlot(91,66):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ISSYK_KUL_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Khovsgol Lake
	iPlotIndex = Map.GetPlot(99,71):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_KHOVSGOL_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Alakol
	iPlotIndex = Map.GetPlot(94,71):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALAKOL_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Albert
	iPlotIndex = Map.GetPlot(75,39):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALBERT_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Great Bear Lake
	iPlotIndex = Map.GetPlot(21,77):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_GREAT_BEAR_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Great Slave Lake
	iPlotIndex = Map.GetPlot(22,75):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_GREAT_SLAVE_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Athabasca
	iPlotIndex = Map.GetPlot(26,74):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ADAPASKAW_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Baikal
	iPlotIndex = Map.GetPlot(102,72):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_BAIKAL_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Lake Balkhash
	iPlotIndex = Map.GetPlot(90,69):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_BALKHASH_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Lake Erie
	iPlotIndex = Map.GetPlot(35,66):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ERIE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Lake Khanka
	iPlotIndex = Map.GetPlot(111,68):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KHANKA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Kivu
	iPlotIndex = Map.GetPlot(74,36):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KIVU_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Ladoga
	iPlotIndex = Map.GetPlot(74,73):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_LADOGA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Maracaibo
	iPlotIndex = Map.GetPlot(38,44):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LAKE_MARACAIBO_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Retba
	isWater = Map.GetPlot(59,50):IsWater()
	if isWater then
		iPlotIndex = Map.GetPlot(59,50):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_NIANGAY_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end			
	end
	--Lake Nyasa
	iPlotIndex = Map.GetPlot(76,28):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_NYASA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake of the Woods
	iPlotIndex = Map.GetPlot(29,71):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_OF_THE_WOODS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Ontario
	iPlotIndex = Map.GetPlot(36,67):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ONTARIO_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Superior
	iPlotIndex = Map.GetPlot(32,69):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_SUPERIOR_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Tahoe
	isWater = Map.GetPlot(21,66):IsWater()
	if isWater then
		iPlotIndex = Map.GetPlot(21,66):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TAHOE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end			
	end
	--Lake Tanganyika
	iPlotIndex = Map.GetPlot(75,32):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TANGANYIKA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Lake Taymyr
	-- iPlotIndex = Map.GetPlot(102,73):GetIndex();
	-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	-- matchingID = iTerritory:GetID();
	-- if eTerritory == matchingID then
		-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TAYMYR_NAME"));
		-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		-- return szName;
	-- end	
	--Lake Texcoco
	iPlotIndex = Map.GetPlot(28,52):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TEXCOCO_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Titiqaqa
	iPlotIndex = Map.GetPlot(38,25):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TITIQAQA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end			
	--Lake Turkana
	iPlotIndex = Map.GetPlot(77,40):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TURKANA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Van
	iPlotIndex = Map.GetPlot(79,63):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_VAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Victoria
	iPlotIndex = Map.GetPlot(76,37):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_VICTORIA_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Lake Winnipeg
	iPlotIndex = Map.GetPlot(28,72):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_WINNIPEG_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Pangong Tso
	iPlotIndex = Map.GetPlot(95,59):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_PANGONG_TSO_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Poyang Lake
	iPlotIndex = Map.GetPlot(104,57):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_POYANG_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Qinghai Lake
	iPlotIndex = Map.GetPlot(99,62):GetIndex();
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
	isWater = Map.GetPlot(77,58):IsWater()
	if isWater then
		iPlotIndex = Map.GetPlot(77,58):GetIndex();
		iTerritory = Territories.GetTerritoryAt(iPlotIndex);
		matchingID = iTerritory:GetID();
		if eTerritory == matchingID then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_SEA_OF_GALILEE_NAME"));
			print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
			return szName;
		end			
	end
	--Utikuma Lake
	iPlotIndex = Map.GetPlot(24,73):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_UTIKUMA_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--West Nubian Lake (Lake Chad)
	iPlotIndex = Map.GetPlot(69,47):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_WEST_NUBIAN_LAKE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	

	--Mountains
	--Alaskan Range
	iPlotIndex = Map.GetPlot(12,75):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALASKAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	iPlotIndex = Map.GetPlot(12,78):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALASKAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Alps
	iPlotIndex = Map.GetPlot(68,68):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALPS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Altai
	iPlotIndex = Map.GetPlot(96,69):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALTAI_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Arctic Cordillera
	iPlotIndex = Map.GetPlot(39,78):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_CORDILLERA_CENTRAL_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Baikal Mts
	iPlotIndex = Map.GetPlot(103,74):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_BAIKAL_MOUNTAINS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Andes
	iPlotIndex = Map.GetPlot(40,23):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ANDES_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Atlas Mts
	iPlotIndex = Map.GetPlot(62,59):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ATLAS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Caucasus
	iPlotIndex = Map.GetPlot(80,66):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_CAUCASUS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Chersky
	iPlotIndex = Map.GetPlot(126,78):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_CHERSKY_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Coast Range
	iPlotIndex = Map.GetPlot(18,72):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_COAST_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Drakensberg
	iPlotIndex = Map.GetPlot(73,14):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_DRAKENSBERG_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end
	--Hijaz
	iPlotIndex = Map.GetPlot(80,50):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HIJAZ_MOUNTAINS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Hindu Kush
	iPlotIndex = Map.GetPlot(88,58):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HINDU_KUSH_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Himalayas
	iPlotIndex = Map.GetPlot(93,58):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HIMALAYAS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Khangai
	-- iPlotIndex = Map.GetPlot(100,72):GetIndex();
	-- iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	-- matchingID = iTerritory:GetID();
	-- if eTerritory == matchingID then
		-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KHANGAI_MOUNTAINS_NAME"));
		-- print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		-- return szName;
	-- end	
	--Khingan Range
	iPlotIndex = Map.GetPlot(107,70):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KHINGAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Kunlun
	iPlotIndex = Map.GetPlot(96,63):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KUNLUN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Mackenzie Mts
	iPlotIndex = Map.GetPlot(18,76):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_MACKENZIE_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end		
	--Owen Stanley
	iPlotIndex = Map.GetPlot(114,33):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_OWEN_STANLEY_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Pacairama Mts
	iPlotIndex = Map.GetPlot(41,40):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_PACARAIMA_MOUNTAINS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Qinlin Mts
	iPlotIndex = Map.GetPlot(102,60):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_QINLING_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Rocky Mts
	iPlotIndex = Map.GetPlot(22,70):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ROCKIES_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	iPlotIndex = Map.GetPlot(26,64):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ROCKIES_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Sayan Mountains
	iPlotIndex = Map.GetPlot(100,72):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_SAYAN_MOUNTAINS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Sierra Madre
	iPlotIndex = Map.GetPlot(26,56):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_SIERRA_MADRES_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Snowy Mountains
	iPlotIndex = Map.GetPlot(117,12):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_SNOWY_MOUNTAINS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Stanovoy
	iPlotIndex = Map.GetPlot(110,72):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_STANOVOY_MOUNTAINS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--TienShan
	iPlotIndex = Map.GetPlot(92,66):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_TIEN_SHAN_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Verkhoyansk
	iPlotIndex = Map.GetPlot(110,75):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_VERKHOYANSK_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	--Zagros
	iPlotIndex = Map.GetPlot(82,59):GetIndex();
	iTerritory = Territories.GetTerritoryAt(iPlotIndex);
	matchingID = iTerritory:GetID();
	if eTerritory == matchingID then
		szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ZAGROS_NAME"));
		print("Changing territory "..tostring(eTerritory).." to "..tostring(szName));
		return szName;
	end	
	
	return szName;
end

-- ===========================================================================
-- ===========================================================================