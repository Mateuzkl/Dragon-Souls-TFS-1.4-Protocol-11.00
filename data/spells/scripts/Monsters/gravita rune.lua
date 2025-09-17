local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, 34)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -3.0, -500, -3.5, -1000)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 34)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, -5.5, -500, -6.5, -1000)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, 34)
combat3:setFormula(COMBAT_FORMULA_LEVELMAGIC, -7.5, 500, -8.5, -1000)

local condition = Condition(CONDITION_EMO)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(1000, 100000, -5000)
combat2:setCondition(condition)

function onCastSpell(cid, var)
    local rand = math.random(95, 100)
    if rand == 98 then
        doSendAnimatedText(getCreaturePosition(cid), "Failed!", 155)
        doCreatureAddHealth(cid, -5000)
        combat2:execute(cid, var)
    else
        rand = math.random(95, 100)
        if rand == 95 then
            doSendAnimatedText(getCreaturePosition(cid), "Gravita!", 155)
            doCreatureAddHealth(cid, 5000)
            combat3:execute(cid, var)
        else
            combat:execute(cid, var)
        end
    end
end
