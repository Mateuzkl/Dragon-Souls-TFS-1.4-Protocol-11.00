local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 47)
combatDist:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 30)
combatDist:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.7, 0, -10.9, 0)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
condition:setParameter(CONDITION_PARAM_SPEED, -220)
condition:setFormula(-0.9, 0, -0.9, 0)
combatDist:setCondition(condition)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local function restoreOutfit(targetId, originalOutfit)
    local target = Player(targetId)
    if target then
        target:setOutfit(originalOutfit)
    end
end

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
    
    local function frozzen(targetId, damage)
        local target = Creature(targetId)
        if target then
            target:getPosition():sendMagicEffect(47)
            target:addHealth(-damage)
            Game.sendAnimatedText("-" .. damage, target:getPosition(), 185)
        end
    end
    
    local targetId = target:getId()
    local rand1 = math.random(2000, 4000)
    local rand2 = math.random(2000, 4000)
    local rand3 = math.random(2000, 4000)
    local rand4 = math.random(2000, 4000)
    local rand5 = math.random(2000, 4000)
    local rand6 = math.random(2000, 4000)
    
    if target:isPlayer() then
        local targetPlayer = target:getPlayer()
        local targetOutfit = target:getOutfit()
        local congelado = {
            lookType = targetOutfit.lookType,
            lookHead = 9,
            lookBody = 9,
            lookLegs = 9,
            lookFeet = 9,
            lookAddons = targetOutfit.lookAddons
        }
        target:setOutfit(congelado)
        target:addCondition(condition)
        targetPlayer:sendTextMessage(MESSAGE_STATUS_WARNING, 'Voce está sendo devorado.')
        
        addEvent(restoreOutfit, 3000, targetPlayer:getId(), targetOutfit)
        
        combatDist:execute(creature, Variant(target:getPosition()))
    else
        target:addCondition(condition)
        combatDist:execute(creature, Variant(target:getPosition()))
    end
    
    player:say("Exevo Tera!", TALKTYPE_MONSTER_SAY)
    
    addEvent(frozzen, 1000, targetId, rand1)
    addEvent(frozzen, 1500, targetId, rand2)
    addEvent(frozzen, 2000, targetId, rand3)
    addEvent(frozzen, 2500, targetId, rand4)
    addEvent(frozzen, 3000, targetId, rand5)
    addEvent(frozzen, 3500, targetId, rand6)
    
    return combat:execute(creature, variant)
end
