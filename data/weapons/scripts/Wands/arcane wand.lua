local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -150, 0, -350)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -150, 0, -350)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -150, 0, -420)

local condition = Condition(CONDITION_ENERGY)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(1, 2000, -100)
condition:addDamage(1, 2000, -50)
condition:addDamage(1, 2000, -25)
combat2:addCondition(condition)

local condition2 = Condition(CONDITION_ENERGY)
condition2:setParameter(CONDITION_PARAM_TICKS, 6000)
condition2:setParameter(CONDITION_PARAM_DELAYED, 1)
condition2:addDamage(1, 2000, -100)
condition2:addDamage(1, 2000, -50)
condition2:addDamage(1, 2000, -25)
combat3:addCondition(condition2)

function onUseWeapon(player, variant)
    local rand1 = math.random(1, 20)
    if rand1 == 5 then
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat2:execute(player, variant)
    end
    
    local rand2 = math.random(1, 20)
    if rand2 == 1 then
        player:say("Eletrifick!!", TALKTYPE_MONSTER_SAY)
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat3:execute(player, variant)
    end
    
    return combat:execute(player, variant)
end
