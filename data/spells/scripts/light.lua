function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local pos = player:getPosition()
    local rand = math.random(1, 50)
    
    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    
    if rand == 1 then
        player:say("Light on!", TALKTYPE_MONSTER_SAY)
    end
    
    creature:setLight(7, 215, (6 * 60 + 10) * 1000)
    
    return true
end
