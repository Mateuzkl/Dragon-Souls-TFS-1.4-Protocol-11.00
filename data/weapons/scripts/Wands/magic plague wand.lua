local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.1, 0, -2.6, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.9, 0, -4.9, 0)

local condition = Condition(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(1, 2000, -600)
condition:addDamage(1, 2000, -460)
condition:addDamage(1, 2000, -120)
combat2:addCondition(condition)

function onUseWeapon(player, variant)
    local critical = math.random(1, 100)
    if critical > 95 then
        player:say("The Sickness!", TALKTYPE_MONSTER_SAY)
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat2:execute(player, variant)
    else 
        return combat:execute(player, variant)
    end
end
