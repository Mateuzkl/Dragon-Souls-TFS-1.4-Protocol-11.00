
local config = {
    opcode = 201,
    logFile = "data/logs/rewards.txt",

    basic = {
        storage = 642297,
        cooldown = 24 * 60 * 60,
        items = {
            {id = 38052, name = "exercise sword", charges = 8000},
            {id = 38053, name = "exercise axe", charges = 8000},
            {id = 38054, name = "exercise club", charges = 8000},
            {id = 38055, name = "exercise bow", charges = 8000},
            {id = 38056, name = "exercise rod", charges = 8000},
            {id = 38057, name = "exercise wand", charges = 8000}
        }
    },

    autoEvent = {
        enabled = true,
        days = {1, 3, 5},
        hour = 12,
        minute = 0
    }
}

local function logMessage(message)
    local file = io.open(config.logFile, "a")
    if file then
        file:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. message .. "\n")
        file:close()
    end
end

local function buildOpcodeBuffer()
    local buffer = "Show:"
    for i, reward in ipairs(config.basic.items) do
        local itemType = ItemType(reward.id)
        local clientId = (itemType and itemType:getClientId() and itemType:getClientId() > 0) 
            and itemType:getClientId() or reward.id
        local name = reward.name or (itemType and itemType:getName() or "Unknown")

        buffer = buffer .. reward.id .. "," .. clientId .. "," .. name
        if i < #config.basic.items then
            buffer = buffer .. ";"
        end
    end
    return buffer
end

local function canClaimReward(player)
    local lastClaimTime = player:getStorageValue(config.basic.storage)
    if lastClaimTime <= 0 then
        return true, 0
    end

    local timeSinceLastClaim = os.time() - lastClaimTime
    if timeSinceLastClaim >= config.basic.cooldown then
        return true, 0
    end

    return false, config.basic.cooldown - timeSinceLastClaim
end

local function formatTimeRemaining(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60

    if hours > 0 then
        return string.format("%dh %dm %ds", hours, minutes, secs)
    elseif minutes > 0 then
        return string.format("%dm %ds", minutes, secs)
    else
        return string.format("%ds", secs)
    end
end

local function resetAllCooldowns()
    db.query("DELETE FROM `player_storage` WHERE `key` = " .. config.basic.storage)
    local players = Game.getPlayers()
    local count = 0
    for _, player in ipairs(players) do
        player:setStorageValue(config.basic.storage, -1)
        count = count + 1
    end
    logMessage("Cooldowns reset: " .. count .. " players")
    return count
end

local function notifyPlayers(message)
    local players = Game.getPlayers()
    local buffer = buildOpcodeBuffer()
    local count = 0

    for _, player in ipairs(players) do
        local canClaim, _ = canClaimReward(player)
        if canClaim then
            player:sendExtendedOpcode(config.opcode, buffer)
            if message then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
            end
            count = count + 1
        end
    end
    return count
end

local function giveReward(player, itemId, charges)
    local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
    if not inbox then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Error: Store Inbox not found.")
        return false
    end

    if inbox:getEmptySlots() == 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Error: Store Inbox is full.")
        return false
    end

    local item = inbox:addItem(itemId, charges or 1)
    if item then
        item:setActionId(IMMOVABLE_ACTION_ID)
        return true
    end
    return false
end

local login = CreatureEvent("RewardSystemLogin")
function login.onLogin(player)
    player:registerEvent("RewardSystemOpcode")
    local canClaim, _ = canClaimReward(player)
    if canClaim then
        player:sendExtendedOpcode(config.opcode, buildOpcodeBuffer())
    end
    return true
end
login:type("login")
login:register()

local opcode = CreatureEvent("RewardSystemOpcode")
function opcode.onExtendedOpcode(player, opcodeReceived, buffer)
    if opcodeReceived ~= config.opcode then
        return
    end

    local canClaim, timeRemaining = canClaimReward(player)
    if not canClaim then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 
            "You need to wait " .. formatTimeRemaining(timeRemaining) .. " before claiming your next reward.")
        player:sendExtendedOpcode(config.opcode, "Hide")
        return
    end

    local itemId = tonumber(buffer)
    if not itemId then
        return
    end

    local validReward = nil
    for _, reward in ipairs(config.basic.items) do
        if reward.id == itemId then
            validReward = reward
            break
        end
    end

    if not validReward then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Invalid reward selected.")
        return
    end

    if giveReward(player, validReward.id, validReward.charges) then
        player:setStorageValue(config.basic.storage, os.time())
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 
            "You received your " .. validReward.name .. " in Store Inbox! You can claim again in 24 hours.")
        player:sendExtendedOpcode(config.opcode, "Hide")
        logMessage(player:getName() .. " claimed " .. validReward.name)
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Error creating item. Contact an administrator.")
    end
end
opcode:type("extendedopcode")
opcode:register()

local autoEvent = GlobalEvent("RewardSystemAutoEvent")
function autoEvent.onThink(interval)
    if not config.autoEvent.enabled then
        return true
    end

    local currentDay = tonumber(os.date("%w"))
    local currentHour = tonumber(os.date("%H"))
    local currentMinute = tonumber(os.date("%M"))

    local isCorrectDay = false
    for _, day in ipairs(config.autoEvent.days) do
        if day == currentDay then
            isCorrectDay = true
            break
        end
    end

    if isCorrectDay and currentHour == config.autoEvent.hour and currentMinute == config.autoEvent.minute then
        logMessage("Auto-event triggered")
        local reset = resetAllCooldowns()
        local notified = notifyPlayers("A special reward event has started! Check your reward window.")
        logMessage("Event: " .. reset .. " reset, " .. notified .. " notified")
        Game.broadcastMessage("A special reward event has started! Claim your free exercise weapon!", MESSAGE_EVENT_ADVANCE)
    end

    return true
end
autoEvent:interval(60000)
autoEvent:register()

local triggerEvent = TalkAction("/reward_event")
function triggerEvent.onSay(player, words, param)
    if player:getGroup():getId() < 3 then
        player:sendCancelMessage("You don't have permission.")
        return false
    end

    logMessage("Manual event by " .. player:getName())
    local reset = resetAllCooldowns()
    local notified = notifyPlayers("A GM started a reward event! Check your reward window.")

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 
        "Event triggered: " .. reset .. " reset, " .. notified .. " notified")

    Game.broadcastMessage("A GM started a reward event! Claim your free exercise weapon!", MESSAGE_EVENT_ADVANCE)
    return false
end
triggerEvent:separator(" ")
triggerEvent:register()

local checkStatus = TalkAction("/reward_status")
function checkStatus.onSay(player, words, param)
    if player:getGroup():getId() < 3 then
        player:sendCancelMessage("You don't have permission.")
        return false
    end

    local onlinePlayers = Game.getPlayers()
    local eligibleCount = 0
    local cooldownCount = 0

    for _, p in ipairs(onlinePlayers) do
        local canClaim, _ = canClaimReward(p)
        if canClaim then
            eligibleCount = eligibleCount + 1
        else
            cooldownCount = cooldownCount + 1
        end
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
        "Status: " .. #onlinePlayers .. " online | " .. 
        eligibleCount .. " eligible | " .. 
        cooldownCount .. " cooldown | " ..
        "Days: " .. table.concat(config.autoEvent.days, ",") .. " at " .. 
        config.autoEvent.hour .. ":" .. string.format("%02d", config.autoEvent.minute))

    return false
end
checkStatus:separator(" ")
checkStatus:register()

local resetPlayer = TalkAction("/reward_reset")
function resetPlayer.onSay(player, words, param)
    if player:getGroup():getId() < 4 then
        player:sendCancelMessage("You don't have permission.")
        return false
    end

    if param == "" then
        player:sendCancelMessage("Usage: /reward_reset PlayerName")
        return false
    end

    local targetPlayer = Player(param)
    if not targetPlayer then
        player:sendCancelMessage("Player not found.")
        return false
    end

    targetPlayer:setStorageValue(config.basic.storage, -1)
    targetPlayer:sendExtendedOpcode(config.opcode, buildOpcodeBuffer())
    targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your reward cooldown has been reset by a GM!")

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Cooldown reset for: " .. targetPlayer:getName())
    logMessage(player:getName() .. " reset cooldown for " .. targetPlayer:getName())
    return false
end
resetPlayer:separator(" ")
resetPlayer:register()

local checkPlayer = TalkAction("/reward_check")
function checkPlayer.onSay(player, words, param)
    if player:getGroup():getId() < 3 then
        player:sendCancelMessage("You don't have permission.")
        return false
    end

    if param == "" then
        player:sendCancelMessage("Usage: /reward_check PlayerName")
        return false
    end

    local targetPlayer = Player(param)
    if not targetPlayer then
        player:sendCancelMessage("Player not found.")
        return false
    end

    local canClaim, timeRemaining = canClaimReward(targetPlayer)
    if canClaim then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, targetPlayer:getName() .. " can claim now")
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 
            targetPlayer:getName() .. " cooldown: " .. formatTimeRemaining(timeRemaining))
    end
    return false
end
checkPlayer:separator(" ")
checkPlayer:register()
