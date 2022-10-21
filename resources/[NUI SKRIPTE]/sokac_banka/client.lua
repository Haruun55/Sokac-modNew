local bankLoc = {
  vector3(149.83, -1040.81, 29.37),
  vector3(-1212.63, -330.79, 37.79),
  vector3(-2962.50, 483.04, 15.70),
  vector3(-111.97, 6469.20, 31.63),
  vector3(314.31, -279.23, 54.17),
  vector3(-350.85, -50.04, 49.04),
  vector3(246.58, 223.53, 106.29), -------------->>> GLAVNA BANKA
  vector3(1174.96, 2706.89, 38.09),
}

for i = 1, #bankLoc do
  local Blip = AddBlipForCoord(bankLoc[i])
  SetBlipSprite (Blip, 272)
  SetBlipDisplay(Blip, 4)
  SetBlipScale  (Blip, 0.8)
  SetBlipColour (Blip, 5)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Banka")
  EndTextCommandSetBlipName(Blip)
end



function OpenBanka(vrsta)

  local RegisteredData = TriggerServerCallback("element_bankomat:GetMoneyData")

  SendNUIMessage({
    action = "firstOpen",
    data = RegisteredData,
    vrsta = vrsta,
    name = RegisteredData.firstname .. " " .. RegisteredData.lastname
  })
  SetNuiFocus(true, true)

end

RNE("element_bankomat:open", function()
  OpenBanka("bankomat")
end)


RNE("element_bankomat:open2", function()
  OpenBanka("banka")
end)

RegisterNUICallback("close", function()
  SetNuiFocus(false, false)
end)

RNE("element_bankomat:UpdateData", function(RegisteredData)

  local RegisteredData = TriggerServerCallback("element_bankomat:GetMoneyData")

  SendNUIMessage({
    action = "updateData",
    data = RegisteredData
  })

end)


RegisterNUICallback("withdraw", function(data)
  
  if data.amount > 0 then
    TSE("element_bankomat:withdraw", data.amount)
    TE("element_bankomat:UpdateData")
  end
end)

RegisterNUICallback("deposit", function(data)
  if data.amount > 0 then
    TSE("element_bankomat:deposit", data.amount)
    TE("element_bankomat:UpdateData")
  end
end)

RegisterNUICallback("transfer", function(data)
  if data.amount > 0 and GetPlayerServerId(PlayerId()) ~= data.id then
    print(data.id)

    TSE("element_bankomat:transfer", data.amount, data.id)
  end
end)


atmnames = {  

  3168729781,
  2930269768,
  3424098598,
  506770882,
  -1126237515,
  -1364697528,
  -870868698
}
exports.qtarget:AddTargetModel(atmnames, {
  options = {
      {
          event = "element_bankomat:open",
          icon = "fas fa-credit-card",
          label = "Bankomat",
      },
  },
  distance = 2
})



exports.qtarget:AddBoxZone("banka1", vector3(149.1, -1040.83, 29.37), 0.2, 6.0, {
	name="banka1",
	heading=341,
	debugPoly=false,
    minZ=27.30,
    maxZ=31.50
	}, {
		options = {
			{
				event = "element_bankomat:open2",
				icon = "fas fa-sign-in-alt",
				label = "Banka",
			}
		},
		distance = 5.5
})

exports.qtarget:AddBoxZone("banka2", vector3(-1213.02, -331.53, 37.79), 5.6, 0.6, {
	name="banka2",
	heading=298,
	debugPoly=false,
    minZ=36.30,
    maxZ=39.50
	}, {
		options = {
			{
				event = "element_bankomat:open2",
				icon = "fas fa-sign-in-alt",
				label = "Banka",
			}
		},
		distance = 5.5
})

exports.qtarget:AddBoxZone("banka3", vector3(-2961.85, 482.28, 15.7), 6.4, 0.8, {
	name="banka3",
	heading=358,
	debugPoly=false,
    minZ=14.30,
    maxZ=17.50
	}, {
		options = {
			{
				event = "element_bankomat:open2",
				icon = "fas fa-sign-in-alt",
				label = "Banka",
			}
		},
		distance = 5.5
})


exports.qtarget:AddBoxZone("banka4", vector3(-112.06, 6470.01, 31.63), 0.8, 6.4, {
	name="banka4",
	heading=135,
	debugPoly=false,
    minZ=30.30,
    maxZ=32.50
	}, {
		options = {
			{
				event = "element_bankomat:open2",
				icon = "fas fa-sign-in-alt",
				label = "Banka",
			}
		},
		distance = 5.5
})

exports.qtarget:AddBoxZone("banka5", vector3(313.47, -279.43, 54.17), 0.6, 6.2, {
	name="banka5",
	heading=340,
	debugPoly=false,
    minZ=53.30,
    maxZ=55.50
	}, {
		options = {
			{
				event = "element_bankomat:open2",
				icon = "fas fa-sign-in-alt",
				label = "Banka",
			}
		},
		distance = 5.5
})

exports.qtarget:AddBoxZone("banka6", vector3(-351.75, -50.28, 49.04), 0.6, 5.8, {
	name="banka6",
	heading=341,
	debugPoly=false,
    minZ=48.30,
    maxZ=52.50
	}, {
		options = {
			{
				event = "element_bankomat:open2",
				icon = "fas fa-sign-in-alt",
				label = "Banka",
			}
		},
		distance = 5.5
})

exports.qtarget:AddBoxZone("banka7", vector3(247.37, 223.84, 106.29), 0.8, 14.6,{
	name="banka7",
	heading=340,
	debugPoly=false,
    minZ=105.30,
    maxZ=108.50
	}, {
		options = {
			{
				event = "element_bankomat:open2",
				icon = "fas fa-sign-in-alt",
				label = "Banka",
			}
		},
		distance = 5.5
})

exports.qtarget:AddBoxZone("banka7", vector3(1175.68, 2707.61, 38.09), 6.2, 1.0,{
	name="banka7",
	heading=270,
	debugPoly=false,
    minZ=37.30,
    maxZ=39.50
	}, {
		options = {
			{
				event = "element_bankomat:open2",
				icon = "fas fa-sign-in-alt",
				label = "Banka",
			}
		},
		distance = 5.5
})


