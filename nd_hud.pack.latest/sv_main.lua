local QBCore = exports['qb-core']:GetCoreObject()
local ResetStress = false

RegisterNetEvent('hud:server:GainStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not Player or (HUD.DisablePoliceStress and Player.PlayerData.job.name == 'police') then
        return
    end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] + amount
        if newStress <= 0 then
            newStress = 0
        end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('QBCore:Notify', src, HUD.stressgain, 'error', 1500)
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not Player then
        return
    end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then
            newStress = 0
        end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('QBCore:Notify', src, HUD.stressremoved)
end)



--Commands


lib.addCommand('cash', {
    help = HUD.commandhelp2,
}, function(source, args, raw)
    local Player = QBCore.Functions.GetPlayer(source)
    local cashamount = Player.PlayerData.money.cash
    --TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
    TriggerClientEvent('QBCore:Notify', source, cashamount.. ' $', 'inform', 1500)
end)


lib.addCommand('bank', {
    help = HUD.commandhelp1,
}, function(source, args, raw)
    local Player = QBCore.Functions.GetPlayer(source)
    local bankamount = Player.PlayerData.money.bank
    --TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankamount)
    TriggerClientEvent('QBCore:Notify', source, bankamount.. ' $', 'inform', 1500)
end)