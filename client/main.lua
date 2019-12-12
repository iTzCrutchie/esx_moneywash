local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX								= nil
local hasAlreadyEnteredMarker	= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


-- Washed Menu
function OpenWashedMenu(zone)
	local elements = {
		{label = _U('wash_money'), 	value = 'wash_money'},
		--{label = _U('no'),			value = 'no'}
		}
		
		ESX.UI.Menu.CloseAll()
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wash', {
			title		= _U('washed_menu'),
			align		= 'top-left',
			elements	= elements
		}, function(data, menu)
			if data.current.value == 'wash_money' then
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'wash_money_amount_', {
					title = _U('wash_money_amount')
				}, function(data, menu)
				
					local amount = tonumber(data.value)
					
					if amount == nil then
						ESX.ShowNotification(_U('invalid_amount'))
					else
						menu.close()
						TriggerServerEvent('esx_moneywash:washMoney', amount)
					end
				end, function(data, menu)
					menu.close()
				end)
			end
			end, function(data, menu)
				
				menu.close()
					
				CurrentAction	 = 'wash_menu'
				CurrentActionMsg = _U('press_menu')
				CurrentActionData = {zone = zone}
					
			
		end)

end


--Enter / Exit Marker
AddEventHandler('esx_moneywash:hasEnteredMarker', function(zone)
	CurrentAction     = 'wash_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {zone = zone}
end)

AddEventHandler('esx_moneywash:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()		
end)

-- Create Blips

-- Diplay Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords 		= GetEntityCoords(PlayerPedId())
		
		for k,zoneID in pairs(Config.Zones) do

			local isAuthorized 	= Authorized(zoneID)
		
			for i = 1, #zoneID.Pos, 1 do
			
				if isAuthorized and (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, zoneID.Pos[i].x, zoneID.Pos[i].y, zoneID.Pos[i].z, true) < Config.DrawDistance) then
					DrawMarker(Config.Type, zoneID.Pos[i].x, zoneID.Pos[i].y, zoneID.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end
				
			end
			
		end
		
	end
end)



-- Enter / Exit Marker Events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords		= GetEntityCoords(PlayerPedId())
		local isInMarker	= false
		local currentZone 	= nil
		
		for k,zoneID in pairs(Config.Zones) do
		
			local isAuthorized 	= Authorized(zoneID)
			
			for i = 1, #zoneID.Pos, 1 do
				if isAuthorized and (GetDistanceBetweenCoords(coords, zoneID.Pos[i].x, zoneID.Pos[i].y, zoneID.Pos[i].z, true) < Config.Size.x) then
					isInMarker = true
					currentZone = k
				end
			end
			
		end
		
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('esx_moneywash:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_moneywash:hasExitedMarker', LastZone)
		end
		
	end
end)

-- Get authorized jobs
function Authorized(zoneID)
	if ESX.PlayerData.job == nil then
		return false
	end
	
	for _,job in pairs(zoneID.Jobs) do
		
		if job == 'any' or job == ESX.PlayerData.job.name then
			return true
		end
	end
	
	return false
	
end

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)
			
			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'wash_menu' then
					OpenWashedMenu(CurrentActionData.zone)
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)