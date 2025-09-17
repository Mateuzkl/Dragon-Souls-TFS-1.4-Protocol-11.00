local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 3000)
condition:setParameter(CONDITION_PARAM_SPEED, -300)
combat:setCondition(condition)

local condition = Condition(CONDITION_HASTEGA)
condition:setParameter(CONDITION_PARAM_TICKS, 10000)
combat:addCondition(condition)

local area = createCombatArea({
{0, 1, 1, 1, 0},
{1, 1, 1, 1, 1},
{1, 1, 2, 1, 1},
{1, 1, 1, 1, 1},
{0, 1, 1, 1, 0}
})

combat:setArea(area)

function onTargetCreature(creature, target)
    Game.sendAnimatedText("Frost!", target:getPosition(), 215)
    target:addCondition(exhaust)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
