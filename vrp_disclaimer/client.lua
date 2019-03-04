
----------------------------- CONFIG - MODIFICA TOT ----------------------------

local spawn = {1.0, 2.0, 3.0} -- locatia unde te duce dupa ce termini test-ul

local config = { -- poti sa adaugi absolut cati pasi vrei tu aici
  {
    x = 173.01181030273,
    y = -1391.4141845703,
    z = 29.408880233765,
    heading = 120.0,
    title = "Test titlu fain",
    text = "test text lung<br/><br/>asta e paragraf-ul al doilea nuj idk ar trebuii sa schimbi tu asta aici",
    secunde = 15
  },
  {
    x = -428.49026489258,
    y = -993.306640625,
    z = 46.008815765381,
    heading = 255.0,
    title = "Editeaza tu pe aici",
    text = "Am incercat sa fac totul sa fie cat mai usor de folosit asa ca un config usor<br/><br/>Heading-ul e defapt unghiul la care se muta camera inveti tu repede sa il folosesti",
    secunde = 10
  }
}

------------------------------- CODE - NU ATINGE -------------------------------

local inTutorial = false

RegisterNetEvent("disclaimer:start")
AddEventHandler("disclaimer:start", function()
  startTutorial()
end)

function startTutorial()
  Citizen.Wait(10000)
  local myPed = GetPlayerPed(-1)
  inTutorial = true

  for _,v in pairs(config) do
    SetEntityCoords(myPed, v.x, v.y, v.z, true, false, false, true)
  	if math.type(v.heading) ~= "float" then
  	  v.heading = v.heading * 10
  	  v.heading = v.heading / 10
  	end
    SetGameplayCamRelativeHeading(v.heading)
    TriggerEvent("pNotify:SendNotification",{
  	  text = "<b style='color:#A52A2A'>".. v.title .."</b> <br /><br /><p style='color:#f9f9f9'>".. v.text .."</p>",
  	  type = "alert",
  	  timeout = (v.secunde * 1000),
  	  layout = "center",
  	  queue = "global"
  	})
    Citizen.Wait(v.secunde * 1000 + 1500)
  end

  SetEntityCoords(myPed, spawn[1], spawn[2], spawn[3], true, false, false, true)
  SetEntityVisible(myPed, true)
  FreezeEntityPosition(myPed, false)
  inTutorial = false
end

Citizen.CreateThread(function()
  while true do
    if inTutorial then
      local ply = GetPlayerPed(-1)
      local active = true
      SetEntityVisible(ply, false)
      FreezeEntityPosition(ply, true)
      DisableControlAction(0, 1, active)
      DisableControlAction(0, 2, active)
      DisablePlayerFiring(ply, true)
      DisableControlAction(0, 142, active)
      DisableControlAction(0, 106, active)
    end
    Citizen.Wait(0)
  end
end)
