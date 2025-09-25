local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BOLT)

function onGetFormulaValues1(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill * 1) + level)
    local max = -((skill * 5) + level)
    return min, max
end

combat1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, 173)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BOLT)

function onGetFormulaValues2(player, level, maglevel)
   local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill * 4) + level)
    local max = -((skill * 8) + level) + math.random(1, 10) -- Adiciona um valor aleatório ao dano máximo
    return min, max
end

combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, 173)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BOLT)

function onGetFormulaValues3(player, level, maglevel)
   local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill * 6) + level)
    local max = -((skill * 10) + level) + math.random(1, 20) -- Adiciona um valor aleatório ao dano máximo
    return min, max
end

combat3:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues3")

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, 173)
combat4:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BOLT)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 30000)
condition:setParameter(CONDITION_PARAM_SPEED, -100)
condition:setFormula(-0.9, 0, -0.9, 0)
combat2:addCondition(condition)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 30000)
condition:setParameter(CONDITION_PARAM_SPEED, -100)
condition:setFormula(-0.9, 0, -0.9, 0)
combat3:addCondition(condition)

function onUseWeapon(cid, var)
    local rand = math.random(1, 20)
    if rand == 1 then
        doCreatureSay(cid, "Ops! hurt?", 16)
        doCreatureAddHealth(cid, math.random(10, 100))
        doSendAnimatedText("Critical", getPlayerPosition(cid), 215)
        combat4:execute(cid, var)
    elseif rand == 5 then
        doCreatureSay(cid, "Fell my fury!?", 16)
        doCreatureAddHealth(cid, math.random(10, 100))
        doSendAnimatedText("Critical", getPlayerPosition(cid), 215)
        combat3:execute(cid, var)
    elseif rand == 15 then
        doCreatureAddHealth(cid, math.random(10, 100))
        doSendAnimatedText("Critical", getPlayerPosition(cid), 215)
        combat2:execute(cid, var)
    else
        combat1:execute(cid, var)
    end
end
