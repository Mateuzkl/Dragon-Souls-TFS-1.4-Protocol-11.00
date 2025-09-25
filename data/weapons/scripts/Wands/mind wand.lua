local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 47)
combat1:setParameter(COMBAT_PARAM_EFFECT, 100)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, -1.1, 0, -1.9, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 47)
combat2:setParameter(COMBAT_PARAM_EFFECT, 100)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.4, 0, -3.2, 0)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(1, 2000, -600)
condition:addDamage(1, 2000, -460)
condition:addDamage(1, 2000, -120)
combat2:addCondition(condition)

function onUseWeapon(player, variant)
    local critical = math.random(1, 100)
    if critical > 96 then
        player:say("Burn!", TALKTYPE_MONSTER_SAY)
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat2:execute(player, variant)
    else 
        return combat1:execute(player, variant)
    end
end
