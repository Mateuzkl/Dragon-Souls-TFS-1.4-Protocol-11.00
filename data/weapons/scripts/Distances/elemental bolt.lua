local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat1:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)

function onGetFormulaValues1(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill*11)+level+maglevel)
    local max = -((skill*17)+level+maglevel)
    return min, max
end

combat1:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)

function onGetFormulaValues2(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill*18)+maglevel+level)
    local max = -((skill*23)+maglevel*3+level*3)
    return min, max
end

combat2:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)
combat3:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ETHEREALSPEAR)

function onGetFormulaValues3(player, level, maglevel)
    local skill = player:getSkillLevel(SKILL_DISTANCE)
    local min = -((skill*17)+maglevel+level)
    local max = -((skill*23)+maglevel*2+level*3)
    return min, max
end

combat3:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues3")

local condition2 = Condition(CONDITION_PARALYZE)
condition2:setParameter(CONDITION_PARAM_TICKS, 30000)
condition2:setParameter(CONDITION_PARAM_SPEED, -300)
condition2:setFormula(-2.9, 0, -3.1, 0)
combat2:addCondition(condition2)

local condition3 = Condition(CONDITION_PARALYZE)
condition3:setParameter(CONDITION_PARAM_TICKS, 30000)
condition3:setParameter(CONDITION_PARAM_SPEED, -300)
condition3:setFormula(-1.9, 0, -2.9, 0)
combat3:addCondition(condition3)

function onUseWeapon(player, variant)
    local fala = math.random(1,25)
    local rand = math.random(1,600)
    if rand <= player:getSkillLevel(SKILL_DISTANCE) then
        if fala == 1 then
            player:say("Ops! It Hurts?", TALKTYPE_MONSTER_SAY)
            player:addHealth(player:getMaxHealth()/10)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            combat3:execute(player, variant)
        else
            player:addHealth(player:getMaxHealth()/6)
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            combat2:execute(player, variant)
        end
    else
        combat1:execute(player, variant)
    end
    return true
end
