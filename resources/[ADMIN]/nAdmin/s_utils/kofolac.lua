Citizen.CreateThread(function()

	NedavneEksplozije = {}
  
	while true do 
		Citizen.Wait(3000)
		BrojIgracevihExplozija = {}
		NedavneEksplozije = {}
	end
end)

local VrsteEksplozija = {
    [0] = "Granata",
    [1] = "Grenade Launcher",
    [2] = "Sticky bomba",
    [3] = "Molotov",
    [4] = "Raketa",
    [5] = "Tenk granata",
    [6] = "Oktan bacva",
    [7] = "Auto",
    [8] = "Letjelica",
    [9] = "Pumpa",
    [10] = "Biciklo",
    [11] = "Para",
    [12] = "Vatra",
    [13] = "Hidrant",
    [14] = "Kanister Goriva",
    [15] = "Brod",
    [16] = "Brod, unistenje",
    [17] = "Kamion",
    [18] = "Metak",
    [19] = "Smoke Launcher",
    [20] = "Smoke granata",
    [21] = "BZGas",
    [22] = "Flare", 
    [23] = "Kanister Goriva",
    [24] = "Aparat za gasenje",
    [25] = "PROGRAMMABLE AR",
    [26] = "Voz",
    [27] = "Bačva",
    [28] = "Propan",
    [29] = "Blimp",
    [30] = "Dir Flame Explode",
    [31] = "Tanker",
    [32] = "Raketa aviona",
    [33] = "Metci iz auta",
    [34] = "Gas Tank",
    [35] = "Sranje od ptice"
}

local EventiKojeCheater = {
	"esx_jobs:caution",
	"eden_garage:payhealth",
	"esx_fueldelivery:pay",
	"esx_carthief:pay",
	"esx_godirtyjob:pay",
	"esx_pizza:pay",
	"esx_ranger:pay",
	"esx_garbagejob:pay",
	"esx_truckerjob:pay",
	"AdminMenu:giveBank",
	"AdminMenu:giveCash",
	"esx_gopostaljob:pay",
	"esx_banksecurity:pay",
	"esx_slotmachine:sv:2",
	"esx_ambulancejob:revive",
	"bank:withdraw",
	"esx-qalle-jail:jailPlayer",
	"esx_vehicleshop:setVehicleOwned",
	"esx_inventoryhud:openPlayerInventory",
	"esx_vangelico_robbery:gioielli"
}


for i = 1, #EventiKojeCheater do
	RegisterServerEvent(EventiKojeCheater[i])
	AddEventHandler(EventiKojeCheater[i], function()
		local src = source
		TriggerEvent("BennoCheatCheck:AnitCheat_event", src, EventiKojeCheater[i])
		TriggerEvent("badmin:SisBan", src, "Cheater", 0, 0, 0, 0, true)
	end)
end


AddEventHandler('explosionEvent', function(sender, ev)
	if ev.damageScale ~= 0.0 and ev.explosionType ~= 13 then
	
		if NedavneEksplozije[sender] then
			NedavneEksplozije[sender] = NedavneEksplozije[sender] + 1

			if NedavneEksplozije[sender] > 6 then
				TriggerEvent("BennoCheatCheck:AnitCheat_exp", sender, NedavneEksplozije[sender])
				DropPlayer(sender, "nAdmin AC - Kikovan si sa servera radi stvaranja eksplozija")
				CancelEvent()
				return
			end
		else
			NedavneEksplozije[sender] = 1
		end

		TriggerClientEvent("bAdmin:expNotif", -1, GetPlayerName(sender), sender, VrsteEksplozija[ev.explosionType],  NedavneEksplozije[sender])
	end
end)


AddEventHandler("entityCreating", function(entity)
	if DoesEntityExist(entity) then
		if Sumnjivo[GetEntityModel(entity)] then
			CancelEvent()
			DeleteEntity(entity)
		end
	end
end)

RegisterNetEvent("bAdmin:flagged", function(vrsta, hash)
	if vrsta == "weapon" then
		print("Ima weapon", HumaneWeapon[hash])
	elseif vrsta == "spectate" then
		print("Hoce specate")
	end
end)
