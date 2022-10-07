-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('wasabi_nfc:checkPhone', function(source, cb)
    if not Config.PhoneItem then
        cb(true)
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        local xItem = xPlayer.getInventoryItem(Config.PhoneItem)
        if xItem.count > 0 then
            cb(true)
        else
            cb(false)
        end
    end
end)

ESX.RegisterServerCallback('wasabi_nfc:confirmPayment', function(source, cb, id, amount)
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
end)

addCommas = function(n)
	return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
								  :gsub(",(%-?)$","%1"):reverse()
end