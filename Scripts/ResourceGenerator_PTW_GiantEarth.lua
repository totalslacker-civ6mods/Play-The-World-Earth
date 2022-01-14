------------------------------------------------------------------------------
--	ResourceGenerator_PTW_GiantEarth.lua
--	Resource script by Firaxis. Adapted for Play The World mod by totalslacker
--	Resource placement configured for the Giant Earth map in Play the World
------------------------------------------------------------------------------

include "MapEnums"
include "MapUtilities"

------------------------------------------------------------------------------
-- Debugging
local bShowFullLogs :boolean = true;
local bShowIndividualLogs :boolean = true;
------------------------------------------------------------------------------

-- Init resources
function GetAvailableResources()
	if bShowFullLogs then print("Initializing GetAvailableResources function"); end
	local availableResources :table = {};
	for loop in GameInfo.Resources() do	
		if (loop.ResourceClassType ~= "RESOURCECLASS_ARTIFACT") then
			if bShowFullLogs then print("Found available resource "..tostring(loop.ResourceType)); end
			availableResources[loop.ResourceType] = true;
		end
	end	
	return availableResources;
end

-- Resource Region Functions
function GetResources_REGION_FromTable(region :string, resourceClass :string)
	if bShowFullLogs then print("Initializing GetResources_REGION_FromTable function"); end
	if bShowFullLogs and bShowIndividualLogs then print("Searching for region: "..tostring(region)); end
	if bShowFullLogs and bShowIndividualLogs then print("Searching for resource class: "..tostring(resourceClass)); end
	local resources :table = {};
	for loop in GameInfo.PTW_Resources_GiantEarth() do
		if ((loop.ResourceRegion == region) and (loop.ResourceClass == resourceClass)) then
			if bShowFullLogs then print("Found matching region: "..tostring(loop.ResourceRegion)); end
			if availableResources[loop.ResourceType] then
				table.insert(resources, GameInfo.Resources[loop.ResourceType].Index);
				if bShowFullLogs and bShowIndividualLogs then print(tostring(loop.ResourceType).." added to "..tostring(loop.ResourceRegion).." "..tostring(resourceClass).." resources"); end
			end
		end
	end
	if (#resources > 0) then
		return resources;
	else
		return false;
	end
end

function GetResources_REGION(region :string, resourceClass :string)
	local resources :table = {};
	if region == "Alaska" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to Alaska luxury resources");
		end
		if availableResources["RESOURCE_SILVER"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SILVER'].Index);
			print("RESOURCE_SILVER added to Alaska luxury resources");
		end
	elseif(region == "Alaska" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to Alaska strategic resources");
		end
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to Alaska strategic resources");
		end
		if availableResources["RESOURCE_OIL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_OIL'].Index);
			print("RESOURCE_OIL added to Alaska strategic resources");
		end
		if availableResources["RESOURCE_OIL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_OIL'].Index);
			print("RESOURCE_OIL added to Alaska strategic resources");
		end
	end
	if region == "AmericanSouth" and resourceClass == "luxury" then
		if availableResources["RESOURCE_COTTON"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COTTON'].Index);
			print("RESOURCE_COTTON added to AmericanSouth luxury resources");
		end
		if availableResources["RESOURCE_DYES"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_DYES'].Index);
			print("RESOURCE_DYES added to AmericanSouth luxury resources");
		end
		if availableResources["RESOURCE_SUGAR"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SUGAR'].Index);
			print("RESOURCE_SUGAR added to AmericanSouth luxury resources");
		end
		if availableResources["RESOURCE_TOBACCO"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_TOBACCO'].Index);
			print("RESOURCE_TOBACCO added to AmericanSouth luxury resources");
		end	
	elseif(region == "AmericanSouth" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to AmericanSouth strategic resources");
		end	
		if availableResources["RESOURCE_NITER"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_NITER'].Index);
			print("RESOURCE_NITER added to AmericanSouth strategic resources");
		end		
	end
	if region == "Arizona" and resourceClass == "luxury" then
		if availableResources["RESOURCE_COTTON"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COTTON'].Index);
			print("RESOURCE_COTTON added to Arizona luxury resources");
		end
		if availableResources["RESOURCE_DYES"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_DYES'].Index);
			print("RESOURCE_DYES added to Arizona luxury resources");
		end
		if availableResources["RESOURCE_SALT"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SALT'].Index);
			print("RESOURCE_SALT added to Arizona luxury resources");
		end	
		if availableResources["RESOURCE_TOBACCO"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_TOBACCO'].Index);
			print("RESOURCE_TOBACCO added to Arizona luxury resources");
		end		
	elseif(region == "Arizona" and resourceClass == "strategic") then
		if availableResources["RESOURCE_URANIUM"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_URANIUM'].Index);
			print("RESOURCE_URANIUM added to AmericanSouth strategic resources");
		end		
	end
	if region == "BritishColumbia" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to BritishColumbia luxury resources");
		end
		if availableResources["RESOURCE_SILVER"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SILVER'].Index);
			print("RESOURCE_SILVER added to BritishColumbia luxury resources");
		end
	elseif(region == "BritishColumbia" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to BritishColumbia strategic resources");
		end
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to BritishColumbia strategic resources");
		end
	end
	if region == "California" and resourceClass == "luxury" then
		if availableResources["RESOURCE_MERCURY"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_MERCURY'].Index);
			print("RESOURCE_MERCURY added to California luxury resources");
		end	
	elseif(region == "California" and resourceClass == "strategic") then
		if availableResources["RESOURCE_OIL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_OIL'].Index);
			print("RESOURCE_OIL added to California strategic resources");
		end		
	end
	if region == "GreatBasin" and resourceClass == "luxury" then
		if availableResources["RESOURCE_SILVER"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SILVER'].Index);
			print("RESOURCE_SILVER added to GreatBasin luxury resources");
		end	
	elseif(region == "GreatBasin" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to GreatBasin strategic resources");
		end	
		if availableResources["RESOURCE_URANIUM"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_URANIUM'].Index);
			print("RESOURCE_URANIUM added to GreatBasin strategic resources");
		end			
	end
	if region == "GreatLakes" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to GreatLakes luxury resources");
		end	
	elseif(region == "GreatLakes" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to GreatLakes strategic resources");
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to GreatLakes strategic resources");
		end	
		if availableResources["RESOURCE_IRON"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_IRON'].Index);
			print("RESOURCE_IRON added to GreatLakes strategic resources");
		end		
	end
	if region == "GreatPlains" and resourceClass == "luxury" then
		if availableResources["RESOURCE_SALT"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SALT'].Index);
			print("RESOURCE_SALT added to GreatPlains luxury resources");
		end	
	elseif(region == "GreatPlains" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to GreatPlains strategic resources");
		end	
		if availableResources["RESOURCE_OIL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_OIL'].Index);
			print("RESOURCE_OIL added to GreatPlains strategic resources");
		end		
	end
	if region == "Mesoamerica" and resourceClass == "luxury" then
		if availableResources["RESOURCE_COCOA"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COCOA'].Index);
			print("RESOURCE_COCOA added to Mesoamerica luxury resources");
		end
		if availableResources["RESOURCE_DYES"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_DYES'].Index);
			print("RESOURCE_DYES added to Mesoamerica luxury resources");
		end
		if availableResources["RESOURCE_JADE"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_JADE'].Index);
			print("RESOURCE_JADE added to Mesoamerica luxury resources");
		end
		if availableResources["RESOURCE_TOBACCO"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_TOBACCO'].Index);
			print("RESOURCE_TOBACCO added to Mesoamerica luxury resources");
		end	
	elseif(region == "Mesoamerica" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to Mesoamerica strategic resources");
		end	
		if availableResources["RESOURCE_OIL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_OIL'].Index);
			print("RESOURCE_OIL added to Mesoamerica strategic resources");
		end			
	end
	if region == "NewEngland" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to NewEngland luxury resources");
		end	
	elseif(region == "NewEngland" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to NewEngland strategic resources");
		end
		if availableResources["RESOURCE_IRON"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_IRON'].Index);
			print("RESOURCE_IRON added to NewEngland strategic resources");
		end
	end
	if region == "Nunavut" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to Nunavut luxury resources");
		end	
	elseif(region == "Nunavut" and resourceClass == "strategic") then
		if availableResources["RESOURCE_URANIUM"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_URANIUM'].Index);
			print("RESOURCE_URANIUM added to Nunavut strategic resources");
		end
	end
	if region == "Ontario" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to Ontario luxury resources");
		end
		if availableResources["RESOURCE_SILVER"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SILVER'].Index);
			print("RESOURCE_SILVER added to Ontario luxury resources");
		end
	elseif(region == "Ontario" and resourceClass == "strategic") then
		if availableResources["RESOURCE_URANIUM"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_URANIUM'].Index);
			print("RESOURCE_URANIUM added to Ontario strategic resources");
		end
	end
	if region == "Oregon" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to Oregon luxury resources");
		end	
		if availableResources["RESOURCE_GYPSUM"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_GYPSUM'].Index);
			print("RESOURCE_GYPSUM added to Oregon luxury resources");
		end
		if availableResources["RESOURCE_JADE"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_JADE'].Index);
			print("RESOURCE_JADE added to Oregon luxury resources");
		end	
		if availableResources["RESOURCE_SILVER"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SILVER'].Index);
			print("RESOURCE_SILVER added to Oregon luxury resources");
		end
	elseif(region == "Oregon" and resourceClass == "strategic") then
		if availableResources["RESOURCE_ALUMINUM"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_ALUMINUM'].Index);
			print("RESOURCE_ALUMINUM added to Oregon strategic resources");
		end	
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to Oregon strategic resources");
		end
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to Oregon strategic resources");
		end			
		if availableResources["RESOURCE_URANIUM"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_URANIUM'].Index);
			print("RESOURCE_URANIUM added to Oregon strategic resources");
		end			
	end
	if region == "PrairieProvinces" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to PrairieProvinces luxury resources");
		end	
	elseif(region == "PrairieProvinces" and resourceClass == "strategic") then
		if availableResources["RESOURCE_OIL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_OIL'].Index);
			print("RESOURCE_OIL added to PrairieProvinces strategic resources");
		end
	end
	if region == "Quebec" and resourceClass == "luxury" then
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to Quebec luxury resources");
		end
		if availableResources["RESOURCE_SUGAR"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SUGAR'].Index);
			print("RESOURCE_SUGAR added to Quebec luxury resources");
		end
	elseif(region == "Quebec" and resourceClass == "strategic") then
		if availableResources["RESOURCE_IRON"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_IRON'].Index);
			print("RESOURCE_IRON added to Quebec strategic resources");
		end
	end
	if region == "Texas" and resourceClass == "luxury" then
		if availableResources["RESOURCE_COTTON"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COTTON'].Index);
			print("RESOURCE_COTTON added to Texas luxury resources");
		end	
	elseif(region == "Texas" and resourceClass == "strategic") then
		if availableResources["RESOURCE_OIL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_OIL'].Index);
			print("RESOURCE_OIL added to Texas strategic resources");
			table.insert(resources, GameInfo.Resources['RESOURCE_OIL'].Index);
			print("RESOURCE_OIL added to Texas strategic resources");
		end			
	end
	if region == "Yukon" and resourceClass == "luxury" then
		if availableResources["RESOURCE_DIAMONDS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_DIAMONDS'].Index);
			print("RESOURCE_DIAMONDS added to Yukon luxury resources");
		end
		if availableResources["RESOURCE_FURS"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_FURS'].Index);
			print("RESOURCE_FURS added to Yukon luxury resources");
		end
		if availableResources["RESOURCE_SILVER"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_SILVER'].Index);
			print("RESOURCE_SILVER added to Yukon luxury resources");
		end	
	elseif(region == "Yukon" and resourceClass == "strategic") then
		if availableResources["RESOURCE_COAL"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_COAL'].Index);
			print("RESOURCE_COAL added to Yukon strategic resources");
		end
		if availableResources["RESOURCE_URANIUM"] then
			table.insert(resources, GameInfo.Resources['RESOURCE_URANIUM'].Index);
			print("RESOURCE_URANIUM added to Yukon strategic resources");
		end
	end
	if #resources > 0 then
		return resources;
	else
		return false;
	end
end

--Init blank resource regions (as function)
function GetResourceRegions_FromTable()
	if bShowFullLogs then print("Initializing GetResourceRegions_FromTable function"); end
	local resourceRegions = {};
	for loop in GameInfo.PTW_Regions_GiantEarth() do
		
	end
end

function GetResourceRegions()
	if bShowFullLogs then print("Initializing GetResourceRegions function"); end
	local resourceRegions = {
		--North America
		Alaska = {
			name = "Alaska",
			plots = {},
			luxuryResources = GetResources_REGION("Alaska", "luxury"),
			strategicResources = GetResources_REGION("Alaska", "strategic");
		},
		AmericanSouth = {
			name = "AmericanSouth",
			plots = {},
			luxuryResources = GetResources_REGION("AmericanSouth", "luxury"),
			strategicResources = GetResources_REGION("AmericanSouth", "strategic");
		},
		Arizona = {
			name = "Arizona",
			plots = {},
			luxuryResources = GetResources_REGION("Arizona", "luxury"),
			strategicResources = GetResources_REGION("Arizona", "strategic");
		},
		BritishColumbia = {
			name = "BritishColumbia",
			plots = {},
			luxuryResources = GetResources_REGION("BritishColumbia", "luxury"),
			strategicResources = GetResources_REGION("BritishColumbia", "strategic");
		},
		California = {
			name = "California",
			plots = {},
			luxuryResources = GetResources_REGION("California", "luxury"),
			strategicResources = GetResources_REGION("California", "strategic");
		},
		GreatBasin = {
			name = "GreatBasin",
			plots = {},
			luxuryResources = GetResources_REGION("GreatBasin", "luxury"),
			strategicResources = GetResources_REGION("GreatBasin", "strategic");
		},
		GreatLakes = {
			name = "GreatLakes",
			plots = {},
			luxuryResources = GetResources_REGION("GreatLakes", "luxury"),
			strategicResources = GetResources_REGION("GreatLakes", "strategic");
		},
		GreatPlains = {
			name = "GreatPlains",
			plots = {},
			luxuryResources = GetResources_REGION("GreatPlains", "luxury"),
			strategicResources = GetResources_REGION("GreatPlains", "strategic");
		},
		Mesoamerica = {
			name = "Mesoamerica",
			plots = {},
			luxuryResources = GetResources_REGION("Mesoamerica", "luxury"),
			strategicResources = GetResources_REGION("Mesoamerica", "strategic");
		},
		NewEngland = {
			name = "NewEngland",
			plots = {},
			luxuryResources = GetResources_REGION("NewEngland", "luxury"),
			strategicResources = GetResources_REGION("NewEngland", "strategic");
		},
		Nunavut = {
			name = "Nunavut",
			plots = {},
			luxuryResources = GetResources_REGION("Nunavut", "luxury"),
			strategicResources = GetResources_REGION("Nunavut", "strategic");
		},
		Ontario = {
			name = "Ontario",
			plots = {},
			luxuryResources = GetResources_REGION("Ontario", "luxury"),
			strategicResources = GetResources_REGION("Ontario", "strategic");
		},
		Oregon = {
			name = "Oregon",
			plots = {},
			luxuryResources = GetResources_REGION("Oregon", "luxury"),
			strategicResources = GetResources_REGION("Oregon", "strategic");
		},
		PrairieProvinces = {
			name = "PrairieProvinces",
			plots = {},
			luxuryResources = GetResources_REGION("PrairieProvinces", "luxury"),
			strategicResources = GetResources_REGION("PrairieProvinces", "strategic");
		},
		Quebec = {
			name = "Quebec",
			plots = {},
			luxuryResources = GetResources_REGION("Quebec", "luxury"),
			strategicResources = GetResources_REGION("Quebec", "strategic");
		},
		Texas = {
			name = "Texas",
			plots = {},
			luxuryResources = GetResources_REGION("Texas", "luxury"),
			strategicResources = GetResources_REGION("Texas", "strategic");
		},
		Yukon = {
			name = "Yukon",
			plots = {},
			luxuryResources = GetResources_REGION("Yukon", "luxury"),
			strategicResources = GetResources_REGION("Yukon", "strategic");
		},

		--Europe
		Aegean = {
			name = "Aegean",
			plots = {},
			luxuryResources = GetResources_REGION("Aegean", "luxury"),
			strategicResources = GetResources_REGION("Aegean", "strategic");
		},
		Balkans = {
			name = "Balkans",
			plots = {},
			luxuryResources = GetResources_REGION("Balkans", "luxury"),
			strategicResources = GetResources_REGION("Balkans", "strategic");
		},
		Gaul = {
			name = "Gaul",
			plots = {},
			luxuryResources = GetResources_REGION("Gaul", "luxury"),
			strategicResources = GetResources_REGION("Gaul", "strategic");
		},
		Germania = {
			name = "Germania",
			plots = {},
			luxuryResources = GetResources_REGION("Germania", "luxury"),
			strategicResources = GetResources_REGION("Germania", "strategic");
		},
		Iberia = {
			name = "Iberia",
			plots = {},
			luxuryResources = GetResources_REGION("Iberia", "luxury"),
			strategicResources = GetResources_REGION("Iberia", "strategic");
		},
		Italia = {
			name = "Italia",
			plots = {},
			luxuryResources = GetResources_REGION("Italia", "luxury"),
			strategicResources = GetResources_REGION("Italia", "strategic");
		};
	};
	return resourceRegions;
end

function RemoveRegionPlots(region :table, continentPlots :table)
	if #region.plots > 0 then
		print(tostring(region.name).." found!");
		for i, plot in ipairs(region.plots) do
			table.remove(continentPlots, continentPlots[plot]);
		end
		if bShowFullLogs then print("Removed "..tostring(region.name).." plots from continentPlots. Number of continentPlots left is "..tostring(#continentPlots)); end
	end
end

function SetRegionsByContinent()
	local continentsInUse :table = Map.GetContinentsInUse();
	local continentPlots :table = {};
	local pPlot;
	for _, eContinent in ipairs(continentsInUse) do 
		if (GameInfo.Continents[eContinent].ContinentType == "CONTINENT_NORTH_AMERICA") then
			print("CONTINENT_NORTH_AMERICA detected");
			continentPlots = Map.GetContinentPlots(eContinent);
			if bShowFullLogs then print("Starting number of continentPlots is "..tostring(#continentPlots)); end
			print("Find Nunavut...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 54 and pPlot:GetY() < 62 and pPlot:GetX() > 22 and pPlot:GetX() < 35 then
					table.insert(resourceRegions.Nunavut.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Nunavut plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Nunavut, continentPlots);
			print("Find Yukon...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 54 and pPlot:GetY() < 62 and pPlot:GetX() > 14 and pPlot:GetX() < 23 then
					table.insert(resourceRegions.Yukon.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Yukon plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Yukon, continentPlots);
			print("Find Quebec...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 50 and pPlot:GetY() < 57 and pPlot:GetX() > 35 and pPlot:GetX() < 47 then
					table.insert(resourceRegions.Quebec.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Quebec plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Quebec, continentPlots);
			print("Find PrairieProvinces...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 50 and pPlot:GetY() < 55 and pPlot:GetX() > 22 and pPlot:GetX() < 32 then
					table.insert(resourceRegions.PrairieProvinces.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found PrairieProvinces plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.PrairieProvinces, continentPlots);
			print("Find Ontario...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 50 and pPlot:GetY() < 55 and pPlot:GetX() > 31 and pPlot:GetX() < 36 then
					table.insert(resourceRegions.Ontario.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Ontario plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Ontario, continentPlots);
			print("Find Alaska...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 51 and pPlot:GetX() > 0 and pPlot:GetX() < 15 then
					table.insert(resourceRegions.Alaska.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Alaska plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Alaska, continentPlots);
			print("Find AmericanSouth...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() < 44 and pPlot:GetY() > 38 and pPlot:GetX() > 30 then
					table.insert(resourceRegions.AmericanSouth.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found AmericanSouth plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.AmericanSouth, continentPlots);
			print("Find Arizona...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() < 44 and pPlot:GetY() > 38 and pPlot:GetX() > 21 and pPlot:GetX() < 27 then
					table.insert(resourceRegions.Arizona.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Arizona plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Arizona, continentPlots);
			print("Find BritishColumbia...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 50 and pPlot:GetY() < 55 and pPlot:GetX() > 14 and pPlot:GetX() < 23 then
					table.insert(resourceRegions.BritishColumbia.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found BritishColumbia plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.BritishColumbia, continentPlots);
			print("Find California...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() < 48 and pPlot:GetY() > 38 and pPlot:GetX() < 22 then
					table.insert(resourceRegions.California.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found California plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.California, continentPlots);
			print("Find GreatBasin...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() < 48 and pPlot:GetY() > 43 and pPlot:GetX() > 21 and pPlot:GetX() < 27 then
					table.insert(resourceRegions.GreatBasin.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found GreatBasin plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.GreatBasin, continentPlots);
			print("Find GreatLakes...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 43 and pPlot:GetY() < 51 and pPlot:GetX() > 31 and pPlot:GetX() < 36 then
					table.insert(resourceRegions.GreatLakes.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found GreatLakes plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.GreatLakes, continentPlots);
			print("Find GreatPlains...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 43 and pPlot:GetY() < 51 and pPlot:GetX() > 26 and pPlot:GetX() < 32 then
					table.insert(resourceRegions.GreatPlains.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found GreatPlains plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.GreatPlains, continentPlots);
			print("Find Mesoamerica...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() < 45 then
					table.insert(resourceRegions.Mesoamerica.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Mesoamerica plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Mesoamerica, continentPlots);
			print("Find NewEngland...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 43 and pPlot:GetY() < 51 and pPlot:GetX() > 35 and pPlot:GetX() < 47 then
					table.insert(resourceRegions.NewEngland.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found NewEngland plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.NewEngland, continentPlots);
			print("Find Oregon...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() > 46 and pPlot:GetY() < 51 and pPlot:GetX() < 27 then
					table.insert(resourceRegions.Oregon.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Oregon plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Oregon, continentPlots);
			print("Find Texas...");
			for i, plot in ipairs(continentPlots) do
				pPlot = Map.GetPlotByIndex(plot);
				if pPlot:GetY() < 51 and pPlot:GetY() > 38 and pPlot:GetX() > 26 and pPlot:GetX() < 31 then
					table.insert(resourceRegions.Texas.plots, plot);
					if bShowFullLogs and bShowIndividualLogs then print("Found Texas plot"); end
				end
			end
			RemoveRegionPlots(resourceRegions.Texas, continentPlots);
		end
		-- if (GameInfo.Continents[eContinent].ContinentType == "CONTINENT_SOUTH_AMERICA") then
			-- print("CONTINENT_SOUTH_AMERICA detected");
			-- local continentPlots = Map.GetContinentPlots(eContinent);
			-- for i, plot in ipairs(continentPlots) do
				-- local pPlot = Map.GetPlotByIndex(plot);
				-- if pPlot:GetY() < 49 then
					-- print("Found mesoamerican plot");
					-- table.insert(Mesoamerica.plots, plot);
				-- end
			-- end
		-- end
	end
end

------------------------------------------------------------------------------
ResourceGenerator_PTW_GiantEarth = {};
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth.Create(args)
	print ("In ResourceGenerator_PTW_GiantEarth.Create()");
	print ("    Placing resources");
	
	-- call special functions for PTW_GiantEarth (will implement these better in the future)
	availableResources = GetAvailableResources();
	resourceRegions = GetResourceRegions();
	SetRegionsByContinent();
	
	-- create instance data
	local instance = {
			
		-- methods
		__InitResourceData		= ResourceGenerator_PTW_GiantEarth.__InitResourceData,
		__FindValidLocs			= ResourceGenerator_PTW_GiantEarth.__FindValidLocs,
		__GetLuxuryResources	= ResourceGenerator_PTW_GiantEarth.__GetLuxuryResources,
		__ValidLuxuryPlots		= ResourceGenerator_PTW_GiantEarth.__ValidLuxuryPlots,
		__PlaceLuxuryResources		= ResourceGenerator_PTW_GiantEarth.__PlaceLuxuryResources,
		__ScoreLuxuryPlots			= ResourceGenerator_PTW_GiantEarth.__ScoreLuxuryPlots,
		__GetWaterLuxuryResources			= ResourceGenerator_PTW_GiantEarth.__GetWaterLuxuryResources,
		__SetWaterLuxury			= ResourceGenerator_PTW_GiantEarth.__SetWaterLuxury,
		__PlaceWaterLuxury			= ResourceGenerator_PTW_GiantEarth.__PlaceWaterLuxury,
		__GetStrategicResources	= ResourceGenerator_PTW_GiantEarth.__GetStrategicResources,
		__ValidStrategicPlots		= ResourceGenerator_PTW_GiantEarth.__ValidStrategicPlots,
		__ScoreStrategicPlots			= ResourceGenerator_PTW_GiantEarth.__ScoreStrategicPlots,
		__PlaceStrategicResources		= ResourceGenerator_PTW_GiantEarth.__PlaceStrategicResources,
		__GetWaterStrategicResources	= ResourceGenerator_PTW_GiantEarth.__GetWaterStrategicResources,
		__SetWaterStrategic			= ResourceGenerator_PTW_GiantEarth.__SetWaterStrategic,
		__PlaceWaterStrategic			= ResourceGenerator_PTW_GiantEarth.__PlaceWaterStrategic,
		__GetOtherResources		= ResourceGenerator_PTW_GiantEarth.__GetOtherResources,
		__PlaceOtherResources		= ResourceGenerator_PTW_GiantEarth.__PlaceOtherResources,
		__GetWaterOtherResources		= ResourceGenerator_PTW_GiantEarth.__GetWaterOtherResources,
		__PlaceWaterOtherResources		= ResourceGenerator_PTW_GiantEarth.__PlaceWaterOtherResources,
		__RemoveOtherDuplicateResources		= ResourceGenerator_PTW_GiantEarth.__RemoveOtherDuplicateResources,
		__RemoveDuplicateResources		= ResourceGenerator_PTW_GiantEarth.__RemoveDuplicateResources,
		__ScorePlots			= ResourceGenerator_PTW_GiantEarth.__ScorePlots,
		__ScoreWaterPlots			= ResourceGenerator_PTW_GiantEarth.__ScoreWaterPlots,
		
		-- REGION Methods
		__PlaceLuxuryResources_REGION		= ResourceGenerator_PTW_GiantEarth.__PlaceLuxuryResources_REGION,
		__ScoreLuxuryPlots_REGION			= ResourceGenerator_PTW_GiantEarth.__ScoreLuxuryPlots_REGION,
		__ValidLuxuryPlots_REGION			= ResourceGenerator_PTW_GiantEarth.__ValidLuxuryPlots_REGION,
		__PlaceStrategicResources_REGION		= ResourceGenerator_PTW_GiantEarth.__PlaceStrategicResources_REGION,
		__ScoreStrategicPlots_REGION			= ResourceGenerator_PTW_GiantEarth.__ScoreStrategicPlots_REGION,
		__ValidStrategicPlots_REGION			= ResourceGenerator_PTW_GiantEarth.__ValidStrategicPlots_REGION,
		__SpawnLuxuryResources_REGION				= ResourceGenerator_PTW_GiantEarth.__SpawnLuxuryResources_REGION,
		__SpawnStrategicResources_REGION			= ResourceGenerator_PTW_GiantEarth.__SpawnStrategicResources_REGION,

		-- data
		iWaterLux = args.iWaterLux or 3;
		iWaterBonus = args.iWaterBonus or 1.25;
		iLuxuriesPerRegion = args.LuxuriesPerRegion or 4;
		resources = args.resources;
		uiStartConfig = args.START_CONFIG or 2,

		iResourcesInDB      = 0;
		iNumContinents		= 0;
		iTotalValidPlots    = 0;
		iWaterPlots = 0;
		iFrequencyTotal     = 0;
		iFrequencyTotalWater     = 0;
		iFrequencyStrategicTotal     = 0;
		iFrequencyStrategicTotalWater    = 0;
		iTargetPercentage   = 29;
		iStandardPercentage = 29;
		iLuxuryPercentage   = 20;
		iStrategicPercentage   = 19;
		iOccurencesPerFrequency = 0;
		iNumWaterLuxuries = 0;
		iNumWaterStrategics = 0;
		bOdd = false;
		eResourceType		= {},
		eResourceClassType	= {},
		iFrequency          = {},
		iSeaFrequency          = {},
		aLuxuryType		= {},
		aLuxuryTypeCoast		= {},
		aStrategicType		= {},
		aOtherType		= {},
		aOtherTypeWater		= {},
		aStrategicTypeCoast = {},
		aIndex = {},
		aaPossibleLuxLocs		= {},
		aaPossibleStratLocs		= {},
		aaPossibleLocs		= {},
		aaPossibleWaterLocs		= {},
		aResourcePlacementOrderStrategic = {},
		aResourcePlacementOrder = {},
		aWaterResourcePlacementOrder = {},
		aPeakEra = {},
	};

	-- initialize instance data
	instance:__InitResourceData()
	
	-- Chooses and then places the land luxury resources
	instance:__GetLuxuryResources()

	-- Chooses and then places the water luxury resources
	instance:__GetWaterLuxuryResources()

	-- Chooses and then places the land strategic resources
	instance:__GetStrategicResources()

	-- Chooses and then places the water strategic resources
	instance:__GetWaterStrategicResources()

	-- Chooses and then places the other resources [other is now only bonus, but later could be resource types added through mods]
	instance:__GetOtherResources()

	-- Chooses and then places the water other resources [other is now only bonus, but later could be resource types added through mods]
	instance:__GetWaterOtherResources()

	-- Removes too many adjacent other resources.
	instance:__RemoveOtherDuplicateResources()

	return instance;
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__InitResourceData()

	self.iResourcesInDB = 0;
	if (GameInfo.Maps[Map.GetMapSize()] ~= nil) then
		self.iLuxuriesThisSizeMap = GameInfo.Maps[Map.GetMapSize()].DefaultPlayers * 2;
	else
		self.iLuxuriesThisSizeMap = 12; -- Default size for Small map
	end

	-- Get resource value setting input by user.
	if self.resources == 1 then
			self.resources = -3;
	elseif self.resources == 3 then
			self.resources = 3;	
	elseif self.resources == 4 then
		self.resources = TerrainBuilder.GetRandomNumber(9, "Random Resources - Lua") - 4;
	else 
		self.resources = 0;
	end

	self.iTargetPercentage = self.iTargetPercentage + self.resources;


	for row in GameInfo.Resources() do
		self.eResourceType[self.iResourcesInDB] = row.Hash;
		self.aIndex[self.iResourcesInDB] = row.Index;
		self.eResourceClassType[self.iResourcesInDB] = row.ResourceClassType;
		self.aaPossibleLocs[self.iResourcesInDB] = {};
		self.aaPossibleWaterLocs[self.iResourcesInDB] = {};
		self.aaPossibleLuxLocs[self.iResourcesInDB] = {};
		self.aaPossibleStratLocs[self.iResourcesInDB] = {};
		self.iFrequency[self.iResourcesInDB] = row.Frequency;
		self.iSeaFrequency[self.iResourcesInDB] = row.SeaFrequency;
		self.aPeakEra[self.iResourcesInDB] = row.PeakEra;
	    self.iResourcesInDB = self.iResourcesInDB + 1;
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__SpawnLuxuryResources_REGION(region :table)
	if #region.plots > 0 then
		print("Spawning luxury resources for "..tostring(region.name));
		if region.luxuryResources then
			self:__ValidLuxuryPlots_REGION(region.luxuryResources, region.plots);
			for i, resource in ipairs(region.luxuryResources) do
				if bShowFullLogs then print("Spawning resource "..tostring(GameInfo.Resources[region.luxuryResources[i]].ResourceType)); end
				self:__PlaceLuxuryResources_REGION(region.luxuryResources[i], region.plots);
				if bShowFullLogs then print("Placed a luxury resource in "..tostring(region.name)); end
			end
		end	
	end
end

function ResourceGenerator_PTW_GiantEarth:__SpawnStrategicResources_REGION(region :table, weight)
	if #region.plots > 0 then
		print("Spawning strategic resources for "..tostring(region.name));
		if region.strategicResources then
			for i, resource in ipairs(region.strategicResources) do
				self:__ValidStrategicPlots_REGION(weight, region.plots);
				if bShowFullLogs then print("Spawning resource "..tostring(GameInfo.Resources[region.strategicResources[i]].ResourceType)); end
				self:__PlaceStrategicResources_REGION(region.strategicResources[i], region.plots);
				if bShowFullLogs then print("Placed a strategic resource in "..tostring(region.name)); end
			end
		end	
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__GetLuxuryResources()
	local continentsInUse = Map.GetContinentsInUse();	
	self.aLuxuryType = {};
	local max = self.iLuxuriesPerRegion;

	-- Find the Luxury Resources
	for row = 0, self.iResourcesInDB do
		local index = self.aIndex[row]
		if (self.eResourceClassType[row] == "RESOURCECLASS_LUXURY" and self.iFrequency[index] > 0) then
			table.insert(self.aLuxuryType, index);
		end
	end
	
	-- Shuffle the table
	self.aLuxuryType = GetShuffledCopyOfTable(self.aLuxuryType);

	for _, eContinent in ipairs(continentsInUse) do 
		--print ("Retrieved plots for continent: " .. tostring(eContinent));
		
		--totalslacker: Build continent spawns
		if (GameInfo.Continents[eContinent].ContinentType == "CONTINENT_NORTH_AMERICA") then
			print("North America detected");
			self:__SpawnLuxuryResources_REGION(resourceRegions.Alaska);
			self:__SpawnLuxuryResources_REGION(resourceRegions.AmericanSouth);
			self:__SpawnLuxuryResources_REGION(resourceRegions.Arizona);
			self:__SpawnLuxuryResources_REGION(resourceRegions.BritishColumbia);
			self:__SpawnLuxuryResources_REGION(resourceRegions.California);
			self:__SpawnLuxuryResources_REGION(resourceRegions.GreatBasin);
			self:__SpawnLuxuryResources_REGION(resourceRegions.GreatLakes);
			self:__SpawnLuxuryResources_REGION(resourceRegions.GreatPlains);
			self:__SpawnLuxuryResources_REGION(resourceRegions.Mesoamerica);
			self:__SpawnLuxuryResources_REGION(resourceRegions.NewEngland);
			self:__SpawnLuxuryResources_REGION(resourceRegions.Nunavut);
			self:__SpawnLuxuryResources_REGION(resourceRegions.Ontario);
			self:__SpawnLuxuryResources_REGION(resourceRegions.Oregon);
			self:__SpawnLuxuryResources_REGION(resourceRegions.PrairieProvinces);
			self:__SpawnLuxuryResources_REGION(resourceRegions.Quebec);
			self:__SpawnLuxuryResources_REGION(resourceRegions.Texas);
			self:__SpawnLuxuryResources_REGION(resourceRegions.Yukon);
		elseif(GameInfo.Continents[eContinent].ContinentType == "CONTINENT_SOUTH_AMERICA") then
			print("South America detected");
		else
			self:__ValidLuxuryPlots(eContinent);

			-- next find the valid plots for each of the luxuries
			local failed = 0;
			local iI = 1;
			local index = 1;
			while max >= iI and failed < 2 do 
				local eChosenLux = self.aLuxuryType[self.aIndex[index]];
				local isValid = false;
				if (eChosenLux ~= nil) then
					isValid = true;
				end
				
				if (isValid == true and #self.aLuxuryType > 0) then
					table.remove(self.aLuxuryType,index);
					self:__PlaceLuxuryResources(eChosenLux, eContinent);

					index = index + 1;
					iI = iI + 1;
					failed = 0;
				end

				if index > #self.aLuxuryType then
					index = 1;
					failed = failed + 1;
				elseif (isValid == false) then
					failed = failed + 1;
				end
			end		
		end
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__ValidLuxuryPlots_REGION(resources, plots)
	-- go through each plot on the continent and put the luxuries	
	local iSize = #resources;
	local iBaseScore = 1;
	self.iTotalValidPlots = 0;
	
	local iNumPlots = #plots;
	for i, plot in ipairs(plots) do

		local bCanHaveSomeResource = false;
		local pPlot = Map.GetPlotByIndex(plot);

		if(pPlot~=nil and pPlot:IsWater() == false) then

			-- See which resources can appear here
			for iI = 1, iSize do
				local bIce = false;

				if(IsAdjacentToIce(pPlot:GetX(), pPlot:GetY()) == true) then
					bIce = true;
				end
			
				if (ResourceBuilder.CanHaveResource(pPlot, resources[iI]) and bIce == false) then
					row = {};
					row.MapIndex = plot;
					row.Score = iBaseScore;

					table.insert (self.aaPossibleLuxLocs[resources[iI]], row);
					bCanHaveSomeResource = true;
				end
			end


			if (bCanHaveSomeResource == true) then
				self.iTotalValidPlots = self.iTotalValidPlots + 1;
			end

		end

		-- Compute how many of each resource to place
	end
	
	--This is a fix to make land heavy maps have a more equal amount of luxuries to other maps. Unless it is a legendary start.
	if(self.iWaterLux == 1 and self.uiStartConfig ~= 3) then
		iNumPlots = iNumPlots / 2;
	end

	self.iOccurencesPerFrequency = self.iTargetPercentage / 100 * iNumPlots * self.iLuxuryPercentage / 100 / self.iLuxuriesPerRegion;
end

function ResourceGenerator_PTW_GiantEarth:__ValidLuxuryPlots(eContinent)
	-- go through each plot on the continent and put the luxuries	
	local iSize = #self.aLuxuryType;
	local iBaseScore = 1;
	self.iTotalValidPlots = 0;

	plots = Map.GetContinentPlots(eContinent);
	local iNumPlots = #plots;
	for i, plot in ipairs(plots) do

		local bCanHaveSomeResource = false;
		local pPlot = Map.GetPlotByIndex(plot);

		if(pPlot~=nil and pPlot:IsWater() == false) then

			-- See which resources can appear here
			for iI = 1, iSize do
				local bIce = false;

				if(IsAdjacentToIce(pPlot:GetX(), pPlot:GetY()) == true) then
					bIce = true;
				end
			
				if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[self.aLuxuryType[iI]]) and bIce == false) then
					row = {};
					row.MapIndex = plot;
					row.Score = iBaseScore;

					table.insert (self.aaPossibleLuxLocs[self.aLuxuryType[iI]], row);
					bCanHaveSomeResource = true;
				end
			end


			if (bCanHaveSomeResource == true) then
				self.iTotalValidPlots = self.iTotalValidPlots + 1;
			end

		end

		-- Compute how many of each resource to place
	end
	
	--This is a fix to make land heavy maps have a more equal amount of luxuries to other maps. Unless it is a legendary start.
	if(self.iWaterLux == 1 and self.uiStartConfig ~= 3) then
		iNumPlots = iNumPlots / 2;
	end

	self.iOccurencesPerFrequency = self.iTargetPercentage / 100 * iNumPlots * self.iLuxuryPercentage / 100 / self.iLuxuriesPerRegion;
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__PlaceLuxuryResources_REGION(eChosenLux, plots)
	-- Go through region placing the chosen luxuries
	--print ("Occurrences per frequency: " .. tostring(self.iOccurencesPerFrequency));
	--print("Resource: ", eChosenLux);

	local iTotalPlaced = 0;

	-- Compute how many to place
	local iNumToPlace = 1;
	if(self.iOccurencesPerFrequency > 1) then
		iNumToPlace = self.iOccurencesPerFrequency;
	end

	-- Score possible locations
	self:__ScoreLuxuryPlots_REGION(eChosenLux, plots);

	-- Sort and take best score
	table.sort (self.aaPossibleLuxLocs[eChosenLux], function(a, b) return a.Score > b.Score; end);

	for iI = 1, iNumToPlace do
			if (iI <= #self.aaPossibleLuxLocs[eChosenLux]) then
				local iMapIndex = self.aaPossibleLuxLocs[eChosenLux][iI].MapIndex;
				local iScore = self.aaPossibleLuxLocs[eChosenLux][iI].Score;

				-- Place at this location
				local pPlot = Map.GetPlotByIndex(iMapIndex);
				ResourceBuilder.SetResourceType(pPlot, self.eResourceType[eChosenLux], 1);
			iTotalPlaced = iTotalPlaced + 1;
			--print ("   Placed at (" .. tostring(pPlot:GetX()) .. ", " .. tostring(pPlot:GetY()) .. ") with score of " .. tostring(iScore));
		end
	end
end

function ResourceGenerator_PTW_GiantEarth:__PlaceLuxuryResources(eChosenLux, eContinent)
	-- Go through continent placing the chosen luxuries
	
	plots = Map.GetContinentPlots(eContinent);
	--print ("Occurrences per frequency: " .. tostring(self.iOccurencesPerFrequency));
	--print("Resource: ", eChosenLux);

	local iTotalPlaced = 0;

	-- Compute how many to place
	local iNumToPlace = 1;
	if(self.iOccurencesPerFrequency > 1) then
		iNumToPlace = self.iOccurencesPerFrequency;
	end

	-- Score possible locations
	self:__ScoreLuxuryPlots(eChosenLux, eContinent);

	-- Sort and take best score
	table.sort (self.aaPossibleLuxLocs[eChosenLux], function(a, b) return a.Score > b.Score; end);

	for iI = 1, iNumToPlace do
			if (iI <= #self.aaPossibleLuxLocs[eChosenLux]) then
				local iMapIndex = self.aaPossibleLuxLocs[eChosenLux][iI].MapIndex;
				local iScore = self.aaPossibleLuxLocs[eChosenLux][iI].Score;

				-- Place at this location
				local pPlot = Map.GetPlotByIndex(iMapIndex);
				ResourceBuilder.SetResourceType(pPlot, self.eResourceType[eChosenLux], 1);
			iTotalPlaced = iTotalPlaced + 1;
			--print ("   Placed at (" .. tostring(pPlot:GetX()) .. ", " .. tostring(pPlot:GetY()) .. ") with score of " .. tostring(iScore));
		end
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__ScoreLuxuryPlots_REGION(iResourceIndex, plots)
	-- Clear all earlier entries (some might not be valid if resources have been placed
	for k, v in pairs(self.aaPossibleLuxLocs[iResourceIndex]) do
		self.aaPossibleLuxLocs[iResourceIndex][k] = nil;
	end
	for i, plot in ipairs(plots) do
		local pPlot = Map.GetPlotByIndex(plot);
		local bIce = false;
		
		if(IsAdjacentToIce(pPlot:GetX(), pPlot:GetY()) == true) then
			bIce = true;
		end

		if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[iResourceIndex]) and bIce == false) then
			row = {};
			row.MapIndex = plot;
			row.Score = 500;
			row.Score = row.Score / ((ResourceBuilder.GetAdjacentResourceCount(pPlot) + 1) * 3.5);
			row.Score = row.Score + TerrainBuilder.GetRandomNumber(100, "Resource Placement Score Adjust");
			
			if(ResourceBuilder.GetAdjacentResourceCount(pPlot) <= 1 or #self.aaPossibleLuxLocs == 0) then
					table.insert (self.aaPossibleLuxLocs[iResourceIndex], row);
			end
		end
	end
end

function ResourceGenerator_PTW_GiantEarth:__ScoreLuxuryPlots(iResourceIndex, eContinent)
	-- Clear all earlier entries (some might not be valid if resources have been placed
	for k, v in pairs(self.aaPossibleLuxLocs[iResourceIndex]) do
		self.aaPossibleLuxLocs[iResourceIndex][k] = nil;
	end

	plots = Map.GetContinentPlots(eContinent);
	for i, plot in ipairs(plots) do
		local pPlot = Map.GetPlotByIndex(plot);
		local bIce = false;
		
		if(IsAdjacentToIce(pPlot:GetX(), pPlot:GetY()) == true) then
			bIce = true;
		end

		if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[iResourceIndex]) and bIce == false) then
			row = {};
			row.MapIndex = plot;
			row.Score = 500;
			row.Score = row.Score / ((ResourceBuilder.GetAdjacentResourceCount(pPlot) + 1) * 3.5);
			row.Score = row.Score + TerrainBuilder.GetRandomNumber(100, "Resource Placement Score Adjust");
			
			if(ResourceBuilder.GetAdjacentResourceCount(pPlot) <= 1 or #self.aaPossibleLuxLocs == 0) then
					table.insert (self.aaPossibleLuxLocs[iResourceIndex], row);
			end
		end
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__GetWaterLuxuryResources()
	self.aLuxuryTypeCoast = {};

	-- Find the Luxury Resources
	for row = 0, self.iResourcesInDB do
		local index = self.aIndex[row]
		if (self.eResourceClassType[row] == "RESOURCECLASS_LUXURY" and self.iSeaFrequency[index] > 0) then
			table.insert(self.aLuxuryTypeCoast, index);
		end
	end
	
	-- Shuffle the table
	self.aLuxuryTypeCoast = GetShuffledCopyOfTable(self.aLuxuryTypeCoast);

	-- Find the Map Size
	local iW, iH;
	iW, iH = Map.GetGridSize();
	local iSize = Map.GetMapSize() + 1;

	-- Use the Map Size to Determine the number of Water Luxuries
	for row in GameInfo.Resource_SeaLuxuries() do
		if (row.MapArgument == self.iWaterLux ) then
			if(iSize <= 1) then
				self.iNumWaterLuxuries = row.Duel;
			elseif(iSize == 2) then
				self.iNumWaterLuxuries = row.Tiny;
			elseif(iSize == 3) then
				self.iNumWaterLuxuries = row.Small;
			elseif(iSize == 4) then
				self.iNumWaterLuxuries = row.Standard;
			elseif(iSize == 5) then
				self.iNumWaterLuxuries = row.Large;
			else
				self.iNumWaterLuxuries = row.Huge;
			end
		end
	end

	if (self.iNumWaterLuxuries == 0) then
		return
	end

	local iNumLuxuries = math.floor(self.iNumWaterLuxuries / 2);
	self.bOdd = false;

	-- Determine if the number of water luxuries is odd
	if(self.iNumWaterLuxuries % 2 == 1) then
		self.bOdd = true;
		iNumLuxuries = iNumLuxuries + 1
	end


	-- Water plots
	self.iWaterPlots = 0;
	for x = 0, iW - 1 do
		for y = 0, iH - 1 do
			local i = y * iW + x;
			local pPlot = Map.GetPlotByIndex(i);

			if(pPlot~=nil) then
				local terrainType = pPlot:GetTerrainType();
				if(terrainType == g_TERRAIN_TYPE_COAST and IsAdjacentToIce(pPlot:GetX(), pPlot:GetY()) == false) then
					self.iWaterPlots = self.iWaterPlots + 1;
				end
			end
		end
	end


	self.iOccurencesPerFrequency =  self.iTargetPercentage / 100 * self.iWaterPlots * self.iLuxuryPercentage / 100 / iNumLuxuries / 2;
	
	aLuxuries = {};
	aLuxuries = self.aLuxuryTypeCoast;

	--First go through check the tropics
	for i = 1, iNumLuxuries do
		local eChosenLux  = aLuxuries[i];
		if(eChosenLux == nil)  then
			return;
		else
			self:__SetWaterLuxury(eChosenLux, 100.0, 35.1);
		end
	end

	aLuxuries = self.aLuxuryTypeCoast;

	--Then check the equator
	for i = 1, iNumLuxuries do		
		local eChosenLux  = aLuxuries[i];
		if(eChosenLux == nil)  then
			return;
		else
			self:__SetWaterLuxury(eChosenLux, 35.0, 0.0);
		end
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__SetWaterLuxury(eChosenLux, latitudeMax, latitudeMin, index)
	local bOddSwitch = false;
	local bFirst = true;
	local iNumber = 0
	local iW, iH;
	iW, iH = Map.GetGridSize();

	local iNumToPlace = self.iOccurencesPerFrequency * self.iSeaFrequency[eChosenLux];

	for x = 0, iW - 1 do
		for y = 0, iH - 1 do
			local i = y * iW + x;
			local pPlot = Map.GetPlotByIndex(i);
			-- Water plots
			if(pPlot~=nil and pPlot:IsWater() == true and IsAdjacentToIce(pPlot:GetX(), pPlot:GetY()) == false) then
				local lat = math.abs((iH/2) - y)/(iH/2) * 100.0;
				if(lat < latitudeMax and lat > latitudeMin and iNumber <= iNumToPlace) then

					-- If the the luxury is placed then it returns true and is removed
					local bChosen = self:__PlaceWaterLuxury(eChosenLux, pPlot);
					if(bChosen == true) then
						if(bFirst == true) then
							if(self.bOdd == true) then
								bOddSwitch = true;
							else
								if(#self.aLuxuryTypeCoast > 0) then
									table.remove(self.aLuxuryTypeCoast, 1);
								else
									return;
								end
							end

							bFirst = false;
						end

						iNumber = iNumber + 1;
					end
				end
			end

			if(bOddSwitch == true and self.bOdd == true) then
				self.bOdd  = false;
			end	
		end
	end

	--print("Water Resource: ", eChosenLux, " number placed = ",  iNumber);
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__PlaceWaterLuxury(eChosenLux, pPlot)
	if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[eChosenLux])) then
		-- Randomly detetermine each plot if a water luxury is placed less likely if there are adjacent of the same type

		local iBonusAdjacent = 0;

		if( self.iStandardPercentage < self.iTargetPercentage) then
			iBonusAdjacent = -1.5;
		elseif ( self.iStandardPercentage > self.iTargetPercentage) then
			iBonusAdjacent = 1;
		end
			
		local iRandom = 15 * self.iOccurencesPerFrequency + 300;

		--print ("Random Frequency: " , iRandom);

		local score = TerrainBuilder.GetRandomNumber(iRandom, "Resource Placement Score Adjust");
		score = score / ((ResourceBuilder.GetAdjacentResourceCount(pPlot) + 1) * (3.0 + iBonusAdjacent));
			
		if(score * self.iSeaFrequency[eChosenLux] >= 85 + 5 * self.iOccurencesPerFrequency) then
			ResourceBuilder.SetResourceType(pPlot, self.eResourceType[eChosenLux], 1);
			return true
		end
	end

	return false;
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__GetStrategicResources()
	local continentsInUse = Map.GetContinentsInUse();	
	self.iNumContinents = #continentsInUse;
	self.aStrategicType = {};

	-- Find the Strategic Resources
	for row = 0, self.iResourcesInDB do
		local index = self.aIndex[row]
		if (self.eResourceClassType[row] == "RESOURCECLASS_STRATEGIC" and self.iFrequency[index] > 0) then
				table.insert(self.aStrategicType, index);
		end
	end

	aWeight = {};
	for row in GameInfo.Resource_Distribution() do
		if (row.Continents == self.iNumContinents) then
			if(self.uiStartConfig == 1 ) then
				for iI = 1, row.Continents do
					table.insert(aWeight, 1);
				end
			else
				for iI = 1, row.Scarce do
					table.insert(aWeight, 1 - row.PercentAdjusted / 100);
				end

				for iI = 1, row.Average do
					table.insert(aWeight, 1);
				end

				for iI = 1, row.Plentiful do
					table.insert(aWeight, 1 + row.PercentAdjusted / 100);
				end
			end
		end
	end

	aWeight	= GetShuffledCopyOfTable(aWeight);

	self.iFrequencyStrategicTotal = 0;
    for i, row in ipairs(self.aStrategicType) do
		self.iFrequencyStrategicTotal = self.iFrequencyStrategicTotal + self.iFrequency[row];
	end

	for index, eContinent in ipairs(continentsInUse) do 
		-- Shuffle the table
		if (GameInfo.Continents[eContinent].ContinentType == "CONTINENT_NORTH_AMERICA") then
			print("North America detected");
			self.aStrategicType = GetShuffledCopyOfTable(self.aStrategicType);
			self:__SpawnStrategicResources_REGION(resourceRegions.Alaska, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.AmericanSouth, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.Arizona, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.BritishColumbia, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.California, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.GreatBasin, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.GreatLakes, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.GreatPlains, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.Mesoamerica, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.NewEngland, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.Nunavut, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.Ontario, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.Oregon, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.PrairieProvinces, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.Quebec, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.Texas, aWeight[index]);
			self:__SpawnStrategicResources_REGION(resourceRegions.Yukon, aWeight[index]);
		else
			-- Shuffle the table
			self.aStrategicType = GetShuffledCopyOfTable(self.aStrategicType);
			--print ("Retrieved plots for continent: " .. tostring(eContinent));

			self:__ValidStrategicPlots(aWeight[index], eContinent);

			-- next find the valid plots for each of the strategics
			self:__PlaceStrategicResources(eContinent);		
		end
	end
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__ValidStrategicPlots_REGION(iWeight, plots)
	-- go through each plot on the continent and find the valid strategic plots
	local iSize = #self.aStrategicType;
	local iBaseScore = 1;
	self.iTotalValidPlots = 0;
	self.aResourcePlacementOrderStrategic = {};

	-- Find valid spots for land resources first
	for i, plot in ipairs(plots) do
		local bCanHaveSomeResource = false;
		local pPlot = Map.GetPlotByIndex(plot);

		-- See which resources can appear here
		for iI = 1, iSize do
			local eResourceType = self.eResourceType[self.aStrategicType[iI]]
			if (ResourceBuilder.CanHaveResource(pPlot, eResourceType)) then
				row = {};
				row.MapIndex = plot;
				row.Score = iBaseScore;
				table.insert (self.aaPossibleStratLocs[self.aStrategicType[iI]], row);
				bCanHaveSomeResource = true;
			end
		end

		if (bCanHaveSomeResource == true) then
			self.iTotalValidPlots = self.iTotalValidPlots + 1;
		end
	end

	for iI = 1, iSize do
		row = {};
		row.ResourceIndex = self.aStrategicType[iI];
		row.NumEntries = #self.aaPossibleStratLocs[iI];
		row.Weight = iWeight or 0;
		table.insert (self.aResourcePlacementOrderStrategic, row);
	end

	table.sort (self.aResourcePlacementOrderStrategic, function(a, b) return a.NumEntries < b.NumEntries; end);

	self.iOccurencesPerFrequency = (#plots) * (self.iTargetPercentage / 100)  * (self.iStrategicPercentage / 100);
end

function ResourceGenerator_PTW_GiantEarth:__ValidStrategicPlots(iWeight, eContinent)
	-- go through each plot on the continent and find the valid strategic plots
	local iSize = #self.aStrategicType;
	local iBaseScore = 1;
	self.iTotalValidPlots = 0;
	self.aResourcePlacementOrderStrategic = {};
	plots = Map.GetContinentPlots(eContinent);

	-- Find valid spots for land resources first
	for i, plot in ipairs(plots) do
		local bCanHaveSomeResource = false;
		local pPlot = Map.GetPlotByIndex(plot);

		-- See which resources can appear here
		for iI = 1, iSize do
			local eResourceType = self.eResourceType[self.aStrategicType[iI]]
			if (ResourceBuilder.CanHaveResource(pPlot, eResourceType)) then
				row = {};
				row.MapIndex = plot;
				row.Score = iBaseScore;
				table.insert (self.aaPossibleStratLocs[self.aStrategicType[iI]], row);
				bCanHaveSomeResource = true;
			end
		end

		if (bCanHaveSomeResource == true) then
			self.iTotalValidPlots = self.iTotalValidPlots + 1;
		end
	end

	for iI = 1, iSize do
		row = {};
		row.ResourceIndex = self.aStrategicType[iI];
		row.NumEntries = #self.aaPossibleStratLocs[iI];
		row.Weight = iWeight or 0;
		table.insert (self.aResourcePlacementOrderStrategic, row);
	end

	table.sort (self.aResourcePlacementOrderStrategic, function(a, b) return a.NumEntries < b.NumEntries; end);

	self.iOccurencesPerFrequency = (#plots) * (self.iTargetPercentage / 100)  * (self.iStrategicPercentage / 100);
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__PlaceStrategicResources_REGION(resource, plots)
	-- Go through continent placing the chosen strategic
	local eResourceType = resource

	local iNumToPlace;

	-- Compute how many to place
	iNumToPlace = self.iOccurencesPerFrequency * (self.iFrequency[resource] / self.iFrequencyStrategicTotal) * row.Weight;

		-- Score possible locations
	self:__ScoreStrategicPlots_REGION(resource, plots);

	-- Sort and take best score
	table.sort (self.aaPossibleStratLocs[resource], function(a, b) return a.Score > b.Score; end);

	if(self.iFrequency[resource] > 1 and iNumToPlace < 1) then
		iNumToPlace = 1;
	end

	for iI = 1, iNumToPlace do
		if (iI <= #self.aaPossibleStratLocs[resource]) then
			local iMapIndex = self.aaPossibleStratLocs[resource][iI].MapIndex;
			local iScore = self.aaPossibleStratLocs[resource][iI].Score;

			-- Place at this location
			local pPlot = Map.GetPlotByIndex(iMapIndex);
			ResourceBuilder.SetResourceType(pPlot, eResourceType, 1);
--			print ("   Placed at (" .. tostring(pPlot:GetX()) .. ", " .. tostring(pPlot:GetY()) .. ") with score of " .. tostring(iScore));
		end
	end	
	-- for i, row in ipairs(self.aResourcePlacementOrderStrategic) do

	-- end
end

function ResourceGenerator_PTW_GiantEarth:__PlaceStrategicResources(eContinent)
	-- Go through continent placing the chosen strategic
	for i, row in ipairs(self.aResourcePlacementOrderStrategic) do
		local eResourceType = self.eResourceType[row.ResourceIndex]

		local iNumToPlace;

		-- Compute how many to place
		iNumToPlace = self.iOccurencesPerFrequency * (self.iFrequency[row.ResourceIndex] / self.iFrequencyStrategicTotal) * row.Weight;

			-- Score possible locations
		self:__ScoreStrategicPlots(row.ResourceIndex, eContinent);

		-- Sort and take best score
		table.sort (self.aaPossibleStratLocs[row.ResourceIndex], function(a, b) return a.Score > b.Score; end);

		if(self.iFrequency[row.ResourceIndex] > 1 and iNumToPlace < 1) then
			iNumToPlace = 1;
		end

		for iI = 1, iNumToPlace do
			if (iI <= #self.aaPossibleStratLocs[row.ResourceIndex]) then
				local iMapIndex = self.aaPossibleStratLocs[row.ResourceIndex][iI].MapIndex;
				local iScore = self.aaPossibleStratLocs[row.ResourceIndex][iI].Score;

				-- Place at this location
				local pPlot = Map.GetPlotByIndex(iMapIndex);
				ResourceBuilder.SetResourceType(pPlot, eResourceType, 1);
--				print ("   Placed at (" .. tostring(pPlot:GetX()) .. ", " .. tostring(pPlot:GetY()) .. ") with score of " .. tostring(iScore));
			end
		end
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__ScoreStrategicPlots_REGION(iResourceIndex, plots)
	-- Clear all earlier entries (some might not be valid if resources have been placed
	for k, v in pairs(self.aaPossibleStratLocs[iResourceIndex]) do
		self.aaPossibleStratLocs[iResourceIndex][k] = nil;
	end

	for i, plot in ipairs(plots) do
		local pPlot = Map.GetPlotByIndex(plot);
		if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[iResourceIndex])) then
			row = {};
			row.MapIndex = plot;
			row.Score = 500;
			row.Score = row.Score / ((ResourceBuilder.GetAdjacentResourceCount(pPlot) + 1) * 4.5);
			row.Score = row.Score + TerrainBuilder.GetRandomNumber(100, "Resource Placement Score Adjust");
			
			if(ResourceBuilder.GetAdjacentResourceCount(pPlot) <= 1 or #self.aaPossibleStratLocs == 0) then
				table.insert (self.aaPossibleStratLocs[iResourceIndex], row);
			end
		end
	end
end

function ResourceGenerator_PTW_GiantEarth:__ScoreStrategicPlots(iResourceIndex, eContinent)
	-- Clear all earlier entries (some might not be valid if resources have been placed
	for k, v in pairs(self.aaPossibleStratLocs[iResourceIndex]) do
		self.aaPossibleStratLocs[iResourceIndex][k] = nil;
	end

	plots = Map.GetContinentPlots(eContinent);
	for i, plot in ipairs(plots) do
		local pPlot = Map.GetPlotByIndex(plot);
		if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[iResourceIndex])) then
			row = {};
			row.MapIndex = plot;
			row.Score = 500;
			row.Score = row.Score / ((ResourceBuilder.GetAdjacentResourceCount(pPlot) + 1) * 4.5);
			row.Score = row.Score + TerrainBuilder.GetRandomNumber(100, "Resource Placement Score Adjust");
			
			if(ResourceBuilder.GetAdjacentResourceCount(pPlot) <= 1 or #self.aaPossibleStratLocs == 0) then
				table.insert (self.aaPossibleStratLocs[iResourceIndex], row);
			end
		end
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__GetWaterStrategicResources()
	self.aStrategicTypeCoast = {};

	-- Find the Strategic Resources
	for row = 0, self.iResourcesInDB do
		local index = self.aIndex[row]
		if (self.eResourceClassType[row] == "RESOURCECLASS_STRATEGIC" and self.iSeaFrequency[index] > 0) then
			table.insert(self.aStrategicTypeCoast, index);
		end
	end
	
	-- Shuffle the table
	self.aStrategicTypeCoast = GetShuffledCopyOfTable(self.aStrategicTypeCoast);

	-- Find the Map Size
	local iW, iH;
	iW, iH = Map.GetGridSize();
	local iSize = Map.GetMapSize() + 1;

	-- Use the Map Size to Determine the number of Water Strategics
	for row in GameInfo.Resource_SeaStrategics() do
		if (row.MapArgument == self.iWaterLux ) then
			if(iSize <= 1) then
				self.iNumWaterStrategics = row.Duel;
			elseif(iSize == 2) then
				self.iNumWaterStrategics = row.Tiny;
			elseif(iSize == 3) then
				self.iNumWaterStrategics = row.Small;
			elseif(iSize == 4) then
				self.iNumWaterStrategics = row.Standard;
			elseif(iSize == 5) then
				self.iNumWaterStrategics = row.Large;
			else
				self.iNumWaterStrategics = row.Huge;
			end
		end
	end

	if (self.iNumWaterStrategics == 0) then
		return
	end

	local iNumStrategics = math.floor(self.iNumWaterStrategics / 2);
	self.bOdd = false;

	-- Determine if the number of water strategics is odd
	if(self.iNumWaterStrategics % 2 == 1) then
		self.bOdd = true;
		iNumStrategics = iNumStrategics + 1
	end

	

	-- Water plots
	self.iWaterPlots = 0;
	for x = 0, iW - 1 do
		for y = 0, iH - 1 do
			local i = y * iW + x;
			local pPlot = Map.GetPlotByIndex(i);

			if(pPlot~=nil) then
				local terrainType = pPlot:GetTerrainType();
				if(terrainType == g_TERRAIN_TYPE_COAST and IsAdjacentToIce(pPlot:GetX(), pPlot:GetY()) == false) then
					self.iWaterPlots = self.iWaterPlots + 1;
				end
			end
		end
	end


	self.iOccurencesPerFrequency =  self.iTargetPercentage / 100.0 * self.iWaterPlots * self.iStrategicPercentage / 100.0 / iNumStrategics / 6.0;
	
	aStrategics = {};
	aStrategics = self.aStrategicTypeCoast;

	--First go through check the tropics
	for i = 1, iNumStrategics do
		local eChosenStrat  = aStrategics[i];
		if(eChosenStrat == nil)  then
			return;
		else
			self:__SetWaterStrategic(eChosenStrat, 100.0, 35.1);
		end
	end

	aStrategics = self.aStrategicTypeCoast;

	--Then check the equator
	for i = 1, iNumStrategics do		
		local eChosenStrat  = aStrategics[i];
		if(eChosenStrat == nil)  then
			return;
		else
			self:__SetWaterStrategic(eChosenStrat, 35.0, 0.0);
		end
	end
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__SetWaterStrategic(eChosenStrat, latitudeMax, latitudeMin, index)
	local bOddSwitch = false;
	local bFirst = true;
	local iNumber = 0
	local iW, iH;
	iW, iH = Map.GetGridSize();

	for x = 0, iW - 1 do
		for y = 0, iH - 1 do
			local i = y * iW + x;
			local pPlot = Map.GetPlotByIndex(i);
			-- Water plots
			if(pPlot~=nil and pPlot:IsWater() == true and IsAdjacentToIce(pPlot:GetX(), pPlot:GetY()) == false) then
				local lat = math.abs((iH/2) - y)/(iH/2) * 100.0;
				if(lat < latitudeMax and lat > latitudeMin and iNumber <= self.iOccurencesPerFrequency) then

					-- If the the strategic is placed then it returns true and is removed
					local bChosen = self:__PlaceWaterStrategic(eChosenStrat, pPlot);
					if(bChosen == true) then
						if(bFirst == true) then
							if(self.bOdd == true) then
								bOddSwitch = true;
							else
								if(#self.aStrategicTypeCoast > 0) then
									table.remove(self.aStrategicTypeCoast, 1);
								else
									return;
								end
							end

							bFirst = false;
						end

						iNumber = iNumber + 1;
					end
				end
			end

			if(bOddSwitch == true and self.bOdd == true) then
				self.bOdd  = false;
			end	
		end
	end

	--print("Water Resource: ", eChosenStrat, " number placed = ",  iNumber);
end

------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__PlaceWaterStrategic(eChosenStrat, pPlot)
	if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[eChosenStrat])) then
		-- Randomly detetermine each plot if a water strategic is placed less likely if there are adjacent of the same type

		local iBonusAdjacent = 0;

		if( self.iStandardPercentage < self.iTargetPercentage) then
			iBonusAdjacent = -1.5;
		elseif ( self.iStandardPercentage > self.iTargetPercentage) then
			iBonusAdjacent = -0.5;
		end
			
		local iRandom = 15 * self.iOccurencesPerFrequency + 300;

		--print ("Random Frequency: " , iRandom);

		local score = TerrainBuilder.GetRandomNumber(iRandom, "Resource Placement Score Adjust");
		score = score / ((ResourceBuilder.GetAdjacentResourceCount(pPlot) + 1) * (3.0 + iBonusAdjacent));
			
		if(score >= 85 + 5 * self.iOccurencesPerFrequency) then
			ResourceBuilder.SetResourceType(pPlot, self.eResourceType[eChosenStrat], 1);
			return true
		end
	end

	return false;
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__GetOtherResources()
	self.aOtherType = {};
	-- Find the other resources
    for row = 0, self.iResourcesInDB do
		local index  = self.aIndex[row];
		if(self.eResourceClassType[index] ~= nil) then
			if (self.eResourceClassType[index] ~= "RESOURCECLASS_STRATEGIC" and self.eResourceClassType[index] ~= "RESOURCECLASS_LUXURY" and self.eResourceClassType[index] ~= "RESOURCECLASS_ARTIFACT") then
				if(self.iFrequency[index] > 0) then
					table.insert(self.aOtherType, index);
				end
			end
		end
	end

	-- Shuffle the table
	self.aOtherType = GetShuffledCopyOfTable(self.aOtherType);

	local iW, iH;
	iW, iH = Map.GetGridSize();

	local iBaseScore = 1;
	self.iTotalValidPlots = 0;
	local iSize = #self.aOtherType;
	local iPlotCount = Map.GetPlotCount();
	for i = 0, iPlotCount - 1 do
		local pPlot = Map.GetPlotByIndex(i);
		local bCanHaveSomeResource = false;

		-- See which resources can appear here
		for iI = 1, iSize do
			if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[self.aOtherType[iI]])) then
				row = {};
				row.MapIndex = i;
				row.Score = iBaseScore;
				table.insert (self.aaPossibleLocs[self.aOtherType[iI]], row);
				bCanHaveSomeResource = true;
			end
		end

		if (bCanHaveSomeResource == true) then
			self.iTotalValidPlots = self.iTotalValidPlots + 1;
		end
	end

	for iI = 1, iSize do
		row = {};
		row.ResourceIndex = self.aOtherType[iI];
		row.NumEntries = #self.aaPossibleLocs[iI];
		table.insert (self.aResourcePlacementOrder, row);
	end

	table.sort (self.aResourcePlacementOrder, function(a, b) return a.NumEntries < b.NumEntries; end);

    for i, row in ipairs(self.aOtherType) do
		self.iFrequencyTotal = self.iFrequencyTotal + self.iFrequency[row];
	end

	--print ("Total frequency: " .. tostring(self.iFrequencyTotal));

	-- Compute how many of each resource to place
	self.iOccurencesPerFrequency = (self.iTargetPercentage / 100 ) * self.iTotalValidPlots * (100 - self.iStrategicPercentage - self.iLuxuryPercentage) / 100 / self.iFrequencyTotal;

	--print ("Occurrences per frequency: " .. tostring(self.iOccurencesPerFrequency));

	self:__PlaceOtherResources();
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__PlaceOtherResources()

    for i, row in ipairs(self.aResourcePlacementOrder) do

		local eResourceType = self.eResourceType[row.ResourceIndex]

		local iNumToPlace;

		-- Compute how many to place
		iNumToPlace = self.iOccurencesPerFrequency * self.iFrequency[row.ResourceIndex];
	
		-- Score possible locations
		self:__ScorePlots(row.ResourceIndex);
	
		-- Sort and take best score
		table.sort (self.aaPossibleLocs[row.ResourceIndex], function(a, b) return a.Score > b.Score; end);

		for iI = 1, iNumToPlace do
			if (iI <= #self.aaPossibleLocs[row.ResourceIndex]) then
				local iMapIndex = self.aaPossibleLocs[row.ResourceIndex][iI].MapIndex;
				local iScore = self.aaPossibleLocs[row.ResourceIndex][iI].Score;

					-- Place at this location
				local pPlot = Map.GetPlotByIndex(iMapIndex);
				ResourceBuilder.SetResourceType(pPlot, eResourceType, 1);
--				print ("   Placed at (" .. tostring(pPlot:GetX()) .. ", " .. tostring(pPlot:GetY()) .. ") with score of " .. tostring(iScore));
			end
		end
	end
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__ScorePlots(iResourceIndex)

	local iW, iH;
	iW, iH = Map.GetGridSize();

	-- Clear all earlier entries (some might not be valid if resources have been placed
	for k, v in pairs(self.aaPossibleLocs[iResourceIndex]) do
		self.aaPossibleLocs[iResourceIndex][k] = nil;
	end

	for x = 0, iW - 1 do
		for y = 0, iH - 1 do
			local i = y * iW + x;
			local pPlot = Map.GetPlotByIndex(i);
			if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[iResourceIndex])) then
				row = {};
				row.MapIndex = i;
				row.Score = 500;
				row.Score = row.Score / ((ResourceBuilder.GetAdjacentResourceCount(pPlot) + 1) * 1.1);
				row.Score = row.Score + TerrainBuilder.GetRandomNumber(100, "Resource Placement Score Adjust");
				table.insert (self.aaPossibleLocs[iResourceIndex], row);
			end
		end
	end
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__GetWaterOtherResources()
	self.aOtherTypeWater = {};
	-- Find the other resources
    for row = 0, self.iResourcesInDB do
		local index  =self.aIndex[row];
		if (self.eResourceClassType[index] ~= nil) then
			if (self.eResourceClassType[index] ~= "RESOURCECLASS_STRATEGIC" and self.eResourceClassType[index] ~= "RESOURCECLASS_LUXURY" and self.eResourceClassType[index] ~= "RESOURCECLASS_ARTIFACT") then
				if(self.iSeaFrequency[index] > 0) then
					table.insert(self.aOtherTypeWater, index);
				end
			end
		end
	end

	-- Shuffle the table
	self.aOtherTypeWater = GetShuffledCopyOfTable(self.aOtherTypeWater);

	local iW, iH;
	iW, iH = Map.GetGridSize();

	local iBaseScore = 1;
	self.iTotalValidPlots = 0;
	local iSize = #self.aOtherTypeWater;
	local iPlotCount = Map.GetPlotCount();
	for i = 0, iPlotCount - 1 do
		local pPlot = Map.GetPlotByIndex(i);
		local bCanHaveSomeResource = false;

		-- See which resources can appear here
		for iI = 1, iSize do
			if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[self.aOtherTypeWater[iI]])) then
				row = {};
				row.MapIndex = i;
				row.Score = iBaseScore;
				table.insert (self.aaPossibleWaterLocs[self.aOtherTypeWater[iI]], row);
				bCanHaveSomeResource = true;
			end
		end

		if (bCanHaveSomeResource == true) then
			self.iTotalValidPlots = self.iTotalValidPlots + 1;
		end
	end

	for iI = 1, iSize do
		row = {};
		row.ResourceIndex = self.aOtherTypeWater[iI];
		row.NumEntries = #self.aaPossibleWaterLocs[iI];
		table.insert (self.aWaterResourcePlacementOrder, row);
	end

	table.sort (self.aWaterResourcePlacementOrder, function(a, b) return a.NumEntries < b.NumEntries; end);
	self.iFrequencyTotalWater = 0;

    for i, row in ipairs(self.aOtherTypeWater) do
		self.iFrequencyTotalWater = self.iFrequencyTotalWater + self.iSeaFrequency[row];
	end

	--print ("Total frequency: " .. tostring(self.iFrequencyTotalWater));

	-- Compute how many of each resource to place
	self.iOccurencesPerFrequency = (self.iTargetPercentage / 100 ) * self.iTotalValidPlots * (100 - self.iStrategicPercentage - self.iLuxuryPercentage) / 100 / self.iFrequencyTotalWater * self.iWaterBonus;

	--print ("Occurrences per frequency: " .. tostring(self.iOccurencesPerFrequency));

	self:__PlaceWaterOtherResources();
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__PlaceWaterOtherResources()

    for i, row in ipairs(self.aWaterResourcePlacementOrder) do

		local eResourceType = self.eResourceType[row.ResourceIndex]

		local iNumToPlace;

		-- Compute how many to place
		iNumToPlace = self.iOccurencesPerFrequency * self.iSeaFrequency[row.ResourceIndex];
	
		-- Score possible locations
		self:__ScoreWaterPlots(row.ResourceIndex);
	
		-- Sort and take best score
		table.sort (self.aaPossibleWaterLocs[row.ResourceIndex], function(a, b) return a.Score > b.Score; end);

		for iI = 1, iNumToPlace do
			if (iI <= #self.aaPossibleWaterLocs[row.ResourceIndex]) then
				local iMapIndex = self.aaPossibleWaterLocs[row.ResourceIndex][iI].MapIndex;
				local iScore = self.aaPossibleWaterLocs[row.ResourceIndex][iI].Score;

					-- Place at this location
				local pPlot = Map.GetPlotByIndex(iMapIndex);
				ResourceBuilder.SetResourceType(pPlot, eResourceType, 1);
--				print ("   Placed at (" .. tostring(pPlot:GetX()) .. ", " .. tostring(pPlot:GetY()) .. ") with score of " .. tostring(iScore));
			end
		end
	end
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__ScoreWaterPlots(iResourceIndex)

	local iW, iH;
	iW, iH = Map.GetGridSize();

	-- Clear all earlier entries (some might not be valid if resources have been placed
	for k, v in pairs(self.aaPossibleWaterLocs[iResourceIndex]) do
		self.aaPossibleWaterLocs[iResourceIndex][k] = nil;
	end

	for x = 0, iW - 1 do
		for y = 0, iH - 1 do
			local i = y * iW + x;
			local pPlot = Map.GetPlotByIndex(i);
			if (ResourceBuilder.CanHaveResource(pPlot, self.eResourceType[iResourceIndex])) then
				row = {};
				row.MapIndex = i;
				row.Score = 500;
				row.Score = row.Score / ((ResourceBuilder.GetAdjacentResourceCount(pPlot) + 1) * 1.1);
				row.Score = row.Score + TerrainBuilder.GetRandomNumber(100, "Resource Placement Score Adjust");
				table.insert (self.aaPossibleWaterLocs[iResourceIndex], row);
			end
		end
	end
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__RemoveOtherDuplicateResources()

	local iW, iH;
	iW, iH = Map.GetGridSize();

	for x = 0, iW - 1 do
		for y = 0, iH - 1 do
			local i = y * iW + x;
			local pPlot = Map.GetPlotByIndex(i);
			if(pPlot:GetResourceCount() > 0) then
				for row = 0, self.iResourcesInDB do
					local index = self.aIndex[row];
					
					if (self.eResourceClassType[index] ~= "RESOURCECLASS_STRATEGIC" and self.eResourceClassType[index] ~= "RESOURCECLASS_LUXURY" and self.eResourceClassType[index] ~= "RESOURCECLASS_ARTIFACT") then
						if(self.eResourceType[index]  == pPlot:GetResourceTypeHash()) then
							local bRemove = self:__RemoveDuplicateResources(pPlot, self.eResourceType[index]);
							if(bRemove == true) then
								ResourceBuilder.SetResourceType(pPlot, -1);
							end
						end
					end		
				end
			end
		end
	end
end
------------------------------------------------------------------------------
function ResourceGenerator_PTW_GiantEarth:__RemoveDuplicateResources(plot, eResourceType)
	local iCount = 0;
	
	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		local adjacentPlot = Map.GetAdjacentPlot(plot:GetX(), plot:GetY(), direction);
		if (adjacentPlot ~= nil) then
			if(adjacentPlot:GetResourceCount() > 0) then
				if(adjacentPlot:GetResourceTypeHash() == eResourceType) then
					iCount = iCount + 1;
				end
			end
		end
	end

	if(iCount >= 2) then
		return true;
	else
		return false;
	end
end
