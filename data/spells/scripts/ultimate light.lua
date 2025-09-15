function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local pos = player:getPosition()
    local rand = math.random(1, 50)
    
    if rand == 1 then
        player:say("On Darkness, the light will show you the way!", TALKTYPE_MONSTER_SAY)
    elseif rand == 2 then
        player:say("Light, show me the way!", TALKTYPE_MONSTER_SAY)
    end
    
    pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    player:setLight(11, 215, (60 * 33 + 10) * 1000)
    
    return true
end
