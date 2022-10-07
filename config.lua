-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

Config = {}

Config.checkForUpdates = true -- Check for Updates?

Config.PhoneItem = 'phone' -- Item required to have to NFC transfer(Phone by default. Can be set to 'false' if phone requirement not desired.)

Config.TransferLimit = false -- Transfer limit? If not set to false. Other wise set to amount (i.e. 500000).

Strings = {
    ['nfc_transfer'] = "NFC Transfer",

    ['received_funds'] = "Money Received!",
    ['received_funds_desc'] = "You\'ve successfully received $%s from %s.",

    ['money_sent'] = "Money Sent!",
    ['money_sent_desc'] = "You\'ve successfully sent $%s to %s.",

    ['no_phone'] = "No Phone",
    ['no_phone_desc'] = "You must have a phone to do this!",

    ['error'] = "Error",
    ['error_no_funds'] = "You don\'t have the funds for this transaction!",
    ['error_no_nearby'] = "No nearby players",
    ['error_transfer_limit'] = "The amount entered was above the transfer limit!",
    ['error_invalid_amount'] = "Invalid Amount!",

    ['amount'] = "Amount"
}