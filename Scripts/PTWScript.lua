-- ===========================================================================
--	Map Configuration Options Script for Play The World
--	author: totalslacker
-- ===========================================================================
include "MapUtilities"

print("Loading Play The World starting script")
-- ===========================================================================
-- Globals
-- ===========================================================================

local iTurn 				= Game.GetCurrentGameTurn()
local mapName 				= MapConfiguration.GetValue("MapName")
local bConvertMaize			= MapConfiguration.GetValue("ConvertMaize")
local bLeyLines				= MapConfiguration.GetValue("LeyLines")

print("Map Name: "..tostring(mapName))
print("New Frontier Resources: "..tostring(bConvertMaize))
print("Ley Lines: "..tostring(bLeyLines))

-- ===========================================================================
-- Map Configuration Functions
-- ===========================================================================

function ConvertMaize()
	if bConvertMaize then
		print("Attempting to add Maize resources to the Americas")
		local bMaize = false
		if GameInfo.Resources['RESOURCE_MAIZE'].Index ~= nil then bMaize = true end
		if not bMaize then 
			print("Maize resource not detected, ending function")
			return 
		end
		print("Maize resource detected")
		local tContinents = Map.GetContinentsInUse()
		for i,iContinent in ipairs(tContinents) do
			local bNorthAmerica = false
			local bSouthAmerica = false
			local bAmericas		= false
			if GameInfo.Continents[iContinent].ContinentType == "CONTINENT_NORTH_AMERICA" then bNorthAmerica = true end
			if GameInfo.Continents[iContinent].ContinentType == "CONTINENT_SOUTH_AMERICA" then bSouthAmerica = true end
			if GameInfo.Continents[iContinent].ContinentType == "CONTINENT_AMERICA" then bAmericas = true end
			if bNorthAmerica or bSouthAmerica or bAmericas then
				print("Converting Wheat bonus resources in the Americas to Maize")
				local continentPlots = Map.GetContinentPlots(iContinent)
				for i, iPlotIndex in ipairs(continentPlots) do
					-- print("Checking continent plot for resource...")
					local pPlot = Map.GetPlotByIndex(iPlotIndex)
					if pPlot:GetResourceType() ~= nil then
						if pPlot:GetResourceType() == GameInfo.Resources['RESOURCE_WHEAT'].Index then
							ResourceBuilder.SetResourceType(pPlot, -1)
							ResourceBuilder.SetResourceType(pPlot, GameInfo.Resources['RESOURCE_MAIZE'].Index, 1)
							print("Wheat bonus resource has been converted to Maize")
						end
					end
				end
			end
		end
		return true
	end
	return false
end

function AddLeyLines()
	if bLeyLines then
		print("Attempting to add Ley Lines to the map")
		local bSecretSocieties = false
		if GameInfo.Resources['RESOURCE_LEY_LINE'].Index ~= nil then bSecretSocieties = true end
		if not bSecretSocieties then 
			print("Ley Lines resource not detected, ending function")
			return 
		end
		print("Ley Lines resource detected")
		local bLeyLinesPerContinent = false
		if bLeyLinesPerContinent then
			local tContinents = Map.GetContinentsInUse()
			for i,iContinent in ipairs(tContinents) do
				if iContinent then
					print("Placing Ley Lines on a new continent")
					local continentPlots = Map.GetContinentPlots(iContinent)
					for i, iPlotIndex in ipairs(continentPlots) do
						-- print("Checking continent plot for resource...")
						local pPlot = Map.GetPlotByIndex(iPlotIndex)
						local bResourcePresent = pPlot:GetResourceType()
						local bFeaturePresent  = pPlot:GetFeatureType()
						-- print("Resource Present: "..tostring(bResourcePresent))
						-- print("Feature Present: "..tostring(bFeaturePresent))
						if bResourcePresent == -1 and bFeaturePresent == -1 then
							local iResourceCount = ResourceBuilder.GetAdjacentResourceCount(pPlot)
							-- print("Adjacent resource count: "..tostring(iResourceCount))
							if iResourceCount == 0 then
								print("Found suitable plot for Ley Line")
								ResourceBuilder.SetResourceType(pPlot, GameInfo.Resources['RESOURCE_LEY_LINE'].Index, 1)
								print("Ley line has been placed successfully")
							end
						end
					end
				end
			end
		end
		local bLeyLinesPerCapital = true
		if bLeyLinesPerCapital then
			for iPlayer = 0, PlayerManager.GetWasEverAliveCount() - 1 do
				local pPlayer = Players[iPlayer]
				local startingPlot = pPlayer:GetStartingPlot()
				if startingPlot and pPlayer:IsMajor() then
					ResourceBuilder.SetResourceType(startingPlot, -1) -- remove previous resource if any
					ResourceBuilder.SetResourceType(startingPlot, GameInfo.Resources['RESOURCE_LEY_LINE'].Index, 1)
				end
			end				
		end
		return true
	end
	return false
end

-- ===========================================================================
-- Main Function
-- ===========================================================================

function TSLEE_MapConfig(iPlayer)
	local player = Players[iPlayer]
	local mapConfigComplete = Game:GetProperty(iPlayer .. "_PTW_MapConfig")
	if player:IsHuman() and not mapConfigComplete then 
		print("-----------------------------------------------------------------------")
		print("Executing Play The World map configuration options via lua script")
		Game:SetProperty(iPlayer .. "_PTW_MapConfig", 1)
		if bLeyLines then
			print(" - Checking for Secret Societies options...")
			AddLeyLines()
		end
		if bConvertMaize then
			print(" - Checking for New Frontier options...")
			ConvertMaize()
		end
		print("-----------------------------------------------------------------------")
	end
end

-- ===========================================================================
-- Initialization
-- ===========================================================================

function Initialize()
	if (mapName == "Earth128x80") or (mapName == "EqualAreaEarth") then
		GameEvents.PlayerTurnStarted.Add( TSLEE_MapConfig )
	end
end

Initialize()

-- ===========================================================================
-- End
-- ===========================================================================