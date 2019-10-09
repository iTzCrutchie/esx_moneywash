Config 					= {}

Config.Locale 			= 'en'
Config.DrawDistance 	= 100
Config.Size 			= {x = 1.5, y = 1.5, z = 1.5}
Config.Color 			= {r = 255, g = 120, b = 0}
Config.Type 			= 1

Config.taxRate = 0.65  --65% of the dirty you will get back in clean

Config.enableTimer = true -- Enable ONLY IF you want a timer on the money washing. Keep in mind the Player does not have to stay at the wash for it to actually wash the money.
local second = 1000
local minute = 60 * second
local hour = 60 * minute

Config.timer = 5 * second -- Time it takes to wash money. The * amount will determine if its hours, second, or minutes.

Config.Zones = {

	laundryMat = {
		Pos = {
			{x = 1122.39 , y = -3194.86 , z = -41.60 },
			--{x = 136.92 , y = -1278.44 , z = 28.35}
		}
	}

}