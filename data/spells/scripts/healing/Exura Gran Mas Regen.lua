local combat1 = Combat()
combat1:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat1:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat1:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat1:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat1:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0.6, -30, 1.2, 0)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat2:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat2:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
combat2:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0.6, -30, 1.2, 0)

local condition1 = Condition(CONDITION_REGENERATION)
condition1:setParameter(CONDITION_PARAM_TICKS, 60000)
condition1:setParameter(CONDITION_PARAM_MANAGAIN, 1000)
condition1:setParameter(CONDITION_PARAM_MANATICKS, 1)
condition1:setParameter(CONDITION_PARAM_DELAYED, true)
condition1:setParameter(CONDITION_PARAM_HEALTHGAIN, 1000)
combat1:setCondition(condition1)

local condition2 = Condition(CONDITION_ENERGY)
condition2:setParameter(CONDITION_PARAM_DELAYED, true)
condition2:addDamage(120, 60000, 1000, 1000)
combat2:setCondition(condition2)

local area = createCombatArea({
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 2, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0}
})

combat1:setArea(area)
combat2:setArea(area)

function onTargetCreature(creature, target)
    local rand = math.random(1, 5)
    Game.sendAnimatedText("Regen!", target:getPosition(), TEXTCOLOR_TEAL)
    
    if rand == 4 then
        target:getPosition():sendMagicEffect(24)
    end
    
    return true
end

combat1:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    
    combat1:execute(creature, variant)
    combat2:execute(creature, variant)
    
    return true
end
