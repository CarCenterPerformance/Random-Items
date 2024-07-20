ESX = exports["es_extended"]:getSharedObject()

for _, item in ipairs(Config.UsableItems) do
    ESX.RegisterUsableItem(item, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(item, 1)
        local reward = GetRandomReward()
        
        if reward then
            xPlayer.addInventoryItem(reward, 1)
            TriggerClientEvent('esx:showNotification', source, 'You received a ' .. reward .. '!')
        else
            TriggerClientEvent('esx:showNotification', source, 'You did not receive any item.')
        end
    end)
end

function GetRandomReward()
    local totalWeight = 0
    for _, reward in ipairs(Config.RewardItems) do
        totalWeight = totalWeight + reward.chance
    end

    local randomWeight = math.random(0, totalWeight)
    local currentWeight = 0

    for _, reward in ipairs(Config.RewardItems) do
        currentWeight = currentWeight + reward.chance
        if randomWeight <= currentWeight then
            return reward.item
        end
    end

    return nil
end
