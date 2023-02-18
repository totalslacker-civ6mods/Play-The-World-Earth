-- ===========================================================================
--	Map Label Manager
--	Controls all the perspective-rendered labels on the map
--	Includes Custom Map Labels for Play The World (Earth 128*80) by totalslacker
-- ===========================================================================
include( "InstanceManager" );
include( "SupportFunctions" );
include( "Civ6Common" );
include( "CustomMapLabels_Earth128x80" );
include( "CustomMapLabels_EqualAreaEarth" );
include( "CustomMapLabels_GiantEarth" );

local mapName		= MapConfiguration.GetValue("MapName");
local bCustomLabels	= MapConfiguration.GetValue("CustomLabels");
local bScotland		= MapConfiguration.GetValue("Scotland");
local bExtraLabels	= true;
local bRivers		= true;

-- ===========================================================================
local HEX_WIDTH         = 64.0;
local POI_OFFSET_Y      = -1 * HEX_WIDTH / 6; -- bottom third
local RELIGION_OFFSET_Y = -1 * HEX_WIDTH / 2;

local CLASS_MOUNTAIN = GameInfo.TerrainClasses["TERRAIN_CLASS_MOUNTAIN"].Index;
local CLASS_DESERT   = GameInfo.TerrainClasses["TERRAIN_CLASS_DESERT"].Index;
local CLASS_WATER    = GameInfo.TerrainClasses["TERRAIN_CLASS_WATER"].Index;

local NATURAL_WONDER_LAYER_HASH = UILens.CreateLensLayerHash("MapLabels_NaturalWonders");
local NATIONAL_PARK_LAYER_HASH  = UILens.CreateLensLayerHash("MapLabels_NationalParks");
local RELIGION_LAYER_HASH       = UILens.CreateLensLayerHash("Hex_Coloring_Religion");

local ColorSet_Main = {
	PrimaryColor   = UI.GetColorValue("COLOR_MAP_LABEL_FILL");
	SecondaryColor = UI.GetColorValue("COLOR_MAP_LABEL_STROKE");
}

local ColorSet_FOW = {
	PrimaryColor   = UI.GetColorValue("COLOR_MAP_LABEL_FILL_FOW");
	SecondaryColor = UI.GetColorValue("COLOR_MAP_LABEL_STROKE_FOW");
}

-- ===========================================================================
local m_TerritoryCache  = { };

local m_LabelManagerMap = { };

local m_TerritoryTracker = { };
local m_RiverTracker     = { };
local m_WonderTracker    = { };

local m_bUpdateNaturalWonderLabels : boolean = false;
local m_bUpdateNationalParkLabels : boolean = false;

local FontParams_MajorRegion = {
	FontSize       = 24.0,
	Kerning        = 4.0,
	WrapMode       = "Wrap",
	TargetWidth    = 3 * HEX_WIDTH,
	Alignment      = "Center",
	ColorSet       = ColorSet_Main,
	FOWColorSet    = ColorSet_Main, -- Major Regions don't use the FOW color
	FontStyle      = "Stroke",
	-- Centered on single, center-most hex
	-- Word wrap at 4 hexes
	-- Vertically centered on hex
	-- If possible, display text label on center of "largest" region of hexes
};

local FontParams_Religion = {
	FontSize       = 18.0,
	Kerning        = 4.0,
	WrapMode       = "Wrap",
	TargetWidth    = 3 * HEX_WIDTH,
	Alignment      = "Center",
	ColorSet       = ColorSet_Main,
	FOWColorSet    = ColorSet_Main, -- Religions don't use the FOW color
	FontStyle      = "Stroke",
	-- Centered on single, center-most hex
	-- Word wrap at 4 hexes
	-- Vertically centered on hex
	-- If possible, display text label on center of "largest" region of hexes
};

-- Same behavior as Major Regions, with smaller text
local FontParams_MinorRegion = {
	FontSize       = 12.0,
	Leading        = 12.0,
	Kerning        = 5.33,
	WrapMode       = "Wrap",
	TargetWidth    = 2 * HEX_WIDTH,
	Alignment      = "Center",
	ColorSet       = ColorSet_Main,
	FOWColorSet    = ColorSet_FOW,
	FontStyle      = "Stroke",
	-- Same behavior as Major Regions, with smaller text
};

local FontParams_River = {
	FontSize       = 12.0,
	Kerning        = 4.0,
	WrapMode       = "Truncate",
	Alignment      = "Center",
	ColorSet       = ColorSet_Main,
	FOWColorSet    = ColorSet_FOW,
	FontStyle      = "Stroke",
	-- Text bent for easy differentiation from adjacent feature labels
    -- Use up bend style if river arcs up. If not possible, choice of whether to use up or down bend can be random.
    -- Vertically centered within middle 1/2 of a hex
    -- Truncate Text (with...)  at 4 hexes wide
    -- Full name visible in tooltip (won't occur with current river names)
	-- Omit "River" from name at this time
	-- Minion Semibold Italic
	-- Same text size as unbent "Region Minor" styles
};

local FontParams_PointOfInterest = {
	FontSize       = 7.0,
	Leading        = 7.0,
	Kerning        = 5.0,
	WrapMode       = "Wrap",
	TargetWidth    = HEX_WIDTH,
	Alignment      = "Center",
	ColorSet       = ColorSet_Main,
	FOWColorSet    = ColorSet_FOW,
	FontStyle      = "Stroke",
--  Centered on single, center-most hex
--  Vertically centered within bottom 1/2 of a hex (aligns center on word wrap)
--  Word wrap two hexes wide
--  Myriad semibold
};

--TODO:
--Set up permission masks in artdef
--Default certain layers on
--Implement following layers:
--  Mountain Ranges
--  Rivers (curved)
--  Deserts

--  Government Names
--  Empire Names
--  City Names

-- ===========================================================================
function CreateLabelManager(szLensLayer, szOverlayName, pRebuildFunction, pUpdateFunction, szFontStyle)
	local pOverlayInstance = UILens.GetOverlay(szOverlayName);
	if (pOverlayInstance ~= nil) then
		local szFontFamily = UIManager:GetFontFamilyFromStyle(szFontStyle);
		pOverlayInstance:SetFontFamily(szFontFamily);
	end

	local pManager = {
		m_szOverlayName   = szOverlayName;
		m_szFontStyle     = szFontStyle;
		m_OverlayInstance = pOverlayInstance;
		m_RebuildFunction = pRebuildFunction;
		m_UpdateFunction  = pUpdateFunction;
	};

	local nLayerHash = UILens.CreateLensLayerHash(szLensLayer);
	m_LabelManagerMap[nLayerHash] = pManager;
	return pManager;
end

-- ===========================================================================
-- TODO make an exposure to get all natural wonders instead of this function
local m_NaturalWonderPlots = { };
function FindNaturalWonders()
	m_NaturalWonderPlots = { }
	local nPlots = Map.GetPlotCount();
	for i = 0,nPlots-1 do
		local pPlot = Map.GetPlotByIndex(i);
		if (pPlot ~= nil and pPlot:IsNaturalWonder()) then
			local pFeature = pPlot:GetFeature();
			local pFeaturePlots = pFeature:GetPlots();
			m_NaturalWonderPlots[pFeaturePlots[1]] = pFeature;
		end
	end
end

-- ===========================================================================
--	Play The World (Earth 128*80) Real Map Labels by totalslacker
-- ===========================================================================
function CreateMapLabel_Earth128x80 (szName, pOverlay, x, y)
	if szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ANDES_NAME")) then
		pOverlay:CreateTextAtPos(szName, (x+75), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ARABIAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+128), y, FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_RED_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-320), (y-192), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_SUEZ_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-592), (y+228), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_OMAN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+64), (y+164), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_PERSIAN_GULF_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-160), (y+292), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_ADEN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-128), (y-128), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ARAL_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_ARABIAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_BAIKAL_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+50), (y+50), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"))) then
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_FINLAND_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+384), (y+40), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-224), (y+64), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+256), (y-16), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GDANSK_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+256), (y-160), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_POMERANIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y-128), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_BOTHNIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+352), (y+272), FontParams_PointOfInterest);
		else
			pOverlay:CreateTextAtPos(szName, (x+100), y, FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BANDA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+96), (y+128), FontParams_PointOfInterest);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ARAFURA_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CELEBES_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y+448), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CERAM_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+80), (y+240), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_FLORES_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-96), (y+64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_JAWA_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-320), (y+156), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_JOSEPH_BONAPARTE_GULF_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y-192), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MOLUCCA_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-32), (y+288), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_TIMOR_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y-64), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BENGAL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+128), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ANDAMAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y-128), FontParams_MinorRegion);
		end
	-- elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BISCAY_NAME"))) then
		-- pOverlay:CreateTextAtPos(szName, x, (y-64), FontParams_MinorRegion);
		-- if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CELTIC_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-192), (y+256), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ENGLISH_CHANNEL_NAME"));
			-- pOverlay:CreateTextAtPos(szName, x, (y+256), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_IRISH_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, x, (y+400), FontParams_PointOfInterest);
		-- end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BLACK_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CARIBBEAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-64), (y+64), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_PANAMA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-288), (y-288), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_COAST_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+50), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_DAL_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GREAT_BASIN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+100), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_MEXICO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-32), (y+64), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_CAMPECHE_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-128), (y-75), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_HONDURAS_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y-128), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_TEHUANTEPEC_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-192), (y-320), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CALIFORNIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-544), (y-96), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SAN_FRANCISCO_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-968), (y+484), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_NIANGAY_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_HANN_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-192), (y-64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_YOF_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-224), (y+64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_ARGUIN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-224), (y+192), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SANGAREYA_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-128), (y-224), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_GUINEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+384), (y-384), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_SEA_OF_GALILEE_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREENLAND_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+96), (y+256), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_THE_HEBRIDES_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+64), (y-64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_THE_MINCH_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MORAY_FIRTH_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+352), (y+160), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_IRISH_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+172), (y-288), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ENGLISH_CHANNEL_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+256), (y-448), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CELTIC_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+64), (y-480), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BISCAY_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+64), (y-768), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_THAILAND_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HIMALAYAS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-40), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_HUDSON_BAY_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-75), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_HULUN_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KARAKUM_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_KARA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KHANGAI_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+32), (y-32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_KHOVSGOL_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ADAPASKAW_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALAKOL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALBERT_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ERIE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KHANKA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_LADOGA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LAKE_MARACAIBO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_OF_THE_WOODS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ONTARIO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_SUPERIOR_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+48), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TAHOE_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TEXCOCO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TITIQAQA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TURKANA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_VAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_WINNIPEG_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MEDITERRANEAN_SEA_NAME"))) then
		if bExtraLabels then
			--Big Mediterranean Label
			pOverlay:CreateTextAtPos(szName, (x), (y+128), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ADRIATIC_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+256), (y+128), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_AEGEAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+480), (y+32), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ALBORAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-368), (y-32), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CADIZ_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-576), (y-64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_GABES_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-48), (y-136), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_VALENCIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-256), (y+64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LEVANTINE_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+448), (y-136), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LIBYAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+288), (y-120), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LIGURIAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y+256), FontParams_PointOfInterest);
		else
			pOverlay:CreateTextAtPos(szName, (x+200), (y-30), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_MACKENZIE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-15), (y+15), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MOZAMBIQUE_CHANNEL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+100), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_PANGONG_TSO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_POYANG_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_QINGHAI_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_SAHARA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+96), y, FontParams_MinorRegion);
		
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SARGASSO_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y-64), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CHESAPEAKE_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y+64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MASSACHUSETTS_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x), (y+192), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_FUNDY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+96), (y+320), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_JAPAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), y, FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BO_HAI_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-416), (y-32), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_KOREA_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-336), (y-96), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_YELLOW_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-336), (y-184), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_EAST_CHINA_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-256), (y-320), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SCOTIA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-100), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SOUTH_CHINA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_TONKIN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y+156), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_STANOVOY_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+20), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SULU_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-400), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_THAR_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+204), (y-16), FontParams_PointOfInterest);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_DASHT_E_MARGO_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-32), (y+64), FontParams_MinorRegion);
		end		
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_VANERN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_WEST_NUBIAN_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos("LAKE CHAD", x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_WHITE_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-128), (y-200), FontParams_MinorRegion);
	else
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	end
end

-- ===========================================================================
--	Play The World (Equal Area Earth) Real Map Labels by totalslacker
-- ===========================================================================

function CreateMapLabel_EqualAreaEarth(szName, pOverlay, x, y)
	if szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ANDES_NAME")) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALASKAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ARAL_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_ARABIAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y-160), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ARABIAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+192), (y-128), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_RED_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-192), (y-288), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_OMAN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y+180), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_PERSIAN_GULF_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-80), (y+224), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_ADEN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y-256), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALTAI_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-64), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ATLAS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_BAIKAL_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), (y+32), FontParams_MinorRegion);
	-- elseif(szName == "BALTIC SEA") then
		-- if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_FINLAND_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+448), (y+16), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-64), (y+64), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+352), (y-64), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_POMERANIA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+256), (y-96), FontParams_MinorRegion);
		-- else
			-- pOverlay:CreateTextAtPos(szName, (x+100), y, FontParams_MinorRegion);
		-- end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BANDA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y+80), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ARAFURA_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y-64), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CELEBES_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-96), (y+480), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CERAM_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+64), (y+192), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_FLORES_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-96), (y+80), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_JAWA_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-320), (y+140), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_JOSEPH_BONAPARTE_GULF_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-128), (y-256), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MOLUCCA_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-32), (y+288), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_TIMOR_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y-128), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BENGAL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-32), (y+192), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ANDAMAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y-160), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BISCAY_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-32), (y-32), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CELTIC_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-192), y, FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ENGLISH_CHANNEL_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+96), (y+48), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BLACK_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-16), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CASPIAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CARIBBEAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), y, FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_PANAMA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-160), (y-384), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_COAST_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+50), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CORAL_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CARPENTARIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-384), (y-32), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BOTANY_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+96), (y-640), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_DAL_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_EAST_CHINA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-128), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BO_HAI_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-160), (y+256), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_KOREA_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y+192), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_YELLOW_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, x, (y+32), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GIBSON_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GOBI_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GREAT_BASIN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+80), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GREAT_VICTORIA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-64), (y-64), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREAT_AUSTRALIAN_BIGHT_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-64), (y-256), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CALIFORNIA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y-192), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SAN_FRANCISCO_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-352), (y+416), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_ALASKA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-768), (y+832), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_MEXICO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-32), (y+48), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_CAMPECHE_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-96), (y-128), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_HONDURAS_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+160), (y-192), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_TEHUANTEPEC_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-192), (y-416), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_SAINT_LAWRENCE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), (y-288), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LABRADOR_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HIMALAYAS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-64), FontParams_Religion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HINDU_KUSH_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_HUDSON_BAY_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+320), (y-128), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_HULUN_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ISSYK_KUL_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KALAHARI_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+96), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KARAKUM_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_KHOVSGOL_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KUNLUN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALAKOL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALBERT_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ADAPASKAW_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_BALKHASH_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+16), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ERIE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KHANKA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KIVU_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_LADOGA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_OF_THE_WOODS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_NIANGAY_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_HANN_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-164), (y-64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_YOF_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-164), (y+64), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_ARGUIN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-164), (y+192), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SANGAREYA_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-128), (y-320), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_GUINEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+384), (y-512), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ONTARIO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_SUPERIOR_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+16), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TAHOE_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TEXCOCO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TITIQAQA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TURKANA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_VAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_WINNIPEG_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MEDITERRANEAN_SEA_NAME"))) then
		if bExtraLabels then
			--Big Mediterranean Label
			pOverlay:CreateTextAtPos(szName, (x+128), (y+32), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ADRIATIC_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+312), (y+96), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_AEGEAN_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+256), (y+32), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ALBORAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-292), (y+32), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CADIZ_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-480), (y+32), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_GABES_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+160), (y-136), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_VALENCIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-164), (y+128), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LEVANTINE_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+544), (y-32), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LIBYAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+240), (y-80), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LIGURIAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-16), (y+208), FontParams_PointOfInterest);
		else
			pOverlay:CreateTextAtPos(szName, (x+200), (y-30), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_MACKENZIE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-15), (y+15), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORWEGIAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-128), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_PANGONG_TSO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MOZAMBIQUE_CHANNEL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREENLAND_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+96), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_THE_HEBRIDES_NAME"));
			pOverlay:CreateTextAtPos(szName, x, (y-128), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"))) then
		if bScotland then
			pOverlay:CreateTextAtPos(szName, (x-128), (y+32), FontParams_MinorRegion);
			if bExtraLabels then
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
				pOverlay:CreateTextAtPos(szName, (x+256), (y-80), FontParams_MinorRegion);
			end		
		else
			pOverlay:CreateTextAtPos(szName, (x+64), (y-128), FontParams_MinorRegion);
			if bExtraLabels then
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_THE_HEBRIDES_NAME"));
				pOverlay:CreateTextAtPos(szName, (x-320), (y-96), FontParams_MinorRegion);
				-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MORAY_FIRTH_NAME"));
				-- pOverlay:CreateTextAtPos(szName, (x-128), (y-64), FontParams_MinorRegion);
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
				pOverlay:CreateTextAtPos(szName, (x+384), (y-224), FontParams_MinorRegion);
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORWEGIAN_SEA_NAME"));
				pOverlay:CreateTextAtPos(szName, (x+64), (y+128), FontParams_MinorRegion);
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREENLAND_SEA_NAME"));
				pOverlay:CreateTextAtPos(szName, (x-256), (y+128), FontParams_MinorRegion);
			end		
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_PACARAIMA_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_POYANG_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_QINGHAI_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_REGISTAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-80), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_SAHARA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), y, FontParams_Religion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SARGASSO_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y-64), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CHESAPEAKE_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x), (y+128), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MASSACHUSETTS_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+96), (y+288), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_FUNDY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y+448), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_SEA_OF_GALILEE_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_JAPAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-32), (y-64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_OKHOTSK_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_SAYAN_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SCOTIA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SOUTH_CHINA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y+192), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_THAILAND_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-164), (y-64), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SULU_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+160), (y-64), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_STANOVOY_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+20), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SULU_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-400), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_TAKLAMAKAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-64), (y-32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_THAR_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+80), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_TIEN_SHAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y+16), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_UTIKUMA_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_WEST_NUBIAN_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_KARA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-16), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_WHITE_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-448), (y-128), FontParams_MinorRegion);
		end
	else
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	end
end

-- ===========================================================================
--	Play The World (Giant Earth) Real Map Labels by totalslacker
-- ===========================================================================

function CreateMapLabel_PTW_GiantEarth(szName, pOverlay, x, y)
	if szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ANDES_NAME")) then
		pOverlay:CreateTextAtPos(szName, x, (y-64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALASKAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ARAL_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_ARABIAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ARABIAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+160), (y-128), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_OMAN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+64), (y-320), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_PERSIAN_GULF_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-32), (y+32), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_ADEN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-256), (y-512), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ALTAI_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-64), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_ATLAS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_BAIKAL_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), (y+32), FontParams_MinorRegion);
	-- elseif(szName == "BALTIC SEA") then
		-- if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_FINLAND_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+448), (y+16), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-64), (y+64), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+352), (y-64), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_POMERANIA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+256), (y-96), FontParams_MinorRegion);
		-- else
			-- pOverlay:CreateTextAtPos(szName, (x+100), y, FontParams_MinorRegion);
		-- end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"))) then
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_FINLAND_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+320), (y+96), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-224), (y+64), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+160), (y+32), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GDANSK_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y-228), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_POMERANIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-128), (y-224), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_BOTHNIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+192), (y+416), FontParams_PointOfInterest);
		else
			pOverlay:CreateTextAtPos(szName, (x+100), y, FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BANDA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ARAFURA_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+128), (y-64), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CELEBES_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-96), (y+480), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CERAM_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+64), (y+192), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_FLORES_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-96), (y+80), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_JAWA_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-320), (y+140), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_JOSEPH_BONAPARTE_GULF_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-128), (y-256), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MOLUCCA_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-32), (y+288), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_TIMOR_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-64), (y-128), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BENGAL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ANDAMAN_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+128), (y-160), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_BISCAY_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-32), (y+32), FontParams_MinorRegion);
		if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CELTIC_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-192), y, FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ENGLISH_CHANNEL_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+96), (y+48), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BLACK_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-16), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CASPIAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CARIBBEAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), y, FontParams_MinorRegion);
		if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_PANAMA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-160), (y-384), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_COAST_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+50), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CORAL_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CARPENTARIA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-384), (y-32), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BOTANY_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+96), (y-640), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_DAL_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_EAST_CHINA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y-128), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BO_HAI_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-256), (y+288), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_KOREA_BAY_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-96), (y+164), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_YELLOW_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-96), (y+64), FontParams_MinorRegion);
		end
	-- elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ENGLISH_CHANNEL_NAME"))) then
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GIBSON_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GOBI_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GREAT_BASIN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+80), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_GREAT_VICTORIA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-64), (y-64), FontParams_MinorRegion);
		if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREAT_AUSTRALIAN_BIGHT_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-64), (y-256), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CALIFORNIA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SAN_FRANCISCO_BAY_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-352), (y+416), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_ALASKA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-768), (y+832), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_MEXICO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-32), (y+16), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_CAMPECHE_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-160), (y-128), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_HONDURAS_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+160), (y-224), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_TEHUANTEPEC_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-192), (y-480), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_SAINT_LAWRENCE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), (y-288), FontParams_MinorRegion);
		if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LABRADOR_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HIMALAYAS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-64), FontParams_Religion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_HINDU_KUSH_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_HUDSON_BAY_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+320), (y-128), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_HULUN_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_ISSYK_KUL_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KALAHARI_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+96), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_KARAKUM_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_KHOVSGOL_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_KUNLUN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALAKOL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ALBERT_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ADAPASKAW_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_BALKHASH_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+16), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ERIE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KHANKA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_KIVU_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_LADOGA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_OF_THE_WOODS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_NIANGAY_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
		if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_HANN_BAY_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-164), (y-64), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_YOF_BAY_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-164), (y+64), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_ARGUIN_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-164), (y+192), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SANGAREYA_BAY_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-128), (y-320), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_GUINEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+384), (y-512), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_ONTARIO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_SUPERIOR_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+32), (y+48), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TAHOE_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TEXCOCO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TITIQAQA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_TURKANA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_URMIA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_VAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_LAKE_WINNIPEG_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MEDITERRANEAN_SEA_NAME"))) then
		if bExtraLabels then
			--Big Mediterranean Label
			pOverlay:CreateTextAtPos(szName, (x+128), (y+32), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ADRIATIC_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+312), (y+96), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_AEGEAN_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+256), (y+32), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_ALBORAN_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-292), (y+32), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_CADIZ_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-480), (y+32), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_GABES_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+160), (y-136), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_VALENCIA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-164), (y+128), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LEVANTINE_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+544), (y-32), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LIBYAN_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+240), (y-80), FontParams_PointOfInterest);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_LIGURIAN_SEA_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-16), (y+208), FontParams_PointOfInterest);
		else
			pOverlay:CreateTextAtPos(szName, (x+200), (y-30), FontParams_MinorRegion);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_MACKENZIE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-15), (y+15), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORWEGIAN_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-128), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_PANGONG_TSO_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MOZAMBIQUE_CHANNEL_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREENLAND_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y-64), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_THE_HEBRIDES_NAME"));
			pOverlay:CreateTextAtPos(szName, x, (y-448), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORTH_SEA_NAME"))) then
		if bScotland then
			pOverlay:CreateTextAtPos(szName, (x-128), (y+32), FontParams_MinorRegion);
			if bExtraLabels then
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
				pOverlay:CreateTextAtPos(szName, (x+256), (y-80), FontParams_MinorRegion);
			end		
		else
			pOverlay:CreateTextAtPos(szName, (x+64), (y-128), FontParams_MinorRegion);
			if bExtraLabels then
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_THE_HEBRIDES_NAME"));
				pOverlay:CreateTextAtPos(szName, (x-320), (y-96), FontParams_MinorRegion);
				-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MORAY_FIRTH_NAME"));
				-- pOverlay:CreateTextAtPos(szName, (x-128), (y-64), FontParams_MinorRegion);
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BALTIC_SEA_NAME"));
				pOverlay:CreateTextAtPos(szName, (x+384), (y-224), FontParams_MinorRegion);
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_NORWEGIAN_SEA_NAME"));
				pOverlay:CreateTextAtPos(szName, (x+64), (y+128), FontParams_MinorRegion);
				szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GREENLAND_SEA_NAME"));
				pOverlay:CreateTextAtPos(szName, (x-256), (y+128), FontParams_MinorRegion);
			end		
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_PACARAIMA_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_POYANG_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_QINGHAI_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_RED_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-128), (y-32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_REGISTAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-80), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_SAHARA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), y, FontParams_Religion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SARGASSO_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+32), (y-96), FontParams_MinorRegion);
		if bExtraLabels then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_CHESAPEAKE_BAY_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x-16), (y), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_MASSACHUSETTS_BAY_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+96), (y+288), FontParams_MinorRegion);
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_BAY_OF_FUNDY_NAME"));
			-- pOverlay:CreateTextAtPos(szName, (x+128), (y+448), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_SEA_OF_GALILEE_NAME"))) then
		print("Don't create text over natural wonder")
		-- pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_JAPAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-32), (y-64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SEA_OF_OKHOTSK_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_SAYAN_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+64), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SCOTIA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SOUTH_CHINA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), (y+128), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_THAILAND_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-464), (y-160), FontParams_PointOfInterest);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SULU_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x+160), (y-64), FontParams_MinorRegion);
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_GULF_OF_TONKIN_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-240), (y+256), FontParams_PointOfInterest);
		end
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_STANOVOY_MOUNTAINS_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y+20), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_SULU_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-400), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_TAKLAMAKAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x-64), (y-32), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_DESERT_THAR_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), y, FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_MOUNTAIN_TIEN_SHAN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x+64), (y+16), FontParams_MinorRegion);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_TONLE_SAP_NAME"))) then
		pOverlay:CreateTextAtPos(szName, (x), y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_UTIKUMA_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_VANERN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_VATTERN_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_LAKE_WEST_NUBIAN_LAKE_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_PointOfInterest);
	elseif(szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_KARA_SEA_NAME"))) then
		pOverlay:CreateTextAtPos(szName, x, (y-16), FontParams_MinorRegion);
		if bExtraLabels then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_SEA_WHITE_SEA_NAME"));
			pOverlay:CreateTextAtPos(szName, (x-448), (y-128), FontParams_MinorRegion);
		end
	else
		pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
	end
end

-- ===========================================================================
--	Modified Firaxis function
-- ===========================================================================
function AddTerritoryLabel(pOverlay, pTerritory)
	local eTerritory = pTerritory:GetID();
	if m_TerritoryTracker[eTerritory] == nil then
		local pInstance = m_TerritoryCache[eTerritory];
		if pInstance == nil then
			-- ERROR?
			return;
		end
	
		local pName = pTerritory:GetName();
		if (pName == nil) then
			return;
		end

		m_TerritoryTracker[eTerritory] = true;
		local szName = Locale.ToUpper(Locale.Lookup(pName));
		
		--totalslacker: Custom map labels for everything except rivers
		if bCustomLabels then
			if mapName == "Earth128x80" then
				-- print("Earth128x80 detected. Applying Real Map Labels for Earth 128*80 (Play The World)");
				szName = GetCustomMapLabel_Earth128x80(eTerritory, pTerritory, szName);			
			end
			if mapName == "EqualAreaEarth" then
				-- print("EqualAreaEarth detected. Applying Real Map Labels for Equal Area Earth (Play The World)");
				szName = GetCustomMapLabel_EqualAreaEarth(eTerritory, szName);
			end
			if mapName == "PTW_GiantEarth" then
				-- print("Giant Earth detected. Applying Real Map Labels for Giant Earth (Play The World)");
				szName = GetCustomMapLabel_PTW_GiantEarth(eTerritory, pTerritory, szName);	
			end
		end
		
		-- Special case for large bodies of water
		if pTerritory:GetTerrainClass() == CLASS_WATER then
			if (#pInstance.pPlots > 100) then
				-- try to have approximately one label per 100 hexes
				--totalslacker: Change Atlantic label to Indian Ocean label at halfway point (generating ice to separate the regions was causing crashes)
				if (mapName == "EqualAreaEarth") and (szName == Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_ATLANTIC_OCEAN_NAME"))) then
					local pPositions = UI.GetRegionClusterPositions( pInstance.pPlots, 100, 100 );
					if pPositions then
						for _,pos in pairs(pPositions) do
							print(szName .. " (" .. pos.x .. ", " .. pos.y .. ")");
							if pos.x > 128 and pos.y > -1700 then
								pOverlay:CreateTextAtPos(Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_INDIAN_OCEAN_NAME")), pos.x, pos.y, FontParams_MinorRegion);
							elseif(pos.y <= -1700) then
								pOverlay:CreateTextAtPos(Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_ANTARCTIC_OCEAN_NAME")), pos.x, pos.y, FontParams_MinorRegion);
							-- elseif(pos.x < -2000) then
								-- pOverlay:CreateTextAtPos(Locale.ToUpper(Locale.Lookup("LOC_NAMED_OCEAN_PACIFIC_OCEAN_NAME")), pos.x, pos.y, FontParams_MinorRegion);
							else
								pOverlay:CreateTextAtPos(szName, pos.x, pos.y, FontParams_MinorRegion);
							end
							
						end

						-- we broke it up into multiple labels, return
						-- otherwise we will fall back to generating a single label at the center
						return;
					end					
				else
					local pPositions = UI.GetRegionClusterPositions( pInstance.pPlots, 100, 100 );
					if pPositions then
						for _,pos in pairs(pPositions) do
							print(szName .. " (" .. pos.x .. ", " .. pos.y .. ")");
							pOverlay:CreateTextAtPos(szName, pos.x, pos.y, FontParams_MinorRegion);
						end

						-- we broke it up into multiple labels, return
						-- otherwise we will fall back to generating a single label at the center
						return;
					end
				end
			end
		end

		local x, y = UI.GetRegionCenter(pInstance.pPlots);
		
		if bCustomLabels then
			if ((mapName == "Earth128x80") or (mapName == "Earth128x80_Alt")) then
				CreateMapLabel_Earth128x80(szName, pOverlay, x, y);			
			elseif(mapName == "EqualAreaEarth") then
				CreateMapLabel_EqualAreaEarth(szName, pOverlay, x, y);	
			elseif(mapName == "PTW_GiantEarth") then
				CreateMapLabel_PTW_GiantEarth(szName, pOverlay, x, y);	
			else
				pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);	
			end
		else
			pOverlay:CreateTextAtPos(szName, x, y, FontParams_MinorRegion);
		end
	end
end

-- ===========================================================================
function UpdateTerritory(pOverlay, iPlotIndex, pTerritorySelector)
	local pTerritory = Territories.GetTerritoryAt(iPlotIndex);
	if pTerritory and pTerritorySelector(pTerritory) then
		AddTerritoryLabel(pOverlay, pTerritory);
	end
end

-- ===========================================================================
function RefreshTerritories(pOverlay, pTerritorySelector)
	pOverlay:ClearAll();
	m_TerritoryTracker = { };
	for eTerritory,pInstance in pairs(m_TerritoryCache) do
		local pTerritory = Territories.GetTerritory(eTerritory);
		if pTerritory and pTerritorySelector(pTerritory) then
			AddTerritoryLabel(pOverlay, pTerritory);
		end
	end
end

-- ===========================================================================
function RefreshNationalParks(pOverlay)
	local eLocalPlayer = Game.GetLocalPlayer(); 
	if eLocalPlayer == -1 then
		return;
	end

	local pLocalPlayerVis = PlayersVisibility[eLocalPlayer];
	local pNationalParks = Game.GetNationalParks():EnumerateNationalParks();

	pOverlay:ClearAll();
	for _,pNationalPark in pairs(pNationalParks) do
		if pLocalPlayerVis:IsRevealed(pNationalPark.Plots[1]) then
			local szName = Locale.ToUpper(pNationalPark.Name);
			local x, y = UI.GetRegionCenter(pNationalPark.Plots);
			pOverlay:CreateTextAtPos(szName, x, y + POI_OFFSET_Y, FontParams_PointOfInterest);
		end
	end
end

-- ===========================================================================
function UpdateNationalParks(pOverlay, iPlotIndex)
	if Game.GetNationalParks():IsNationalPark(iPlotIndex) then
		RefreshNationalParks(pOverlay);
	end
end

-- ===========================================================================
function AddNaturalWonderLabel(pOverlay, pFeature)
	local pFeaturePlots = pFeature:GetPlots();
	local eFeature = pFeature:GetType();
	--local szName = Definitions.GetTypeName(DefinitionTypes.FEATURE, eFeature);
	local info:table = GameInfo.Features[eFeature];
	local szName = Locale.ToUpper(Locale.Lookup(info.Name));
	
	-- hide natural wonder labels if there is a national park label visible at the same location
	-- the national park will be named after the natural wonder it was placed on, so it is redundant
	if UILens.IsLayerOn(NATIONAL_PARK_LAYER_HASH) then
		for _,iPlotIndex in pairs(pFeaturePlots) do
			if Game.GetNationalParks():IsNationalPark(iPlotIndex) then
				print("Omitting feature label: " .. szName);
				return;
			end
		end
	end

	if (m_WonderTracker[eFeature] == nil) then
		m_WonderTracker[eFeature] = true;
		local x, y = UI.GetRegionCenter(pFeaturePlots);
		pOverlay:CreateTextAtPos(szName, x, y + POI_OFFSET_Y, FontParams_PointOfInterest);
	end
end

-- ===========================================================================
function RefreshNaturalWonders(pOverlay)
	pOverlay:ClearAll();
	m_WonderTracker = { };
	for _,pFeature in pairs(m_NaturalWonderPlots) do
		AddNaturalWonderLabel(pOverlay, pFeature);
	end
end

-- ===========================================================================
function UpdateNaturalWonders(pOverlay, iPlotIndex)
	local pPlot = Map.GetPlotByIndex(iPlotIndex);
	if (pPlot ~= nil and pPlot:IsNaturalWonder()) then
		local pFeature = pPlot:GetFeature();
		AddNaturalWonderLabel(pOverlay, pFeature);
	end
end

-- ===========================================================================
--	Play The World - Real River Labels by totalslacker
-- ===========================================================================

function CreateRiverLabel(pOverlay, pRiver, szName)
	local fLength = pOverlay:GetTextLength(szName, FontParams_River);
	local pSegments = UI.CalculateEdgeSplineSegments(pRiver.Edges, 5, 10, 3, fLength);
	if pSegments ~= nil then
		for _,pSegment in pairs(pSegments) do
			pOverlay:CreateTextArc(szName, pSegment, FontParams_River);
		end
	end	
end

-- ===========================================================================
-- Earth128x80 Rivers
-- ===========================================================================

function GetCustomRiverLabel_Earth128x80(pOverlay, pRiver, szName)
	local bUppercase = true;
	local eRiverName;
	local riverPlot;
	--Amazon
	riverPlot = Map.GetPlot(44,33)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_AMAZON_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_AMAZON_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Amur
	riverPlot = Map.GetPlot(110,60)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_AMUR_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_AMUR_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Amu Darya
	riverPlot = Map.GetPlot(86,56)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_AMU_DARYA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_AMU_DARYA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Colorado
	riverPlot = Map.GetPlot(24,54)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_COLORADO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_COLORADO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Congo
	riverPlot = Map.GetPlot(69,32)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_CONGO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_CONGO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Columbia
	riverPlot = Map.GetPlot(21,59)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_COLUMBIA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_COLUMBIA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Dal
	riverPlot = Map.GetPlot(69,73)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DAL_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DAL_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Darling
	riverPlot = Map.GetPlot(115,18)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DARLING_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DARLING_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Danube
	riverPlot = Map.GetPlot(71,60)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DANUBE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DANUBE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Daugava (river too short)
	riverPlot = Map.GetPlot(74,67)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DAUGAVA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DAUGAVA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Dneiper
	riverPlot = Map.GetPlot(76,62)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DNIEPER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DNIEPER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Dneister
	riverPlot = Map.GetPlot(74,61)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DNIESTER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DNIESTER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Don
	riverPlot = Map.GetPlot(79,62)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DON_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DON_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Douro
	riverPlot = Map.GetPlot(58,56)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DOURO_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DOURO_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Ebro
	riverPlot = Map.GetPlot(61,57)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_EBRO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_EBRO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Elbe
	riverPlot = Map.GetPlot(67,65)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ELBE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ELBE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Euphrates
	riverPlot = Map.GetPlot(79,51)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_EUPHRATES_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_EUPHRATES_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Fraser
	riverPlot = Map.GetPlot(20,61)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_FRASER_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_FRASER_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Ganges
	riverPlot = Map.GetPlot(95,47)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_GANGES_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_GANGES_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Godavari
	riverPlot = Map.GetPlot(92,44)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_GODAVARI_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_GODAVARI_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Guadalcavir
	riverPlot = Map.GetPlot(59,53)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("GUADALQUIVER"));	
		else
			szName = Locale.Lookup("Guadalcavir");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Indus
	riverPlot = Map.GetPlot(89,50)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_INDUS_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_INDUS_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Irrawaddy
	riverPlot = Map.GetPlot(98,44)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_IRRAWADDY_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_IRRAWADDY_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Kaveri
	riverPlot = Map.GetPlot(92,42)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_KAVERI_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_KAVERI_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Lena
	riverPlot = Map.GetPlot(109,67)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_LENA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_LENA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Limpopo
	riverPlot = Map.GetPlot(75,21)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	-- print("pRiver equals "..tostring(pRiver.TypeID))
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_LIMPOPO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_LIMPOPO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Loire
	riverPlot = Map.GetPlot(62,61)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	-- print("pRiver equals "..tostring(pRiver.TypeID))
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_LOIRE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_LOIRE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Mackenzie
	riverPlot = Map.GetPlot(18,69)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_MACKENZIE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_MACKENZIE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Mekong
	riverPlot = Map.GetPlot(101,42)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_MEKONG_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_MEKONG_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Mississippi
	riverPlot = Map.GetPlot(31,54)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_MISSISSIPPI_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_MISSISSIPPI_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Narmada (doesn't work?)
	riverPlot = Map.GetPlot(90,46)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_NARMADA_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_NARMADA_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Niger
	riverPlot = Map.GetPlot(63,42)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_NIGER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_NIGER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Nile
	riverPlot = Map.GetPlot(74,47)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_NILE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_NILE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Northern Dvina
	riverPlot = Map.GetPlot(79,71)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_NORTHERN_DVINA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_NORTHERN_DVINA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Ob
	riverPlot = Map.GetPlot(91,61)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_OB_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_OB_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Oder
	riverPlot = Map.GetPlot(69,65)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ODER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ODER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Orange
	riverPlot = Map.GetPlot(72,17)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ORANGE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ORANGE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Orinoco
	riverPlot = Map.GetPlot(41,39)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ORINOCO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ORINOCO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Orkhon
	riverPlot = Map.GetPlot(101,60)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ORKHON_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ORKHON_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Paraguay
	riverPlot = Map.GetPlot(43,21)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_PARAGUAY_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_PARAGUAY_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Pearl
	riverPlot = Map.GetPlot(104,47)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_PEARL_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_PEARL_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Po River
	riverPlot = Map.GetPlot(66,59)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	-- print("pRiver equals "..tostring(pRiver.TypeID))
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_PO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_PO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Red (river label overlaps with Mekong)
	riverPlot = Map.GetPlot(101,46)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_RED_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_RED_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Rhine
	riverPlot = Map.GetPlot(64,65)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_RHINE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_RHINE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Rhone
	riverPlot = Map.GetPlot(64,58)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_RHONE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_RHONE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Rio Grande
	riverPlot = Map.GetPlot(26,52)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_RIO_GRANDE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_RIO_GRANDE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Saint Lawrence (name too long for river)
	-- riverPlot = Map.GetPlot(38,60)
	-- eRiverName = RiverManager.GetRiverName(riverPlot)
	-- if eRiverName == pRiver.Name then
		-- if bUppercase then
			-- szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SAINT_LAWRENCE_NAME"));	
		-- else
			-- szName = Locale.Lookup("LOC_NAMED_RIVER_SAINT_LAWRENCE_NAME");				
		-- end
		-- CreateRiverLabel(pOverlay, pRiver, szName);
	-- end	
	--Sao Francisco
	riverPlot = Map.GetPlot(48,29)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	-- print("pRiver equals "..tostring(pRiver.TypeID))
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SAO_FRANCISCO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SAO_FRANCISCO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Seine
	riverPlot = Map.GetPlot(63,64)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SEINE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SEINE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Senegal
	riverPlot = Map.GetPlot(59,42)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SENEGAL_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SENEGAL_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--St Lawrence
	riverPlot = Map.GetPlot(37,59)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("Saint Lawrence"));	
		else
			szName = Locale.Lookup("Saint Lawrence");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Syr Darya
	riverPlot = Map.GetPlot(87,59)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SYR_DARYA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SYR_DARYA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Tagus
	riverPlot = Map.GetPlot(59,55)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_TAGUS_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_TAGUS_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Thames
	riverPlot = Map.GetPlot(63,68)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_THAMES_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_THAMES_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Tiber
	-- riverPlot = Map.GetPlot(68,54)
	-- eRiverName = RiverManager.GetRiverName(riverPlot)
	-- if eRiverName == pRiver.Name then
		-- if bUppercase then
			-- szName = Locale.ToUpper(Locale.Lookup("Tiber"));	
		-- else
			-- szName = Locale.Lookup("LOC_NAMED_RIVER_TIBER_NAME");				
		-- end
		-- CreateRiverLabel(pOverlay, pRiver, szName);
	-- end	
	--Tigris
	riverPlot = Map.GetPlot(81,51)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_TIGRIS_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_TIGRIS_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Tocantins
	riverPlot = Map.GetPlot(46,33)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_TOCANTINS_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_TOCANTINS_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Ural
	riverPlot = Map.GetPlot(83,63)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_URAL_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_URAL_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Vistula
	riverPlot = Map.GetPlot(71,65)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_VISTULA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_VISTULA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Volga
	riverPlot = Map.GetPlot(81,62)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_VOLGA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_VOLGA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Yangtze
	riverPlot = Map.GetPlot(106,50)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_YANGTZE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_YANGTZE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Yellow
	riverPlot = Map.GetPlot(105,55)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_YELLOW_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_YELLOW_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Yenesei
	riverPlot = Map.GetPlot(95,70)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_YENISEI_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_YENISEI_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Yukon
	riverPlot = Map.GetPlot(8,68)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_YUKON_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_YUKON_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Zambezi
	riverPlot = Map.GetPlot(72,23)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ZAMBEZI_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ZAMBEZI_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
end

-- ===========================================================================
--	Equal Area Earth Rivers
-- ===========================================================================

function GetCustomRiverLabel_EqualAreaEarth(pOverlay, pRiver, szName)
	local bUppercase = true;
	local eRiverName;
	local riverPlot;
	--Amazon
	riverPlot = Map.GetPlot(45,36)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_AMAZON_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_AMAZON_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Amu Darya
	riverPlot = Map.GetPlot(86,64)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_AMU_DARYA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_AMU_DARYA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Amur
	riverPlot = Map.GetPlot(110,69)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_AMUR_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_AMUR_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Colorado
	riverPlot = Map.GetPlot(24,63)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_COLORADO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_COLORADO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Columbia
	riverPlot = Map.GetPlot(22,67)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_COLUMBIA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_COLUMBIA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Danube
	riverPlot = Map.GetPlot(73,67)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DANUBE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DANUBE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Darling
	riverPlot = Map.GetPlot(115,15)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DARLING_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DARLING_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Daugava
	riverPlot = Map.GetPlot(72,72)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DAUGAVA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DAUGAVA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Dneiper
	riverPlot = Map.GetPlot(75,69)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DNIESTER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DNIESTER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Dneister
	riverPlot = Map.GetPlot(74,68)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DNIESTER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DNIESTER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Don
	riverPlot = Map.GetPlot(77,69)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_DON_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_DON_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Elbe
	riverPlot = Map.GetPlot(67,71)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ELBE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ELBE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Euphrates
	riverPlot = Map.GetPlot(79,57)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_EUPHRATES_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_EUPHRATES_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Fraser
	riverPlot = Map.GetPlot(20,70)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	-- print("pRiver equals "..tostring(pRiver.TypeID))
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_FRASER_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_FRASER_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Ganges
	riverPlot = Map.GetPlot(95,55)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_GANGES_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_GANGES_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Godavari
	riverPlot = Map.GetPlot(92,51)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_GODAVARI_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_GODAVARI_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Indus
	riverPlot = Map.GetPlot(89,59)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_INDUS_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_INDUS_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Irrawaddy
	riverPlot = Map.GetPlot(98,51)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_IRRAWADDY_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_IRRAWADDY_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Kongo	
	riverPlot = Map.GetPlot(69,31)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_CONGO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_CONGO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Kaveri (river too short)
	riverPlot = Map.GetPlot(92,44)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_KAVERI_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_KAVERI_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Lena
	riverPlot = Map.GetPlot(107,76)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_LENA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_LENA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Limpopo
	riverPlot = Map.GetPlot(76,20)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_LIMPOPO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_LIMPOPO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Loire
	riverPlot = Map.GetPlot(63,69)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	-- print("pRiver equals "..tostring(pRiver.TypeID))
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_LOIRE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_LOIRE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end		
	--Mackenzie
	riverPlot = Map.GetPlot(19,77)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_MACKENZIE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_MACKENZIE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Mekong
	riverPlot = Map.GetPlot(100,49)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_MEKONG_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_MEKONG_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Mississippi
	riverPlot = Map.GetPlot(30,64)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_MISSISSIPPI_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_MISSISSIPPI_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Narmada
	riverPlot = Map.GetPlot(91,54)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_NARMADA_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_NARMADA_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Niger
	riverPlot = Map.GetPlot(64,45)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_NIGER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_NIGER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Nile
	riverPlot = Map.GetPlot(74,52)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_NILE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_NILE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Northern Dvina
	riverPlot = Map.GetPlot(76,74)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	-- print("pRiver equals "..tostring(pRiver.TypeID))
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_NORTHERN_DVINA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_NORTHERN_DVINA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Ob
	riverPlot = Map.GetPlot(91,61)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_OB_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_OB_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Oder
	riverPlot = Map.GetPlot(69,71)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ODER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ODER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Orange
	riverPlot = Map.GetPlot(73,17)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ORANGE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ORANGE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Orinoco
	riverPlot = Map.GetPlot(39,42)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ORINOCO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ORINOCO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Orkhon
	riverPlot = Map.GetPlot(102,70)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ORKHON_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ORKHON_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Paraguay
	riverPlot = Map.GetPlot(43,21)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_PARAGUAY_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_PARAGUAY_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Pearl
	riverPlot = Map.GetPlot(103,53)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_PEARL_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_PEARL_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Po
	riverPlot = Map.GetPlot(69,67)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_PO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_PO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Red
	riverPlot = Map.GetPlot(102,53)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_RED_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_RED_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Rhine
	riverPlot = Map.GetPlot(66,70)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_RHINE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_RHINE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Rhone
	riverPlot = Map.GetPlot(65,67)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_RHONE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_RHONE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Rio Grande
	riverPlot = Map.GetPlot(26,61)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_RIO_GRANDE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_RIO_GRANDE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Salween
	riverPlot = Map.GetPlot(99,49)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SALWEEN_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SALWEEN_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Sao Francisco
	riverPlot = Map.GetPlot(49,31)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SAO_FRANCISCO_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SAO_FRANCISCO_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Seine
	riverPlot = Map.GetPlot(65,70)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SEINE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SEINE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Senegal
	riverPlot = Map.GetPlot(59,48)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SENEGAL_RIVER_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SENEGAL_RIVER_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--St Lawrence
	riverPlot = Map.GetPlot(39,70)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SAINT_LAWRENCE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SAINT_LAWRENCE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Syr Darya
	riverPlot = Map.GetPlot(86,67)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_SYR_DARYA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_SYR_DARYA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Tagus
	riverPlot = Map.GetPlot(61,64)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_TAGUS_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_TAGUS_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Tigris
	riverPlot = Map.GetPlot(81,59)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_TIGRIS_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_TIGRIS_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Tocantins
	riverPlot = Map.GetPlot(46,33)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_TOCANTINS_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_TOCANTINS_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Ural
	riverPlot = Map.GetPlot(82,69)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_URAL_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_URAL_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Vistula
	riverPlot = Map.GetPlot(71,70)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_VISTULA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_VISTULA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Volga
	riverPlot = Map.GetPlot(81,68)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_VOLGA_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_VOLGA_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Yangtze
	riverPlot = Map.GetPlot(105,58)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_YANGTZE_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_YANGTZE_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Yellow
	riverPlot = Map.GetPlot(105,63)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_YELLOW_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_YELLOW_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Yenesei
	riverPlot = Map.GetPlot(95,74)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_YENISEI_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_YENISEI_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end
	--Yukon
	riverPlot = Map.GetPlot(9,76)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_YUKON_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_YUKON_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
	--Zambezi
	riverPlot = Map.GetPlot(73,23)
	eRiverName = RiverManager.GetRiverName(riverPlot)
	if eRiverName == pRiver.Name then
		if bUppercase then
			szName = Locale.ToUpper(Locale.Lookup("LOC_NAMED_RIVER_ZAMBEZI_NAME"));	
		else
			szName = Locale.Lookup("LOC_NAMED_RIVER_ZAMBEZI_NAME");				
		end
		CreateRiverLabel(pOverlay, pRiver, szName);
	end	
end

-- ===========================================================================
--	Modified Firaxis function
-- ===========================================================================

function AddRiverLabel(pOverlay, pRiver)
	if m_RiverTracker[pRiver.TypeID] == nil then
		m_RiverTracker[pRiver.TypeID] = true;
		local eRiver;
		local szName;
		-- print("River ID is "..tostring(pRiver.TypeID))
		if bCustomLabels and bRivers then	
			if mapName == "Earth128x80" then
				GetCustomRiverLabel_Earth128x80(pOverlay, pRiver, szName);
			end
			if mapName == "EqualAreaEarth" then
				GetCustomRiverLabel_EqualAreaEarth(pOverlay, pRiver, szName);
			end
			if mapName == "PTW_GiantEarth" then
				-- Rivers are hardcoded on this map, use the default method
				local fLength = pOverlay:GetTextLength(pRiver.Name, FontParams_River);
				local pSegments = UI.CalculateEdgeSplineSegments(pRiver.Edges, 5, 10, 3, fLength);
				if pSegments ~= nil then
					for _,pSegment in pairs(pSegments) do
						pOverlay:CreateTextArc(pRiver.Name, pSegment, FontParams_River);
					end
				end
			end
		else
			-- approximately one label every 15 edges
			-- 5 edge long labels, with about 10 edges between them, 5+10 = 15
			-- only label rivers with at least 3 edges
			local fLength = pOverlay:GetTextLength(pRiver.Name, FontParams_River);
			local pSegments = UI.CalculateEdgeSplineSegments(pRiver.Edges, 5, 10, 3, fLength);
			if pSegments ~= nil then
				for _,pSegment in pairs(pSegments) do
					pOverlay:CreateTextArc(pRiver.Name, pSegment, FontParams_River);
				end
			end
		end
			--totalslacker: Original Firaxis code below
			-- approximately one label every 15 edges
			-- 5 edge long labels, with about 10 edges between them, 5+10 = 15
			-- only label rivers with at least 3 edges
			-- local fLength = pOverlay:GetTextLength(pRiver.Name, FontParams_River);
			-- local pSegments = UI.CalculateEdgeSplineSegments(pRiver.Edges, 5, 10, 3, fLength);
			-- if pSegments ~= nil then
				-- for _,pSegment in pairs(pSegments) do
					-- pOverlay:CreateTextArc(pRiver.Name, pSegment, FontParams_River);
				-- end
			-- end
	end
end

-- ===========================================================================
function RefreshRivers(pOverlay)
	local eLocalPlayer = Game.GetLocalPlayer();
	if eLocalPlayer == -1 then
		return;
	end

	local pLocalPlayerVis = PlayersVisibility[eLocalPlayer];
	local pRivers = RiverManager.EnumerateRivers();
	
	pOverlay:ClearAll();
	m_RiverTracker = { };
	for _,pRiver in pairs(pRivers) do
		AddRiverLabel(pOverlay, pRiver);
	end
end

-- ===========================================================================
function UpdateRivers(pOverlay, iPlotIndex)
	local eLocalPlayer = Game.GetLocalPlayer();
	if eLocalPlayer == -1 then
		return;
	end

	local pRivers = RiverManager.EnumerateRivers(iPlotIndex);
	if pRivers then
		for _,pRiver in pairs(pRivers) do
			AddRiverLabel(pOverlay, pRiver);
		end
	end
end

-- ===========================================================================
function RefreshVolcanoes(pOverlay)
	local eLocalPlayer = Game.GetLocalPlayer(); 
	if eLocalPlayer == -1 then
		return;
	end

	local pLocalPlayerVis = PlayersVisibility[eLocalPlayer];
	local pVolcanoes = MapFeatureManager.GetNamedVolcanoes();
	
	pOverlay:ClearAll();
	for _,pVolcano in pairs(pVolcanoes) do
		if pLocalPlayerVis:IsRevealed(pVolcano.PlotX, pVolcano.PlotY) then
			-- TODO how to handle volcano wonders? what if volcanoes are turned on and wonders are off?
			local szName = Locale.ToUpper(pVolcano.Name);
			local x, y = UI.GridToWorld(pVolcano.PlotX, pVolcano.PlotY);
			pOverlay:CreateTextAtPos(szName, x, y + POI_OFFSET_Y, FontParams_PointOfInterest);
		end
	end
end

-- ===========================================================================
function UpdateVolcanoes(pOverlay, iPlotIndex)
	if MapFeatureManager.IsVolcano(iPlotIndex) then
		RefreshVolcanoes(pOverlay);
	end
end

-- ===========================================================================
function RefreshContinents(pOverlay)
	
	pOverlay:ClearAll();
	local pContinents = Map.GetContinentsInUse();

	for _,iContinent in ipairs(pContinents) do
	
		local pPlots = Map.GetContinentPlots(iContinent);
		local szName = Locale.Lookup( GameInfo.Continents[iContinent].Description );

		local pGroups = UI.PartitionRegions( pPlots );
		for _,pGroup in pairs(pGroups) do
			-- try to have approximately one label per 60 hexes
			-- dont label a region that has less than 8 hexes total
			local pPositions = UI.GetRegionClusterPositions( pGroup, 60, 8 );
			if pPositions then
				for _,pos in pairs(pPositions) do
					local szNameUpper = Locale.ToUpper(szName);
					pOverlay:CreateTextAtPos(szNameUpper, pos.x, pos.y, FontParams_MajorRegion);
				end
			end
		end

	end
end

-- ===========================================================================
function RefreshReligions(pOverlay)
	local eLocalPlayer = Game.GetLocalPlayer(); 
	if eLocalPlayer == -1 then
		return;
	end

	local pLocalPlayerVis = PlayersVisibility[eLocalPlayer];
	if (pLocalPlayerVis == nil) then
		return;
	end
	
	pOverlay:ClearAll();
	local players = Game.GetPlayers();
	for _,pPlayer in ipairs(players) do
		local cities = pPlayer:GetCities();
		for _,pCity in cities:Members() do
			
			local iCityX = pCity:GetX();
			local iCityY = pCity:GetY();
		--	if pLocalPlayerVis:IsRevealed(iCityX, iCityY) then
			
				local pCityReligion = pCity:GetReligion();
				local eMajorityReligion = pCityReligion:GetMajorityReligion();

				if (eMajorityReligion >= 0) then
					local x, y = UI.GridToWorld(iCityX, iCityY);
					local szName = Game.GetReligion():GetName(eMajorityReligion);
					local szLocalizedName = Locale.Lookup( szName );
					pOverlay:CreateTextAtPos(szLocalizedName, x, y + RELIGION_OFFSET_Y, FontParams_Religion);
				end
		--	end
		end
	end

end

-- ===========================================================================
function UpdateVisibleNaturalWonderLabels()
	local pManager = m_LabelManagerMap[NATURAL_WONDER_LAYER_HASH];
	if pManager.m_RebuildFunction and pManager.m_OverlayInstance then
		pManager.m_RebuildFunction(pManager.m_OverlayInstance);
	end
end

-- ===========================================================================
function Refresh()
	for nLayerHash,pManager in pairs(m_LabelManagerMap) do
		pManager.m_OverlayInstance = UILens.GetOverlay(pManager.m_szOverlayName);
		
		if pManager.m_OverlayInstance and pManager.m_szFontStyle then
			local szFontFamily = UIManager:GetFontFamilyFromStyle(pManager.m_szFontStyle);
			pManager.m_OverlayInstance:SetFontFamily(szFontFamily);
		end

		if pManager.m_RebuildFunction and pManager.m_OverlayInstance then
			pManager.m_RebuildFunction(pManager.m_OverlayInstance);
		end
		
		if pManager.m_OverlayInstance then
			local bLayerOn = UILens.IsLayerOn(nLayerHash);
			pManager.m_OverlayInstance:SetVisible(bLayerOn);
		end
	end
end

-- ===========================================================================
function OnLensLayerOn( layerHash:number )
	local pManager = m_LabelManagerMap[layerHash];
	if pManager and pManager.m_OverlayInstance then
		pManager.m_OverlayInstance:SetVisible(true);
	end

	-- If national park labels are shown, we may need to hide some natural wonder labels
	if layerHash == NATIONAL_PARK_LAYER_HASH then
		UpdateVisibleNaturalWonderLabels();
	end
end

-- ===========================================================================
function OnLensLayerOff( layerHash:number )
	local pManager = m_LabelManagerMap[layerHash];
	if pManager and pManager.m_OverlayInstance then
		pManager.m_OverlayInstance:SetVisible(false);
	end
	
	-- If national park labels are hidden, we may need to show some natural wonder labels
	if layerHash == NATIONAL_PARK_LAYER_HASH then
		UpdateVisibleNaturalWonderLabels();
	end
end

-- ===========================================================================
function RefreshTerritoryCache()
	m_TerritoryCache = { }

	local nPlots = Map.GetPlotCount();
	for iPlot = 0,nPlots-1 do
		local pTerritory = Territories.GetTerritoryAt(iPlot);
		if pTerritory then
			local eTerritory = pTerritory:GetID();
			if m_TerritoryCache[eTerritory] then
				-- Add a new plot
				table.insert(m_TerritoryCache[eTerritory].pPlots, iPlot);
			else
				-- Instantiate a new territory
				m_TerritoryCache[eTerritory] = { pPlots = { iPlot } };
			end
		end
	end
end

-- ===========================================================================
function OnPlotVisibilityChanged( x, y, visibilityType )
	if (visibilityType ~= RevealedState.HIDDEN) then
		local iPlot:number = Map.GetPlotIndex(x, y);
		for nLayerHash,pManager in pairs(m_LabelManagerMap) do
			if pManager.m_UpdateFunction and pManager.m_OverlayInstance then
				pManager.m_UpdateFunction(pManager.m_OverlayInstance, iPlot);
			end
		end
	end
end

-- ===========================================================================
function OnNationalParksChanged()
	m_bUpdateNationalParkLabels = true;
end

-- ===========================================================================
function OnCityReligionChanged(playerID: number, cityID : number, eNewReligion : number)
	-- TODO track labels that changed
	local pManager = m_LabelManagerMap[RELIGION_LAYER_HASH];
	if pManager.m_RebuildFunction and pManager.m_OverlayInstance then
		pManager.m_RebuildFunction(pManager.m_OverlayInstance);
	end
end

-- ===========================================================================
function OnFeatureAddedToMap(x: number, y : number)

	local pPlot = Map.GetPlot(x, y);
	if (pPlot ~= nil and pPlot:IsNaturalWonder()) then
		local pFeature = pPlot:GetFeature();
		local pFeaturePlots = pFeature:GetPlots();
		m_NaturalWonderPlots[pFeaturePlots[1]] = pFeature;
		m_bUpdateNaturalWonderLabels = true;
	end
end

-- ===========================================================================
function OnFeatureRemovedFromMap(x: number, y : number)

	local iPlot:number = Map.GetPlotIndex(x, y);
	-- Was that plot in the Natural Wonder Plots list?
	if m_NaturalWonderPlots[iPlot] ~= nil then
		-- Remove it and rebuild
		m_NaturalWonderPlots[iPlot] = nil;
		m_bUpdateNaturalWonderLabels = true;
	end
end

-- ===========================================================================
-- Handle expensive updates when all events are complete.  Prevents redundant updates.
function OnEventPlaybackComplete()
	if m_bUpdateNationalParkLabels == true then
		m_bUpdateNationalParkLabels = false
		local pManager = m_LabelManagerMap[NATIONAL_PARK_LAYER_HASH];
		if pManager.m_RebuildFunction and pManager.m_OverlayInstance then
			pManager.m_RebuildFunction(pManager.m_OverlayInstance);
		end
		-- Need to update the NW labels because they can overlap
		m_bUpdateNaturalWonderLabels = true;
	end
	
	m_bUpdateNaturalWonderLabels = true;

	if m_bUpdateNaturalWonderLabels == true then
		m_bUpdateNaturalWonderLabels = false;
		UpdateVisibleNaturalWonderLabels();
	end		
end
-- ===========================================================================
function OnInit(isHotload : boolean)
	-- If hotloading, rebuild from scratch.
	if isHotload then
		Refresh();
	end
end

-- ===========================================================================
function OnShutdown()
	for _,pManager in pairs(m_LabelManagerMap) do
		if pManager.m_OverlayInstance then
			pManager.m_OverlayInstance:ClearAll();
		end
	end
end

-- ===========================================================================
function Initialize()
	ContextPtr:SetInitHandler( OnInit );
	ContextPtr:SetShutdown( OnShutdown );
	
	CreateLabelManager( "MapLabels_NationalParks",  "MapLabelOverlay_NationalParks",  RefreshNationalParks,  nil,                  "FontNormal18"      ); -- Myriad Semibold
	CreateLabelManager( "MapLabels_NaturalWonders", "MapLabelOverlay_NaturalWonders", RefreshNaturalWonders, UpdateNaturalWonders, "FontNormal18"      ); -- Myriad Semibold
	CreateLabelManager( "MapLabels_Rivers",         "MapLabelOverlay_Rivers",         RefreshRivers,         UpdateRivers,         "FontItalicFlair18" ); -- Minion Italicized
	CreateLabelManager( "MapLabels_Volcanoes",      "MapLabelOverlay_Volcanoes",      RefreshVolcanoes,      UpdateVolcanoes,      "FontNormal18"      ); -- Myriad Semibold

	do
		local CreateTerritoryLabelManager = function(szLensLayer, szOverlayName, pTerritorySelector, szFontStyle)
			local pUpdateFunction = function(pOverlay, iPlotIndex) UpdateTerritory(pOverlay, iPlotIndex, pTerritorySelector); end
			local pRebuildFunction = function(pOverlay) RefreshTerritories(pOverlay, pTerritorySelector); end
			return CreateLabelManager(szLensLayer, szOverlayName, pRebuildFunction, pUpdateFunction, szFontStyle)
		end

		local IsDesert = function(pTerritory) return (pTerritory:GetTerrainClass() == CLASS_DESERT); end
		local IsMountainRange = function(pTerritory) return (pTerritory:GetTerrainClass() == CLASS_MOUNTAIN) end
		local IsLake = function(pTerritory) return (pTerritory:GetTerrainClass() == CLASS_WATER) and pTerritory:IsLake(); end
		local IsOcean = function(pTerritory) return (pTerritory:GetTerrainClass() == CLASS_WATER) and not (pTerritory:IsLake() or pTerritory:IsSea()); end
		local IsSea = function(pTerritory) return (pTerritory:GetTerrainClass() == CLASS_WATER) and pTerritory:IsSea(); end

		CreateTerritoryLabelManager( "MapLabels_Deserts",        "MapLabelOverlay_Deserts",        IsDesert,        "FontFlair16"       ); -- Minion Semibold
		CreateTerritoryLabelManager( "MapLabels_MountainRanges", "MapLabelOverlay_MountainRanges", IsMountainRange, "FontFlair16"       ); -- Minion Semibold
		CreateTerritoryLabelManager( "MapLabels_Lakes",          "MapLabelOverlay_Lakes",          IsLake,          "FontItalicFlair18" ); -- Minion Italicized
		CreateTerritoryLabelManager( "MapLabels_Oceans",         "MapLabelOverlay_Oceans",         IsOcean,         "FontItalicFlair18" ); -- Minion Italicized
		CreateTerritoryLabelManager( "MapLabels_Seas",           "MapLabelOverlay_Seas",           IsSea,           "FontItalicFlair18" ); -- Minion Italicized
	end

	CreateLabelManager( "Hex_Coloring_Continent",   "MapLabelOverlay_Continents",     RefreshContinents,     nil,                  "FontNormal18"      ); -- Myriad Semibold
	CreateLabelManager( "Hex_Coloring_Religion",    "MapLabelOverlay_Religions",      RefreshReligions,      nil,                  "FontNormal18"      ); -- Myriad Semibold

	Events.OverlaySystemInitialized.Add( Refresh );
	Events.LensLayerOn.Add( OnLensLayerOn );
	Events.LensLayerOff.Add( OnLensLayerOff );
	Events.PlotVisibilityChanged.Add( OnPlotVisibilityChanged );
	Events.NationalParkAdded.Add( OnNationalParksChanged );
	Events.NationalParkRemoved.Add( OnNationalParksChanged );
	Events.CityReligionChanged.Add( OnCityReligionChanged );
	Events.FeatureAddedToMap.Add( OnFeatureAddedToMap );
	Events.FeatureRemovedFromMap.Add( OnFeatureRemovedFromMap );

	Events.GameCoreEventPlaybackComplete.Add(OnEventPlaybackComplete);

	--TODO subscribe to other gameplay events that change which labels are visible
	--feature naming, player changing, etc
	
	FindNaturalWonders();
	RefreshTerritoryCache();
	Refresh();
end
Initialize();
