function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local pos = player:getPosition()
    local rand = math.random(1, 50)
    
    if rand == 1 then
        player:say("Get out shadow!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("The light!", TALKTYPE_MONSTER_SAY)
    end
    
    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    creature:setLight(9, 215, (60 * 11 + 35) * 1000)
    
    return true
end
