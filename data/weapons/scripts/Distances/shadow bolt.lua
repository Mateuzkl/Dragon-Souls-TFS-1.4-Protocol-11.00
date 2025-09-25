local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_PIERCINGBOLT)

function onGetFormulaValues1(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill*0)+level)
    local max = -((skill*5)+level)
    return min, max
end

combat1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_PIERCINGBOLT)

function onGetFormulaValues2(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill*15)+level)
    local max = -((skill*17)+level)
    return min, max
end

combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_PIERCINGBOLT)

function onGetFormulaValues3(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill*15)+level)
    local max = -((skill*19)+level)
    return min, max
end

combat3:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues3")

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 30000)
condition2:setParameter(CONDITION_PARAM_SPEED, -500)
condition2:setFormula(-0.9, 0, -0.9, 0)
combat2:addCondition(condition2)

local condition3 = Condition(CONDITION_PARALYZE)
condition3:setParameter(CONDITION_PARAM_TICKS, 30000)
condition3:setParameter(CONDITION_PARAM_SPEED, -500)
condition3:setFormula(-0.9, 0, -0.9, 0)
combat3:addCondition(condition3)

function onUseWeapon(player, variant)
    local rand = math.random(1,20)
    if rand == 1 then
        player:say("Ops! hurt?", TALKTYPE_MONSTER_SAY)
        player:addHealth(math.random(50, 500))
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        combat3:execute(player, variant)
        return true
    end

    rand = math.random(1,20)
    if rand == 5 then
        player:say("Fell my fury!?", TALKTYPE_MONSTER_SAY)
        player:addHealth(math.random(50, 500))
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        combat3:execute(player, variant)
        return true
    end

    rand = math.random(1,20)
    if rand == 15 then
        player:addHealth(math.random(50, 500))
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        combat2:execute(player, variant)
        return true
    end

    combat1:execute(player, variant)
    return true
end
