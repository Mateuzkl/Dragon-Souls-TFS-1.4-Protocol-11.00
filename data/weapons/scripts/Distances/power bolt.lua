local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POWERBOLT)
function onGetFormulaValues1(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_SWORD)
    local min = -((skill*0)+level)
    local max = -((skill*2)+level)
    return min, max
end
combat1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLEENERGY)
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POWERBOLT)
function onGetFormulaValues2(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_SWORD)
    local min = -((skill*6)+level)
    local max = -((skill*8)+level)
    return min, max
end
combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLEENERGY)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POWERBOLT)
function onGetFormulaValues3(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_SWORD)
    local min = -((skill*6)+level)
    local max = -((skill*10)+level)
    return min, max
end
combat3:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues3")

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat4:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLEENERGY)
combat4:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POWERBOLT)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 30000)
condition:setParameter(CONDITION_PARAM_SPEED, -200)
condition:setFormula(-0.9, 0, -0.9, 0)
combat2:addCondition(condition)

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 30000)
condition2:setParameter(CONDITION_PARAM_SPEED, -200)
condition2:setFormula(-0.9, 0, -0.9, 0)
combat3:addCondition(condition2)

local condition3 = Condition(CONDITION_PARALYZE)
condition3:setParameter(CONDITION_PARAM_TICKS, 30000)
condition3:setParameter(CONDITION_PARAM_SPEED, -200)
condition3:setFormula(-0.9, 0, -0.9, 0)
combat4:addCondition(condition3)

function onUseWeapon(player, variant)
    local rand1 = math.random(1, 20)
    if rand1 == 1 then
        player:say("Ops! hurt?", TALKTYPE_MONSTER_SAY)
        player:addHealth(math.random(20, 200))
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat4:execute(player, variant)
    end

    local rand2 = math.random(1, 20)
    if rand2 == 5 then
        player:say("Fell my fury!?", TALKTYPE_MONSTER_SAY)
        player:addHealth(math.random(20, 200))
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat3:execute(player, variant)
    end

    local rand3 = math.random(1, 20)
    if rand3 == 15 then
        player:addHealth(math.random(20, 200))
        Game.sendAnimatedText("Critical!", player:getPosition(), 180)
        return combat2:execute(player, variant)
    end

    return combat1:execute(player, variant)
end
