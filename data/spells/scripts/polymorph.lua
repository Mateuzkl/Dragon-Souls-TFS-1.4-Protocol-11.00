local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)

local condition = Condition(CONDITION_OUTFIT)
condition:setParameter(CONDITION_PARAM_TICKS, 20000)
condition:addOutfit(0, 230, 0, 0, 0, 0)
condition:addOutfit(0, 231, 0, 0, 0, 0)
condition:addOutfit(0, 232, 0, 0, 0, 0)
condition:addOutfit(0, 233, 0, 0, 0, 0)
condition:addOutfit(0, 234, 0, 0, 0, 0)
condition:addOutfit(0, 235, 0, 0, 0, 0)
condition:addOutfit(0, 236, 0, 0, 0, 0)
condition:addOutfit(0, 237, 0, 0, 0, 0)
condition:addOutfit(0, 238, 0, 0, 0, 0)
condition:addOutfit(0, 239, 0, 0, 0, 0)
condition:addOutfit(0, 240, 0, 0, 0, 0)
condition:addOutfit(0, 241, 0, 0, 0, 0)
condition:addOutfit(0, 242, 0, 0, 0, 0)
condition:addOutfit(0, 243, 0, 0, 0, 0)
condition:addOutfit(0, 244, 0, 0, 0, 0)
condition:addOutfit(0, 245, 0, 0, 0, 0)
condition:addOutfit(0, 246, 0, 0, 0, 0)
condition:addOutfit(0, 247, 0, 0, 0, 0)

combat:addCondition(condition)

local area = createCombatArea({
    {1, 1, 1},
    {1, 3, 1},
    {1, 1, 1}
})

combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
