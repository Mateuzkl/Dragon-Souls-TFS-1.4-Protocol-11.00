local exhaust = {}
local exhaustTime = 2

local emoteMode = TalkAction("!emo", "!emote")
function emoteMode.onSay(player, words, param, type)
    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
    
    if param == "on" then
        player:setStorageValue(Storage.emoteStorage, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Emote mode activated - your messages will appear in orange")
        exhaust[playerId] = currentTime + exhaustTime
        return false
    elseif param == "off" then
        player:setStorageValue(Storage.emoteStorage, 0)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Emote mode deactivated - your messages will appear normal")
        exhaust[playerId] = currentTime + exhaustTime
        return false
    end
    
    player:popupFYI("Emote Mode System\n\nThis command allows you to change how your messages appear to other players.\n\nCommands available:\n!emo on - Activate emote mode (orange messages)\n!emo off - Deactivate emote mode (normal messages)\n\nWhen emote mode is ON:\n- Your messages will appear in orange color\n- Messages look like monster speech\n- More visible and eye-catching\n\nWhen emote mode is OFF:\n- Your messages appear in normal white color\n- Standard chat appearance")
    exhaust[playerId] = currentTime + exhaustTime
    return false
end
emoteMode:separator(" ")
emoteMode:register()

local hiddenMode = TalkAction("!hide")
function hiddenMode.onSay(player, words, param, type)
    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
    
    if param == "on" then
        player:setStorageValue(Storage.hiddenStorage, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Hidden mode activated - you won't see or send chat messages")
        exhaust[playerId] = currentTime + exhaustTime
        return false
    elseif param == "off" then
        player:setStorageValue(Storage.hiddenStorage, 0)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Hidden mode deactivated - chat messages restored")
        exhaust[playerId] = currentTime + exhaustTime
        return false
    end
    
    player:popupFYI("Hidden Chat System\n\nThis command allows you to hide all chat messages for a peaceful experience.\n\nCommands available:\n!hide on - Activate hidden mode\n!hide off - Deactivate hidden mode\n\nWhen hidden mode is ON:\n- You won't see any chat messages from other players\n- You won't be able to send chat messages\n- Perfect for focused gameplay without distractions\n- Private messages and system messages may still appear\n\nWhen hidden mode is OFF:\n- Normal chat functionality restored\n- You can see and send messages normally")
    exhaust[playerId] = currentTime + exhaustTime
    return false
end
hiddenMode:separator(" ")
hiddenMode:register()

local allMode = TalkAction("!emohide")
function allMode.onSay(player, words, param, type)
    local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
    
    if param == "on" then
        player:setStorageValue(Storage.emoteStorage, 1)
        player:setStorageValue(Storage.hiddenStorage, 1)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "All modes activated - emote mode (orange messages) and hidden mode (no chat)")
        exhaust[playerId] = currentTime + exhaustTime
        return false
    elseif param == "off" then
        player:setStorageValue(Storage.emoteStorage, 0)
        player:setStorageValue(Storage.hiddenStorage, 0)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "All modes deactivated - normal chat restored")
        exhaust[playerId] = currentTime + exhaustTime
        return false
    end
    
    player:popupFYI("Combined Chat System\n\nThis command controls both Emote Mode and Hidden Mode simultaneously.\n\nCommands available:\n!emohide on - Activate both modes\n!emohide off - Deactivate both modes\n\nWhen activated (ON):\n- Emote Mode: Your messages appear in orange\n- Hidden Mode: You won't see other players' chat\n- Perfect for roleplay or focused gameplay\n\nWhen deactivated (OFF):\n- Both systems return to normal\n- Standard white chat messages\n- Full chat visibility restored\n\nIndividual Controls:\n- Use !emo on/off for emote mode only\n- Use !hide on/off for hidden mode only")
    exhaust[playerId] = currentTime + exhaustTime
    return false
end
allMode:separator(" ")
allMode:register()
