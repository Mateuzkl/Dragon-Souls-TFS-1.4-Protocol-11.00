local EXHAUSTED_STORAGE = 8754
local TELEPORT_STORAGE = 444
local POSITION_STORAGES = {x = 111, y = 222, z = 333}

local function teleportEffect(playerId, position, count)
    local player = Player(playerId)
    if not player then
        return
    end
    
    if count <= 0 then
        player:teleportTo(position)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você foi teletransportado com sucesso.')
        player:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
        Game.sendAnimatedText("Woup!!", player:getPosition(), 255)
        return
    end
    
    position:sendMagicEffect(CONST_ME_ENERGYAREA)
    player:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
    
    addEvent(teleportEffect, 1000, playerId, position, count - 1)
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local playerId = player:getId()
    
    if os.time() < player:getStorageValue(EXHAUSTED_STORAGE) then
        player:sendCancelMessage("Você está muito cansado.")
        return true
    end
    
    if player:getSkull() == SKULL_RED then
        player:sendCancelMessage("Você não pode usar esse teleport enquanto estiver PK.")
        return true
    end
    
    local teleportStatus = player:getStorageValue(TELEPORT_STORAGE)
    
    if teleportStatus == -1 or teleportStatus == 0 then
        local currentPos = player:getPosition()
        
        player:setStorageValue(POSITION_STORAGES.x, currentPos.x)
        player:setStorageValue(POSITION_STORAGES.y, currentPos.y)
        player:setStorageValue(POSITION_STORAGES.z, currentPos.z)
        player:setStorageValue(TELEPORT_STORAGE, 1)
        
        currentPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você gravou suas coordenadas em seu teleport místico.')
        
    elseif teleportStatus == 1 then
        local savedPos = Position(
            player:getStorageValue(POSITION_STORAGES.x),
            player:getStorageValue(POSITION_STORAGES.y),
            player:getStorageValue(POSITION_STORAGES.z)
        )
        
        teleportEffect(playerId, savedPos, 9)
        
        player:setStorageValue(TELEPORT_STORAGE, 0)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você ativou seu teleport místico.')
        
        player:setStorageValue(EXHAUSTED_STORAGE, os.time() + 15)
        
        player:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
        item:remove()
    end
    
    return true
end
