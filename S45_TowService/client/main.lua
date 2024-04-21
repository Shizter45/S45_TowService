-- Chat Suggestions
TriggerEvent('chat:addSuggestions', {
  {
    name='/tow-duty',
    help='Allows you to toggle if you want to receive calls for tows!'
  },
  {
    name='/request-tow',
    help='Allows you to call for a tow truck!'
  }
})

active = false
-- Command to toggle between active and inactive
RegisterCommand('tow-duty', function()
  if active then
    active = false
    Wait(1000)
    TriggerEvent("swt_notifications:Success",'Tow Dispatch','You are now inactive','right',5000,true)
  else
    active = true
    Wait(1000)
    TriggerEvent("swt_notifications:Success",'Tow Dispatch','You are now active','right',5000,true)
  end
end)

-- command for players to request tows
RegisterCommand('request-tow', function()
  local vehicleName = GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))

  TriggerServerEvent('S45_TowService:Request', vehicleName)
end)

RegisterNetEvent('S45_TowService:notify', function(requestor, vehicle)
  if active then
    TriggerEvent('chat:addMessage', {
      color = {242,192,55},
      multiline = true,
      args = {'[Tow Disptch]: ', '^*^5' .. player .. '^r^7 has requested a tow for a ^*^1' .. vehicle}
    })
  end
end)