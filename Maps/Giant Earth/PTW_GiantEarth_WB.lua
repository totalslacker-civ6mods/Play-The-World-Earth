-- PTW_GiantEarth_WB.lua 
-- author: totalslacker

include "MapEnums"
include "MapUtilities"
include "MountainsCliffs"
include "RiversLakes"
include "FeatureGenerator"
include "TerrainGenerator"
include "NaturalWonderGenerator"
include "ResourceGenerator"
include "AssignStartingPlots"
include "FeatureGenerator_Earth128x80"
include "ResourceGenerator_PTW_GiantEarth.lua"

-- ===========================================================================

local mapName 				= MapConfiguration.GetValue("MapName")
local bExpansion2 			= GameConfiguration.GetValue("RULESET") == "RULESET_EXPANSION_2";
local naturalWonders 		= {};
local excludedWonders 		= {};
local excludeWondersConfig 	= GameConfiguration.GetValue("EXCLUDE_NATURAL_WONDERS");
local resourcePlacement		= MapConfiguration.GetValue("PTW_Resources")
local bGenerateIce			= MapConfiguration.GetValue("GenerateIce")

-- ===========================================================================

function PTW_GiantEarth_GenerateIce()
	if bExpansion2 then
		print("Generating sea ice on map")
		local featuregen = FeatureGenerator_Earth128x80.Create();
		featuregen:AddIceToEarthMap("PTW_GiantEarth");
		print("Sea ice added successfully");
	end	
end

function PTW_GiantEarth_DeleteResources()
	local iW, iH = Map.GetGridSize();
	for x = 0, iW - 1, 1 do
		for y = 0, iH - 1, 1 do
			local pPlot = Map.GetPlot(x,y);
			if pPlot and (pPlot:GetResourceType() ~= -1) then
				ResourceBuilder.SetResourceType(pPlot, -1);
			end
		end
	end
end

function PTW_GiantEarth_ResourceGen()
	resourcesConfig = MapConfiguration.GetValue("resources");
	local startConfig = MapConfiguration.GetValue("start");-- Get the start config
	local args = {
		resources = resourcesConfig,
		START_CONFIG = startConfig,
	};
	local resGen = ResourceGenerator.Create(args);
end

function ImportNaturalWonders()
	if(excludeWondersConfig and #excludeWondersConfig > 0) then
		print("The following Natural Wonders have been marked as 'excluded':");
		for i,v in ipairs(excludeWondersConfig) do
			print("* " .. v);
			excludedWonders[v] = true;
		end
	end
	for loop in GameInfo.Features() do
		if(loop.NaturalWonder and excludedWonders[loop.FeatureType] ~= true) then
			print("Found natural wonder to spawn "..tostring(loop.FeatureType))
			naturalWonders[loop.FeatureType] = true;
		end
	end
	if #naturalWonders > 0 then
		return true
	else
		return false
	end
end

function PlaceNaturalWonders()
	for loop in GameInfo.MapStartPositions() do
		if(loop.Map == "PTW_GiantEarth" and naturalWonders[loop.Value]) then
			print("Spawning natural wonder "..tostring(loop.Value))
			local pPlot = Map.GetPlotByIndex(loop.Plot);
			local eFeatureType = GameInfo.Features[loop.Value].Index;
			if GameInfo.Features[loop.Value].Tiles > 1 then
				print("Multi plot natural wonder detected");
				local wonderPlots = {}
				if loop.Value == "FEATURE_BARRIER_REEF" then
					local pNWPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pNWPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_BERMUDA_TRIANGLE" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_CHOCOLATEHILLS" then
					local pPlot2 = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					local pNEPlot2 = Map.GetAdjacentPlot(pPlot2:GetX(), pPlot2:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pPlot2:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot2:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_CLIFFS_DOVER" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_DEAD_SEA" then
					local pNEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_EVEREST" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_EYJAFJALLAJOKULL" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_EYE_OF_THE_SAHARA" then
					local pWPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_WEST);
					local pSWPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_SOUTHWEST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pWPlot:GetIndex());
					table.insert(wonderPlots, pSWPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_GALAPAGOS" then
					local pNEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_GIANTS_CAUSEWAY" then
					local pSEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_SOUTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pSEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_GOBUSTAN" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_HA_LONG_BAY" then
					local pNEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_LAKE_RETBA" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_LYSEFJORDEN" then
					local pWPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_WEST);
					local pSWPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_SOUTHWEST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pWPlot:GetIndex());
					table.insert(wonderPlots, pSWPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_PAITITI" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_PAMUKKALE" then
					local pSEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_SOUTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pSEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_PANTANAL" then
					local pPlot2 = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					local pNEPlot2 = Map.GetAdjacentPlot(pPlot2:GetX(), pPlot2:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pPlot2:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot2:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_PIOPIOTAHI" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_RORAIMA" then
					local pPlot2 = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
					local pNEPlot = Map.GetAdjacentPlot(pPlot2:GetX(), pPlot2:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					local pNWPlot = Map.GetAdjacentPlot(pPlot2:GetX(), pPlot2:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pPlot2:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					table.insert(wonderPlots, pNWPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_SUK_GRANDCANYON" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pSEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_SOUTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					table.insert(wonderPlots, pSEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_SUK_NGORONGORO_CRATER" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_SUK_TONLESAP" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_TORRES_DEL_PAINE" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_UBSUNUR_HOLLOW" then
					local pPlot2 = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
					local pNEPlot = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					local pNEPlot2 = Map.GetAdjacentPlot(pPlot2:GetX(), pPlot2:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pPlot2:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot2:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_WHITEDESERT" then
					local pPlot2 = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pNEPlot = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					local pNEPlot2 = Map.GetAdjacentPlot(pPlot2:GetX(), pPlot2:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pPlot2:GetIndex());
					table.insert(wonderPlots, pNEPlot:GetIndex());
					table.insert(wonderPlots, pNEPlot2:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_YOSEMITE" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
				if loop.Value == "FEATURE_ZHANGYE_DANXIA" then
					local pEPlot  = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					local pEPlot2  = Map.GetAdjacentPlot(pEPlot:GetX(), pEPlot:GetY(), DirectionTypes.DIRECTION_EAST);
					table.insert(wonderPlots, pPlot:GetIndex());
					table.insert(wonderPlots, pEPlot:GetIndex());
					table.insert(wonderPlots, pEPlot2:GetIndex());
					TerrainBuilder.SetMultiPlotFeatureType(wonderPlots, eFeatureType);					
				end
			else
				TerrainBuilder.SetFeatureType(pPlot, eFeatureType);			
			end
		end
	end
end

function PTW_GiantEarth_UpdateStartPositions()
	for loop in GameInfo.MapStartPositions() do
		if((loop.Map == "PTW_GiantEarth") and (loop.Type == "CIVILIZATION")) then
			if (loop.Value == "CIVILIZATION_SUMERIA") and MapConfiguration.GetValue("SumeriaTSL") then
				for iPlayer = 0, PlayerManager.GetWasEverAliveCount() - 1 do
					local player = Players[iPlayer]
					local CivilizationTypeName 	= PlayerConfigurations[iPlayer]:GetCivilizationTypeName() 
					if CivilizationTypeName == loop.Value then
						print("Changing start position for "..tostring(loop.Value));
						local pPlot = Map.GetPlotByIndex(loop.Plot);
						player:SetStartingPlot(pPlot);
					end
				end
			end
		end
	end
end

-- ===========================================================================
function InitializeNewGame_PTW_GiantEarth()
	if (mapName == "PTW_GiantEarth") then
		local nw = true
		if nw then
			ImportNaturalWonders();
			PlaceNaturalWonders();
			AreaBuilder.Recalculate();
			TerrainBuilder.AnalyzeChokepoints(); 
			-- TerrainBuilder.StampContinents(); --Don't use this it will break continents on WB map
		end
		-- PTW_GiantEarth_UpdateStartPositions(); --Unused
		if (resourcePlacement == "PTW_RESOURCES_RANDOM") then
			PTW_GiantEarth_DeleteResources();
			PTW_GiantEarth_ResourceGen();
		elseif (resourcePlacement == "PTW_RESOURCES_COMBINED") then
			PTW_GiantEarth_ResourceGen();
		end
		if bGenerateIce then
			PTW_GiantEarth_GenerateIce();
		end
		--Goody Huts
		local gridWidth, gridHeight = Map.GetGridSize();
		AddGoodies(gridWidth, gridHeight);		
	end
end

LuaEvents.NewGameInitialized.Add(InitializeNewGame_PTW_GiantEarth);
