local QBCore = exports['qb-core']:GetCoreObject()
local SmallBins = Config.SmallBinProps
local BigBins = Config.BigBinProps
local canSearch = true
local alreadySearched = {192192192192}

RegisterNetEvent('tr-dumpsterdive:SearchSmallTrash', function()
    if canSearch then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local smallTrashFound = false
        for i = 1, #SmallBins do
            local SmallTrash = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, SmallBins[i], false, false, false)
            local dumpPos = GetEntityCoords(SmallTrash)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)
            if dist < 1.5 then
                for i = 1, #alreadySearched do
                    if alreadySearched[i] == SmallTrash then
                        smallTrashFound = true
                    end
                    if i == #alreadySearched and smallTrashFound then
                        QBCore.Functions.Notify(Config.Text["SmallTrashAlreadySearched"], 'error')
                    elseif i == #alreadySearched and not smallTrashFound then

                    local itemType = math.random(#Config.BinRewards)
                    TriggerEvent('tr-dumpsterdive:SmallTrashBar',itemType)
                    TriggerServerEvent('tr-dumpsterdive:SmallDumpsterTimer', SmallTrash)
                    table.insert(alreadySearched, SmallTrash)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('tr-dumpsterdive:SmallBinRemove', function(object)
    for i = 1, #alreadySearched do
        if alreadySearched[i] == object then
            table.remove(alreadySearched, i)
        end
    end
end)

exports['qb-target']:AddTargetModel(SmallBins, {
    options = {
    {
      type = "client",
      event = "tr-dumpsterdive:SearchSmallTrash",
      icon = Target.IconsHighLight["smallBins"],
      label = Target.Label["smallBins"],
      targeticon = Target.Icon["smallBins"],
    }
  },
  distance = Config.Distance,
})

RegisterNetEvent('tr-dumpsterdive:SmallTrashBar', function(itemType)
    QBCore.Functions.Progressbar("trash_find", Config.Text["SearchingTrash"], Config.SmallBinTimer * 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        local seconds = math.random(Config.MiniGame.SmallbinTimer.Min, Config.MiniGame.SmallbinTimer.Max)
        local circles = math.random(Config.MiniGame.SmallBinCircles.Min, Config.MiniGame.SmallBinCircles.Max)
        local success = exports["qb-lock"]:StartLockPickCircle(circles, seconds)
        if success then
            if Config.BinRewards[itemType].type == "item" then
                QBCore.Functions.Notify(Config.Text["FoundSomething"], "success")
                TriggerServerEvent('tr-dumpsterdive:smallBins')
            elseif Config.BinRewards[itemType].type == "cash" then
                QBCore.Functions.Notify(Config.Text["FoundCash"], "success")
                TriggerServerEvent('tr-dumpsterdive:smallBinsMoney')
            elseif Config.BinRewards[itemType].type == "nothing" then
                QBCore.Functions.Notify(Config.Text["FoundNothing"], "error")
            end
        else
            QBCore.Functions.Notify(Config.Text["FoundNothing"], "error")
        end
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
    end)
end)


-- Big Trash Bins aka Dumpster Stuff
RegisterNetEvent('tr-dumpsterdive:SearchBigTrash', function()
    if canSearch then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local BigTrashFound = false
        for i = 1, #BigBins do
            local BigTrash = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, BigBins[i], false, false, false)
            local dumpPos = GetEntityCoords(BigTrash)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)
            if dist < 1.5 then
                for i = 1, #alreadySearched do
                    if alreadySearched[i] == BigTrash then
                        BigTrashFound = true
                    end
                    if i == #alreadySearched and BigTrashFound then
                        QBCore.Functions.Notify(Config.Text["BigDumsterAlreadySerached"], 'error')
                    elseif i == #alreadySearched and not BigTrashFound then

                    local itemType = math.random(#Config.BinRewards)
                    TriggerEvent('tr-dumpsterdive:BigDumpster',itemType)
                    TriggerServerEvent('tr-dumpsterdive:RemoveDumpster', BigTrash)
                    table.insert(alreadySearched, BigTrash)
                    end
                end
            end
        end
    end
end)

exports['qb-target']:AddTargetModel(BigBins, {
    options = {
    {
      type = "client",
      event = "tr-dumpsterdive:SearchBigTrash",
      icon = Target.IconsHighLight["bigBins"],
      label = Target.Label["bigBins"],
      targeticon = Target.Icon["bigBins"],
    }
  },
  distance = Config.Distance,
})

RegisterNetEvent('tr-dumpsterdive:BigBinRemove', function(object)
    for i = 1, #alreadySearched do
        if alreadySearched[i] == object then
            table.remove(alreadySearched, i)
        end
    end
end)

RegisterNetEvent('tr-dumpsterdive:BigDumpster', function(itemType)
    QBCore.Functions.Progressbar("trash_find", Config.Text["SearchDumpster"], Config.DumpsterTimer * 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bum_bin@idle_b",
        anim = "idle_d",
        flags = 16,
    }, {}, {}, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
        local seconds = math.random(Config.MiniGame.BigBinTimer.Min, Config.MiniGame.BigBinTimer.Max)
        local circles = math.random(Config.MiniGame.BigBinCircles.Min, Config.MiniGame.BigBinCircles.Max)
        local success = exports["qb-lock"]:StartLockPickCircle(circles, seconds)
        if success then
            if Config.BinRewards[itemType].type == "item" then
                QBCore.Functions.Notify(Config.Text["FoundSomething"], "success")
                    TriggerServerEvent('tr-dumpsterdive:Bigbins')
            elseif Config.BinRewards[itemType].type == "cash" then
                QBCore.Functions.Notify(Config.Text["FoundCash"], "success")
                if success then
                    TriggerServerEvent('tr-dumpsterdive:BigbinsMoney')
                else
                    QBCore.Functions.Notify(Config.Text["FoundNothing"], "error")
                end
            elseif Config.BinRewards[itemType].type == "nothing" then
                QBCore.Functions.Notify(Config.Text["FoundNothing"], "error")
            end
        else
            QBCore.Functions.Notify(Config.Text["FoundNothing"], "error")
        end
    end, function()
        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 1.0)
    end)
end)
