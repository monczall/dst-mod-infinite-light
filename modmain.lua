local _G = GLOBAL
local require = _G.require
local assert = _G.assert

Assets =
{
}

local mainComponent = GetModConfigData("mainComponent")
local difficultyMultiplier = GetModConfigData("difficultyMultiplier")
GLOBAL.TUNING.INFINITELIGHT = {
  activeAt = GetModConfigData("activeAt"),
  lightRadius = GetModConfigData("lightRadius"),
  visibleOnMap = GetModConfigData("visibleOnMap"),
  craftable = GetModConfigData("craftable"),
}

PrefabFiles =
{
  "city_lamp",
}

---------------------------------------------------------------------------------
local Ingredient = _G.Ingredient
local RECIPETABS = _G.RECIPETABS
local TECH = _G.RECIPETABS

local activeAt = TUNING.INFINITELIGHT.activeAt
local craftable = TUNING.INFINITELIGHT.craftable

local mainComponentQuantity = 1
if mainComponent == "goldnugget" then
  mainComponentQuantity = 5
end

local recipe_name = "city_lamp"
local ingredients = {
  Ingredient(mainComponent, (mainComponentQuantity * difficultyMultiplier)),
  Ingredient("transistor", (3 * difficultyMultiplier)),
  Ingredient("lantern", 1)
}
local tech = TECH.SCIENCE_TWO
local config = {
  placer = "city_lamp_placer",
  atlas = "images/city_lamp.xml",
}
local config2 = {
  placer = "city_lamp_placer",
  atlas = "images/city_lamp.xml",
  builder_tag = "nobody",
}

if craftable == "true" then
  AddRecipe2(recipe_name, ingredients, tech, config)
else
  AddRecipe2(recipe_name, ingredients, tech, config2)
end

AddRecipeToFilter(recipe_name, "LIGHT")

if RECIPE_ID == 0 then
  AddSimPostInit(function()
    local errmsg = [[Necessary mod is not loaded! You should subscribe the following mod:
      https://steamcommunity.com/sharedfiles/filedetails/?id=2585012585]]
    local world = _G.TheWorld
    if world.ismastersim then
      assert(_G.SpawnPrefab("alloy") ~= nil, errmsg)
    end
  end)
end
---------------------------------------------------------------------------------
local STRINGS = GLOBAL.STRINGS
-------------------------------
if STRINGS.CHARACTERS.WALANI == nil then
  STRINGS.CHARACTERS.WALANI = {
    DESCRIBE = {},
  }
end -- DLC002
if STRINGS.CHARACTERS.WARLY == nil then
  STRINGS.CHARACTERS.WARLY = {
    DESCRIBE = {},
  }
end -- DLC002
if STRINGS.CHARACTERS.WOODLEGS == nil then
  STRINGS.CHARACTERS.WOODLEGS = {
    DESCRIBE = {},
  }
end -- DLC002
if STRINGS.CHARACTERS.WILBA == nil then
  STRINGS.CHARACTERS.WILBA = {
    DESCRIBE = {},
  }
end -- DLC003
if STRINGS.CHARACTERS.WARBUCKS == nil then
  STRINGS.CHARACTERS.WARBUCKS = {
    DESCRIBE = {},
  }
end -- DLC003
-------------------------------
-- Prefab

if activeAt == "allways" then
  warbucksMessageOn = "We need light in the daytime, I suppose."
  wathgrithrMessageGeneric = "It shines bright."
  wendyMessageGeneric = "It can ward off the darkness forever."
  wilbaMessageOn = "'TIS ALLWAYS ALIGHT"
  willowMessageOn = "They're never dull."
  wolfgangMessageOn = "Is lamp for infinite lights."
elseif activeAt == "dusk" then
  warbucksMessageON = "No need for light in the daytime, I suppose."
  wathgrithrMessageGeneric = "It shines bright."
  wendyMessageGeneric = "It can ward off the darkness forever."
  wilbaMessageOn = "'TIS ALIGHT AT NIGHT 'N DUSK"
  willowMessageOn = "They're kinda dull in the daytime."
  wolfgangMessageOn = "Is lamp for night lights."
elseif activeAt == "night" then
  warbucksMessageON = "No need for light in the daytime, I suppose."
  wathgrithrMessageGeneric = "It shines bright this night."
  wendyMessageGeneric = "It cannot ward off the darkness forever."
  wilbaMessageOn = "'TIS ONLY ALIGHT AT NIGHT"
  willowMessageOn = "They're kinda dull in the daytime."
  wolfgangMessageOn = "Is lamp for night lights."
end

STRINGS.NAMES.CITY_LAMP = "Infinite Light"
STRINGS.RECIPE_DESC.CITY_LAMP = "Source of infinite light."

STRINGS.CHARACTERS.GENERIC.DESCRIBE.CITY_LAMP =
{
  GENERIC = "It's a light that never dies.",
  ON = "It's a light that never dies.",
}

STRINGS.CHARACTERS.WALANI.DESCRIBE.CITY_LAMP =
{
  GENERIC = "Thanks for keeping me safe, light!",
  ON = "Pretty sure that's a lamp.",
}

STRINGS.CHARACTERS.WARBUCKS.DESCRIBE.CITY_LAMP =
{
  GENERIC = "What an intriguing civilization!",
  ON = warbucksMessageOn,
}

STRINGS.CHARACTERS.WARLY.DESCRIBE.CITY_LAMP =
{
  GENERIC = "It's a small comfort.",
  ON = "What a quaint street lamp.",
}

STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.CITY_LAMP =
{
  GENERIC = wathgrithrMessageGeneric,
  ON = "Nary a glimmer.",
}

STRINGS.CHARACTERS.WAXWELL.DESCRIBE.CITY_LAMP =
{
  GENERIC = "A welcome sign of civilization.",
  ON = "It eases my mind.",
}

STRINGS.CHARACTERS.WEBBER.DESCRIBE.CITY_LAMP =
{
  GENERIC = "They don't turn off when I get close!",
  ON = "I miss street lamps.",
}

STRINGS.CHARACTERS.WENDY.DESCRIBE.CITY_LAMP =
{
  GENERIC = wendyMessageGeneric,
  ON = "A place to hold light.",
}

STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.CITY_LAMP =
{
  GENERIC = "Quite radiant.",
  ON = "A dormant street lamp.",
}

STRINGS.CHARACTERS.WILBA.DESCRIBE.CITY_LAMP =
{
  GENERIC = "'TIS A LAMP",
  ON = wilbaMessageOn,
}

STRINGS.CHARACTERS.WILLOW.DESCRIBE.CITY_LAMP =
{
  GENERIC = "Fire is so versatile.",
  ON = willowMessageOn,
}

STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.CITY_LAMP =
{
  GENERIC = "Wolfgang does not like the dark.",
  ON = wolfgangMessageOn,
}

STRINGS.CHARACTERS.WOODIE.DESCRIBE.CITY_LAMP =
{
  GENERIC = "A little bit of safe haven.",
  ON = "Looks like a street lamp.",
}

STRINGS.CHARACTERS.WOODLEGS.DESCRIBE.CITY_LAMP =
{
  GENERIC = "Sanctuary!",
  ON = "A landlamp.",
}

STRINGS.CHARACTERS.WX78.DESCRIBE.CITY_LAMP =
{
  GENERIC = "PRIMITIVE SOURCE OF ILLUMINATION",
  ON = "NONFUNCTIONING",
}
