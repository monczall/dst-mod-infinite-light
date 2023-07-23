-- Name of mod
name = "Infinite Light"

-- Version
version = "1.2"

-- Mod description
description = "Your infinte source of light. \n Version " .. version .. "."

-- Author
author = "Monczall"

-- Forum thread related to mod
forumthread = "https://steamcommunity.com/sharedfiles/filedetails/discussions/2585012585"

-- Api version
api_version = 10

-- Priority of mod loading
priority = 10

-- Tels client if its compatible with singleplayer version of Don't Starve
dont_starve_compatible = true

-- Tels clients if its compatible with multiplayer version of Don't Starve
dst_compatible = true

-- Tels clients if its compatible with Don't Starve: ROG
reign_of_giants_compatible = false

-- Tels clients if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = true

-- If false it marks server as moded, else its just a cliend mod
client_only_mod = false

-- Filter used to search for server using this mod
server_filter_tags = { "infinte light" }

-- Mod icon atlas
icon_atlas = "modicon.xml"

-- Mod icon file
icon = "modicon.tex"

-- Menu that is found in mod options
configuration_options =
{
	{
		name = "activeAt",
		label = "Light turn at",
		hover = "When a light should be turned on.",
		options = {
			{ description = "Always On", data = "allways", hover = "Light is allways turned on." },
			{ description = "Dusk",      data = "dusk",    hover = "Light is turned on at dusk and night." },
			{ description = "Night",     data = "night",   hover = "Light is turned on at night." },
		},

		default = "night",

	},

	{
		name = "mainComponent",
		label = "Recipe contains",
		hover =
		"Decide what should be a main ingredient. (Full recipe is: main ingredient + 3x Electrical Doodad + Lantern)",
		options = {
			{ description = "Gold Nugget", data = "goldnugget", hover = "Five gold nuggets are main ingredient." },
			{ description = "Red Gem",     data = "redgem",     hover = "Red gem is main ingredient." },
			{ description = "Blue Gem",    data = "bluegem",    hover = "Blue gem is main ingredient." },
			{ description = "Purple Gem",  data = "purplegem",  hover = "Purple gem is main ingredient." },
			{ description = "Orange Gem",  data = "orangegem",  hover = "Orange gem is main ingredient." },
			{ description = "Yellow Gem",  data = "yellowgem",  hover = "Yellow gem is main ingredient." },
			{ description = "Green Gem",   data = "greengem",   hover = "Green gem is main ingredient." },
		},

		default = "goldnugget",

	},

	{
		name = "difficultyMultiplier",
		label = "Recipe Difficulty Multiplier",
		hover = "Multiply ammount of needed ingredients. (Multiplier doesn't apply to lantern)",
		options = {
			{ description = "1x", data = 1, hover = "Default value." },
			{ description = "2x", data = 2, hover = "Two times more ingredients needed." },
			{ description = "3x", data = 3, hover = "Three times more ingredients needed." },
		},

		default = 1,

	},

	{
		name = "lightRadius",
		label = "Light Radius Multiplier",
		hover = "Choose size of light radius.",
		options = {
			{ description = "1x", data = 1, hover = "Default radius." },
			{ description = "2x", data = 2, hover = "Medium radius." },
			{ description = "3x", data = 3, hover = "Large radius." },
			{ description = "4x", data = 4, hover = "Gigantic radius." }
		},

		default = 1,

	},

	{
		name = "visibleOnMap",
		label = "Visible on map",
		hover = "Decide if should be visible on map.",
		options = {
			{ description = "True",  data = "true",  hover = "Visible on map." },
			{ description = "False", data = "false", hover = "Not visible on map." }
		},

		default = "false",

	},

	{
		name = "craftable",
		label = "Allow crafting",
		hover = "Turn crafting new infinite lights on or off",
		options = {
			{ description = "True",  data = "true",  hover = "Allow crafting" },
			{ description = "False", data = "false", hover = "Disallow crafting" }
		},

		default = "true",

	},

}
