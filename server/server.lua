-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if Config.Framework == 'esx' then 
    ESX = exports.es_extended:getSharedObject()
elseif Config.Framework == 'qbcore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

CreateCallback = function(name, cb)
    if Config.Framework == 'esx' then 
        ESX.RegisterServerCallback(name, cb)
    elseif Config.Framework == 'qbcore' then
        QBCore.Functions.CreateCallback(name, cb)
    end
end


CreateCallback('wasabi_nfc:checkPhone', function(source, cb)
    if not Config.PhoneItem then
        cb(true)
    else
        if Config.Framework == 'esx' then  
            local xPlayer = ESX.GetPlayerFromId(source)
            local xItem = xPlayer.getInventoryItem(Config.PhoneItem)
            if xItem.count > 0 then
                cb(true)
            else
                cb(false)
            end
        else
            local Player = QBCore.Functions.GetPlayer(source)
            local phoneItem = Player.Functions.GetItemByName(Config.PhoneItem)
            if phoneItem and phoneItem.amount > 0 then
                cb(true)
            else
                cb(false)
            end
        end
    end
end)

CreateCallback('wasabi_nfc:confirmPayment', function(source, cb, id, amount)
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        local xName = xPlayer.getName()
        local zPlayer = ESX.GetPlayerFromId(id)
        local zName = zPlayer.getName()
        local xBank = xPlayer.getAccount('bank').money
        if xBank < amount then
            cb(false)
        else
            xPlayer.removeAccountMoney('bank', amount)
            zPlayer.addAccountMoney('bank', amount)
            TriggerClientEvent('wasabi_nfc:notifyReceiver', id, xName, amount)
            cb(zName)
        end
    else
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local xName = xPlayer.PlayerData.name
        local zPlayer = QBCore.Functions.GetPlayer(id)
        local zName = zPlayer.PlayerData.name
        local xBank = xPlayer.PlayerData.money["bank"]
        
        if xBank < amount then
            cb(false)
        else
            xPlayer.Functions.RemoveMoney('bank', amount)
            zPlayer.Functions.AddMoney('bank', amount)
            TriggerClientEvent('nfc:notifyReceiver', id, xName, amount)
            cb(zName)
        end    
end)

addCommas = function(n)
	return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
								  :gsub(",(%-?)$","%1"):reverse()
end