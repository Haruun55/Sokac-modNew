  
Promet = 0.2
NPCOVI = 1.9
ParkiranaVozila = 0.1
EnableDispatch = false
EnableBoats = false
EnableTrains = false
EnableGarbageTrucks = false
UkljuciPoliciju = false

CreateThread(function()
  for i = 1, 15 do
   EnableDispatchService(i, EnableDispatch)
  end
  SetRandomBoats(EnableBoats)
  SetRandomTrains(EnableTrains)
  SetGarbageTrucks(EnableGarbageTrucks)
  SetCreateRandomCops(UkljuciPoliciju)
  SetCreateRandomCopsNotOnScenarios(UkljuciPoliciju)
  SetCreateRandomCopsOnScenarios(UkljuciPoliciju)
  SetDispatchCopsForPlayer(PlayerId(), UkljuciPoliciju)
  SetPedPopulationBudget(NPCOVI)
  SetVehiclePopulationBudget(Promet)
  SetNumberOfParkedVehicles(ParkiranaVozila)
end)