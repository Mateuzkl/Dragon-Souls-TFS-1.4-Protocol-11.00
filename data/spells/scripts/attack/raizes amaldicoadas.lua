local combatDist = Combat()
combatDist:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combatDist:setParameter(COMBAT_PARAM_EFFECT, 112)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local function showRoots(targetId)
    local target = Creature(targetId)
    if target then
        Game.sendAnimatedText("Roots!", target:getPosition(), 215)
    end
end

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    local target = creature:getTarget()
    if not target then
        player:sendCancelMessage("Select your target.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    
    local condition = Condition(CONDITION_ROOTED)
    condition:setParameter(CONDITION_PARAM_TICKS, 2000)
    target:addCondition(condition)
    
    player:say("Exana Tera!", TALKTYPE_MONSTER_SAY)
    
    if math.random(2) == 2 then
        addEvent(showRoots, 100, target:getId())
    end
    
    combatDist:execute(creature, Variant(target:getPosition()))
    return combat:execute(creature, variant)
end
