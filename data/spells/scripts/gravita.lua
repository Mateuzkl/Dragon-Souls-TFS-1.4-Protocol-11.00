local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 60)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

function onTargetCreature(creature, target)
    if creature:isPlayer() and target:isPlayer() then
        creature:getPosition():sendAnimatedText("Drain!", 160)
        creature:addMana(creature:getMana() / 4 * 3)
        creature:getPosition():sendMagicEffect(59)
        
        target:getPosition():sendAnimatedText("Drain!", 160)
        target:addHealth(-target:getHealth() / 4 * 3)
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local target = creature:getTarget()
    if not target then
        player:sendCancelMessage('Select your target.')
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você foi drenado!')
    end
    
    player:say("Gravita", TALKTYPE_MONSTER_SAY)
    
    return combat:execute(creature, variant)
end
