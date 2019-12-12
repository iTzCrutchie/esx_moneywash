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

--[[ 
	Below are the zones for laundering. You can set multiple zones just follow the format below. 
	Failure to do so will result in the script breaking.
	Set the job to 'any' if you want anybody to use the location. Otherwise set the required job you want to use for the location
	Any job not allowed to use the location WILL NOT see a marker or get a popup to use it.

	
	EXAMPLE LOCATION!!! JUST COPY THIS AND PASTE TO ADD MORE LOCATIONS!
		
	{
		Pos = {
			{x = 1090.84 , y = -2233.43 , z = 31.5}
		},
		
		Jobs = {
			--'any', -- SET THE 'any' TAG TO ALLOW ALL JOBS INCLUDING POLICE TO USE THE LOCATION
			--'miner',
			--'cardealer'
		}
	},
	
]]

Config.Zones = {
	
	{	
		Pos = { 
			{x = 1122.5 , y = -3194.98 , z = -41.60},
		},
		
		Jobs = {
			--'any', -- set to 'any' to allow the location for any player regardless of job
			'cardealer'
		}
	},
	
	--[[{
		Pos = {
			{x = 1090.84 , y = -2233.43 , z = 31.5}
		},
		
		Jobs = {
			--'miner',
			'cardealer'
		}
	},]]
}
