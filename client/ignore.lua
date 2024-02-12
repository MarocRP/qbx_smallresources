local config = require 'config.client'

CreateThread(function()
	while true do
		for _, sctyp in next, config.blacklisted.scenarioTypes do
			SetScenarioTypeEnabled(sctyp, false)
		end
		for _, scmdl in next, config.blacklisted.suppressedModels do
			SetVehicleModelIsSuppressed(joaat(scmdl), true)
		end
		for _, scgrp in next, config.blacklisted.scenarioGroups do
			SetScenarioGroupEnabled(scgrp, false)
		end
		Wait(10000)
	end
end)

AddEventHandler('populationPedCreating', function(x, y, z)
	Wait(500)	-- Give the entity some time to be created
	local handle = GetClosestPed(vec3(x, y, z)) -- Get the entity handle
	SetPedDropsWeaponsWhenDead(handle, false)
end)

CreateThread(function() -- all these should only need to be called once
	if config.disable.ambience then
		StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
	end
	SetAudioFlag('PoliceScannerDisabled', true)
	SetGarbageTrucks(false)
	SetCreateRandomCops(false)
	SetCreateRandomCopsNotOnScenarios(false)
	SetCreateRandomCopsOnScenarios(false)
	DistantCopCarSirens(false)
	SetFarDrawVehicles(false)
	RemoveVehiclesFromGeneratorsInArea(335.2616 - 300.0, -1432.455 - 300.0, 46.51 - 300.0, 335.2616 + 300.0, -1432.455 + 300.0, 46.51 + 300.0) -- central los santos medical center
	RemoveVehiclesFromGeneratorsInArea(441.8465 - 500.0, -987.99 - 500.0, 30.68 -500.0, 441.8465 + 500.0, -987.99 + 500.0, 30.68 + 500.0) -- police station mission row
	RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0) -- pillbox
	RemoveVehiclesFromGeneratorsInArea(-2150.44 - 500.0, 3075.99 - 500.0, 32.8 - 500.0, -2150.44 + 500.0, -3075.99 + 500.0, 32.8 + 500.0) -- military
	RemoveVehiclesFromGeneratorsInArea(-1108.35 - 300.0, 4920.64 - 300.0, 217.2 - 300.0, -1108.35 + 300.0, 4920.64 + 300.0, 217.2 + 300.0) -- nudist
	RemoveVehiclesFromGeneratorsInArea(-458.24 - 300.0, 6019.81 - 300.0, 31.34 - 300.0, -458.24 + 300.0, 6019.81 + 300.0, 31.34 + 300.0) -- police station paleto
	RemoveVehiclesFromGeneratorsInArea(1854.82 - 300.0, 3679.4 - 300.0, 33.82 - 300.0, 1854.82 + 300.0, 3679.4 + 300.0, 33.82 + 300.0) -- police station sandy
	RemoveVehiclesFromGeneratorsInArea(-724.46 - 300.0, -1444.03 - 300.0, 5.0 - 300.0, -724.46 + 300.0, -1444.03 + 300.0, 5.0 + 300.0) -- REMOVE CHOPPERS WOW
end)

CreateThread(function()
	local sleep
	while true do
		sleep = 1000
		if IsPedBeingStunned(cache.ped, 0) then
			sleep = 0
			SetPedMinGroundTimeForStungun(cache.ped, math.random(4000, 7000))
		end
		Wait(sleep)
	end
end)

CreateThread(function()
	for i = 1, 15 do
		EnableDispatchService(i, false)
	end

	SetMaxWantedLevel(0)
end)

if config.disable.idleCamera then
	DisableIdleCamera(true)
end

CreateThread(function()
	local sleep
	while true do
		sleep = 500
		local weapon = GetSelectedPedWeapon(cache.ped)
		if weapon ~= `WEAPON_UNARMED` then
			if IsPedArmed(cache.ped, 6) then
				sleep = 0
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
			end

			if weapon == `WEAPON_FIREEXTINGUISHER` or weapon == `WEAPON_PETROLCAN` then
				if IsPedShooting(cache.ped) then
					SetPedInfiniteAmmo(cache.ped, true, `WEAPON_FIREEXTINGUISHER`)
					SetPedInfiniteAmmo(cache.ped, true, `WEAPON_PETROLCAN`)
				end
			end
		end
		Wait(sleep)
	end
end)
