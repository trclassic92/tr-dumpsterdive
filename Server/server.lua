local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('tr-dumpsterdive:SmallDumpsterTimer', function(SmallTrash)
    smallTimer(source, SmallTrash)
end)

RegisterNetEvent('tr-dumpsterdive:smallBins', function()
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    local FoundItem = Config.SmallBinRewards["items"][math.random(1, #Config.SmallBinRewards["items"])]
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[FoundItem[1]], "add")
    player.Functions.AddItem(FoundItem[1], FoundItem[2])
end)

RegisterNetEvent('tr-dumpsterdive:smallBinsMoney', function()
    local source = source
    local cashAmount = math.random(Config.SmallBinRewards.CashMin, Config.SmallBinRewards.CashMax)
    local player = QBCore.Functions.GetPlayer(source)
    player.Functions.AddMoney("cash", cashAmount)
end)

function smallTimer(id, object)
    local timer = 10 * 1000
    while timer > 0 do
        Wait(10)
        timer = timer - 10
        if timer == 0 then
            TriggerClientEvent('tr-dumpsterdive:SmallBinRemove', id, object)
        end
    end
end

RegisterServerEvent('tr-dumpsterdive:RemoveDumpster', function(BigTrash)
    bigTimer(source, BigTrash)
end)

RegisterNetEvent('tr-dumpsterdive:Bigbins', function()
    local source = source
    local player = QBCore.Functions.GetPlayer(source)
    local FoundItem = Config.BigBinRewards["items"][math.random(1, #Config.BigBinRewards["items"])]
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[FoundItem[1]], "add")
    player.Functions.AddItem(FoundItem[1], FoundItem[2])
end)

RegisterNetEvent('tr-dumpsterdive:BigbinsMoney', function()
    local source = source
    local cashAmount = math.random(Config.BigBinRewards.CashMin, Config.BigBinRewards.CashMax)
    local player = QBCore.Functions.GetPlayer(source)
    player.Functions.AddMoney("cash", cashAmount)
end)

function bigTimer(id, object)
    local timer = 10 * 1000
    while timer > 0 do
        Wait(10)
        timer = timer - 10
        if timer == 0 then
            TriggerClientEvent('tr-dumpsterdive:BigBinRemove', id, object)
        end
    end
end