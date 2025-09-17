function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local pos = player:getPosition()
    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    
    local rand = math.random(1, 50)
    if rand == 1 then
        player:say("Light on!", TALKTYPE_MONSTER_SAY)
    end
    
    player:setLight(7, 215, (6*60+10)*1000)
    return true
end
