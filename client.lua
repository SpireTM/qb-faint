QBCore = exports['qb-core']:GetSharedObject()

local isRagdolling = false

RegisterCommand('faint', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
        if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not IsPauseMenuActive() then
			isRagdolling = not isRagdolling
			if isRagdolling then
				QBCore.Functions.Notify("you lost consciousness!")
				exports['qb-drawtext']:DrawText('[U] - Get up', 'left')	
			else
				exports['qb-drawtext']:HideText()
			end
			RagdollLoop()
		end
	end)
end)

RegisterKeyMapping('faint', 'Lose consciousness', 'keyboard', 'U')


function RagdollLoop()
	Citizen.CreateThread(function()
		while isRagdolling do
			Citizen.Wait(0)
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
		end
	end)
end
