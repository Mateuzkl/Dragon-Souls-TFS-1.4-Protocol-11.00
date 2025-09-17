local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 20000)
condition:setFormula(-1, 80, -1, 80)
combat:addCondition(condition)

function onCastSpell(creature, variant, isHotkey)
    local target = creature:getTarget()
    if not target then
        return false
    end

    if not combat:execute(creature, variant) then
        return false
    end

   Game.sendAnimatedText("Silence!!", target:getPosition(), 215)
  
    creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    return true
end
