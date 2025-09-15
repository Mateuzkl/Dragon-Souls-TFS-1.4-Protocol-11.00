local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 3000)
condition:setParameter(CONDITION_PARAM_SPEED, -300)

combat:addCondition(condition)

local exhaust = Condition(CONDITION_FROZEN)
exhaust:setParameter(CONDITION_PARAM_TICKS, 10000)

local area = createCombatArea({
    {0, 1, 1, 1, 0},
    {1, 1, 1, 1, 1},
    {1, 1, 3, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0}
})

combat:setArea(area)

function onTargetCreature(creature, target)
    target:getPosition():sendAnimatedText("Frost!", 215)
    target:addCondition(exhaust)
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
