RegisterServerEvent('S45_TowService:Request')
AddEventHandler('S45_TowService:Request', function(vehicle)
  local playerId = source
  local playerName = GetPlayerName(playerId)
  
  TriggerClientEvent('S45_TowService:notify', -1, playerName, vehicle)
  print(playerName .. ' has requested a tow for a ' .. vehicle)
end)
