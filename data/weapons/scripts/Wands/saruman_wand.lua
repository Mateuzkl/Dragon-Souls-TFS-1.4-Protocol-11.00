local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 133)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 43)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.1, 0, -3.6, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 133)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 43)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -5.6, 0, -7.3, 0)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, 133)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 43)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, -5.5, 0, -6.9, 0)

local condition = Condition(CONDITION_DROWN)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(1, 2000, -5000)
condition:addDamage(1, 2000, -2500)
condition:addDamage(1, 2000, -1000)
combat2:addCondition(condition)

local condition2 = Condition(CONDITION_DROWN)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setParameter(CONDITION_PARAM_DELAYED, 1)
condition2:addDamage(1, 2000, -5000)
condition2:addDamage(1, 2000, -2500)
condition2:addDamage(1, 2000, -1000)
combat3:addCondition(condition2)

function onUseWeapon(player, variant)
    local rand1 = math.random(1, 20)
    if rand1 == 5 then
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        player:say("The Shadow!!", TALKTYPE_MONSTER_SAY)
        return combat2:execute(player, variant)
    end
    
    local rand2 = math.random(1, 20)
    if rand2 == 1 then
        player:say("The Shadow!!", TALKTYPE_MONSTER_SAY)
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat3:execute(player, variant)
    end
    
    return combat:execute(player, variant)
end
