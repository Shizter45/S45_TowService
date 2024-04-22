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
    TriggerEvent('chat:addMessage', {
      color = {252,185,51},
      multiline = true,
      args = {'[TOW DISPATCH]', 'Congrats you are now off duty!'}
    })
  else
    active = true
    TriggerEvent('chat:addMessage', {
      color = {252,185,51},
      multiline = true,
      args = {'[TOW DISPATCH]', 'Congrats you are now on duty!'}
    })
  end
end)

-- command for players to request tows
RegisterCommand('request-tow', function()
  local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)))
  TriggerServerEvent('S45_TowService:Request', vehicleName)
end)

RegisterNetEvent('S45_TowService:notify')
AddEventHandler('S45_TowService:notify', function(requestor, vehicle)
  if active then
    TriggerEvent('chat:addMessage', {
        color = {252,185,51},
        multiline = true,
        args = {'[TOW DISPATCH]', '^4^*' .. requestor .. '^r^7 has requested a tow truck for a ^6^*'.. vehicle}
      })
  end
end)