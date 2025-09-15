local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, 60)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

function onTargetCreature(creature, target)
    if creature:isPlayer() and target:isPlayer() then
        local rand = math.random(1, 1)
        if rand == 1 then
            creature:getPosition():sendAnimatedText("Drain!", 160)
            creature:addMana(creature:getMana() / 4 * 3)
            creature:getPosition():sendMagicEffect(59)
            
            target:getPosition():sendAnimatedText("Drain!", 160)
            target:addHealth(-target:getHealth() / 4 * 3)
        end
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

local function Cooldown(playerId)
    local player = Player(playerId)
    if player then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, 'CD: Gravita')
    end
end

local exhausted_seconds = 15
local exhausted_storagevalue = 3459

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    if os.time() < player:getStorageValue(exhausted_storagevalue) then
        player:sendCancelMessage('O Cooldown não está pronto.')
        return false
    end
    
    local target = creature:getTarget()
    if not target then
        player:sendCancelMessage('Select your target.')
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    local targetOutfit = target:getOutfit()
    target:setOutfit(targetOutfit, 3000)
    
    if target:isPlayer() then
        target:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Você foi drenado.')
    end
    
    if math.random(1, 1) == 1 then
        player:say("Gravita", TALKTYPE_MONSTER_SAY)
    end
    
    player:setStorageValue(exhausted_storagevalue, os.time() + exhausted_seconds)
    addEvent(Cooldown, exhausted_seconds * 1000, player:getId())
    
    return combat:execute(creature, variant)
end
