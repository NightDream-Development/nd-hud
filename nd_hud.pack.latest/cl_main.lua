local hunger = 100
local thirst = 100
local stress = 0
local loaded = false
local show = false
local seatbeltOn = false
local BlurIntensity = math.random(700, 900)
local voicestat = MumbleIsConnected()
voice3 = 50
   -- print('QB MODE ACTIVE')
    local QBCore = exports['qb-core']:GetCoreObject()
    local PlayerData = QBCore.Functions.GetPlayerData()

    RegisterNetEvent('hud:client:UpdateNeeds')
    AddEventHandler('hud:client:UpdateNeeds', function(newHunger, newThirst)
        hunger = math.min(newHunger, 100)
        thirst = math.min(newThirst, 100)
    end)

    RegisterNetEvent('seatbelt:client:ToggleSeatbelt')
    AddEventHandler('seatbelt:client:ToggleSeatbelt', function()
        seatbeltOn = not seatbeltOn
        if seatbeltOn then
            QBCore.Functions.Notify(HUD.buckled, nil, 5000)
        else
            QBCore.Functions.Notify(HUD.unbuckled, 'error', 5000)
        end
    end)

    RegisterNetEvent('hud:client:UpdateNitrous')
    AddEventHandler('hud:client:UpdateNitrous', function(_, nitroLevel, bool)
        nos = nitroLevel
        nitroActive = bool
    end)

    RegisterNetEvent('hud:client:UpdateStress')
    AddEventHandler('hud:client:UpdateStress', function(newStress)
        stress = newStress
        --print('new stress: '..newStress)
    end)

    Citizen.CreateThread(function()
        while true do
           -- print(stress)
            if stress > 30 then
                --print('running stress effect')
                local FallRepeat = math.random(2, 4)
                local RagdollTimeout = FallRepeat * 1750
                TriggerScreenblurFadeIn(1000.0)
                Citizen.Wait(math.random(700, 900))
                TriggerScreenblurFadeOut(1000.0)
            end
            if stress > 70 then
                Citizen.Wait(30000)
            else
                Citizen.Wait(math.random(9000, 250000))
            end
        end
    end)

    Citizen.CreateThread(function()
        while true do
            if LocalPlayer.state.isLoggedIn then
                local ped = PlayerPedId()
                if IsPedInAnyVehicle(ped, false) then
                    local veh = GetVehiclePedIsIn(ped, false)
                    local vehClass = GetVehicleClass(veh)
                    local speed = GetEntitySpeed(veh) * HUD.calculating

                    if vehClass ~= 13 and vehClass ~= 14 and vehClass ~= 15 and vehClass ~= 16 and vehClass ~= 21 then
                        local stressSpeed
                        if vehClass == 8 then
                            stressSpeed = HUD.MinimumSpeed
                        else
                            stressSpeed = seatbeltOn and HUD.MinimumSpeed or HUD.MinimumSpeedUnbuckled
                        end
                        if speed >= stressSpeed then
                            TriggerServerEvent('hud:server:GainStress', math.random(1, 1))
                        end
                    end
                end
            end
            Citizen.Wait(100000)
        end
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
        Wait(2000)
        loaded = true
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
        -- Wait(2000)
        local hunger = 100
        local thirst = 100
        local stress = 0
         loaded = false
    end)

    RegisterNetEvent('hud:client:OnMoneyChange', function(type, amount, isMinus)
        cashAmount = PlayerData.money['cash']
        bankAmount = PlayerData.money['bank']
    
        if type == 'cash' then
            local cashDifference = amount
            if isMinus then
                cashDifference = -cashDifference
            end
            cashAmount = cashAmount + cashDifference

    
            if cashDifference < 0 then
                QBCore.Functions.Notify(HUD.removemoney..': $' .. math.abs(cashDifference), 'error', 5000)
            elseif cashDifference > 0 then
                QBCore.Functions.Notify(HUD.getemoney..': $' .. cashDifference, 'success', 5000)
            end
        elseif type == 'bank' then
            local bankDifference = amount
            if isMinus then
                bankDifference = -bankDifference
            end
            bankAmount = bankAmount + bankDifference
    
            if bankDifference < 0 then
                QBCore.Functions.Notify(HUD.bankremove..': $' .. math.abs(bankDifference), 'error', 5000)
            elseif bankDifference > 0 then
                QBCore.Functions.Notify(HUD.bankget..': $' .. bankDifference, 'success', 5000)
            end
        end
    end)

    local talkingonradio = false
    AddEventHandler("pma-voice:radioActive", function(isRadioTalking)
        talkingonradio = isRadioTalking
    end)

    if HUD.radioanimation then
    local previousState = false
    local playinganim = false
    CreateThread(function()
        while true do
            RequestAnimDict("cellphone@")
            Wait(100) 
            if talkingonradio ~= previousState then
                previousState = talkingonradio
                if talkingonradio then
                    local ped = cache.ped
                    radioProp = CreateObject(GetHashKey("prop_cs_hand_radio"), 1.0, 0.0, 0.0, true, true, true)
                    AttachEntityToEntity(radioProp, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 80.0, 0.0, 80.0, true, true, false, true, 1, true)
                    TaskPlayAnim(ped, "cellphone@", "cellphone_text_to_call", 8.0, -8, -1, 50, 0, false, false, false)
                else
                    ClearPedTasks(cache.ped)
                    DetachEntity(radioProp, true, true)
                    DeleteObject(radioProp)
                    SetPedMovementClipset(cache.ped, 'move_m@bag')
                    ResetPedWeaponMovementClipset(cache.ped)
                    ResetPedStrafeClipset(cache.ped)
                end
            end
        end
    end)
end

CreateThread(function()
    while true do
        if loaded == true then
        Wait(100)
        if IsPauseMenuActive() then
            show = false
        else
            show = true
        end
    end
    end
end)




--status
CreateThread(function()
    while true do
        local fuelszint = fuellevel
        local playerId = PlayerId()
        local player = PlayerPedId()
            AddEventHandler('pma-voice:setTalkingMode', function(voiceMode) 
                --print(voiceMode)
                if voiceMode == 2 then
                    --SendNUIMessage({voice = 50})
                    voice3= 50
                else
                    if voiceMode == 3 then
                        --SendNUIMessage({voice = 100})
                        voice3= 100
                else
                    if voiceMode == 1 then
                        --SendNUIMessage({voice = 25})
                        voice3= 25
                    end
                end
                end
            end)
            --print(voice3)
            if not IsEntityInWater(player) then
                local oxygen = 100 - GetPlayerSprintStaminaRemaining(playerId)
                -- 0.2.0 fixed stamina jitter in veh
                local staminahud
                if oxygen >= 100 then
                    staminahud = false
                else
                    staminahud = true
                end
                -- 0.2.1 fixed armour jitter in veh
                local armouron
                if GetPedArmour(player) >= 0 and GetPedArmour(player) <= 5 then
                    armouron = true
                else
                    armouron = false
                end

                if stress >= 0 and stress <= 5 then
                    stressshow1 = false
                  else
                    stressshow1 = true
                  end              
                SendNUIMessage({
                    toggle = show,
                    armour = GetPedArmour(player),
                    armouroff = armouron,
                    health = GetEntityHealth(player) - 100,
                    hunger = math.floor(hunger),
                    thirst = math.floor(thirst),
                    voice = voice3,
                    radio = talkingonradio,
                    togglefuel = IsRadarEnabled(),
                    talking = NetworkIsPlayerTalking(playerId),
                    stamina = oxygen,
                    stress = stress,
                    armouroff = armouron,
                    stressshow = stressshow1,
                    staminaoff = staminahud,
                    config = {HUD.health, HUD.armour, HUD.hunger, HUD.thirst, HUD.voice, HUD.fuel, HUD.stamina, HUD.stress}
                })
            end
        Wait(100)
    end
end)

-- Térkép
local showui = false
CreateThread(function()
    Wait(100)
    while true do
        local radarEnabled = IsRadarEnabled()
        local player = PlayerPedId()
        if not IsPedInAnyVehicle(player) and radarEnabled then
            SendNUIMessage({
                action = 'notinveh'
            })
            showui = false
            DisplayRadar(false)
        elseif IsPedInAnyVehicle(player) and not radarEnabled then
            if showui == true then
                --
            else
                showui = true
                if HUD.rcalert then
                    TriggerEvent('rc_alert:startAlert', 5000, HUD.alerttitle, HUD.alertdesc)
                end
            end
            CreateThread(function()
                while cache.vehicle do
                    local fuellevel = math.floor(GetVehicleFuelLevel(cache.vehicle))
                    SendNUIMessage({
                        fuel = fuellevel
                    })
                    -- print(fuellevel)
                    Wait(1000)
                end
            end)
            SendNUIMessage({
                action = 'inveh'
            })

            DisplayRadar(true)
        end
        Wait(500)
    end
end)

-- voice is on or off
if HUD.voiceerroronoroff then
CreateThread(function()
    while true do
        if MumbleIsConnected() == false then

            local alert = lib.alertDialog({
                header = 'ND-HUD',
                content = HUD.voiceerror,
                centered = true,
                cancel = false
            })
                lib.alertDialog(alert)
        else
            --print('Voice is enabled!')
        end
        Wait(60000)
    end
end)
end

-- N törlése
CreateThread(function()
    SetBlipAlpha(GetNorthRadarBlip(), 0)
end)

-- ZOOM FIX
Citizen.CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Citizen.Wait(100)
        SetRadarZoom(1100)
    end
end)

-- Kicsibe fasz
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        SetBigmapActive(false, false)
    end
end)

-- Azért legyen eszed
Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end)


