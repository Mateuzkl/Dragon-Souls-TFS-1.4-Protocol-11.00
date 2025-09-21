function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local positions = {
        {Position(444, 197, 4), Position(444, 201, 4)},
        {Position(443, 197, 4), Position(443, 201, 4)},
        {Position(443, 198, 4), Position(443, 202, 4)},
        {Position(443, 199, 4), Position(443, 203, 4)},
        {Position(444, 199, 4), Position(444, 203, 4)}
    }
    
    local getItem = function(pos)
        local tile = Tile(pos[1])
        if tile then
            return tile:getTopVisibleThing()
        end
        tile = Tile(pos[2])
        if tile then
            return tile:getTopVisibleThing()
        end
        return nil
    end
    
    local getpiece1 = getItem(positions[1])
    local getpiece3 = getItem(positions[3])
    
    if not getpiece1 or not getpiece3 then
        return false
    end
    
    local skill_level = player:getSkillLevel(SKILL_MINING)
    local random_number = math.random(1, 100 + skill_level/10)
    
    toPosition:sendAnimatedText("Cleck!", TEXTCOLOR_ORANGE)
    toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
    
    if getpiece1:getId() == 2321 and getpiece3:getId() == 2149 and target:getSubType() == 10 then
        if random_number <= skill_level then
            target:transform(13626)
            target:decay()
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce refinou 10 small emeralds.")
        end
        player:addSkillTries(SKILL_MINING, 1)
        player:addHealth(-25)
        
    elseif getpiece1:getId() == 2321 and getpiece3:getId() == 2153 then
        if random_number <= skill_level then
            target:transform(13632)
            target:decay()
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce refinou um violet gem.")
        end
        player:addSkillTries(SKILL_MINING, 1)
        player:addHealth(-25)
        
    elseif getpiece1:getId() == 2321 and getpiece3:getId() == 2157 and target:getSubType() == 10 then
        if random_number <= skill_level then
            target:transform(13633)
            target:decay()
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce refinou 10 gold nuggets.")
        end
        player:addSkillTries(SKILL_MINING, 1)
        player:addHealth(-25)
        
    elseif getpiece1:getId() == 2321 and getpiece3:getId() == 13641 and target:getSubType() == 10 then
        if random_number <= skill_level then
            target:remove(target:getSubType())
            player:addItem(13685, 1)
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce refinou 10 iron nuggets.")
        end
        player:addSkillTries(SKILL_MINING, 1)
        player:addHealth(-25)
    else
        return false
    end
    
    return true
end
