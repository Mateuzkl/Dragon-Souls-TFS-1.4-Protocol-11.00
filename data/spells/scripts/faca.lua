local acombat = Combat()
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_THROWINGSTAR)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -13.7, 0, -19.9, 0)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 6000)
condition:setFormula(-0.7, 0, -0.7, 0)

acombat:addCondition(condition)

local area = createCombatArea({
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 0, 0},
    {1, 1, 1, 2, 1, 1, 1},
    {0, 0, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0}
})

acombat:setArea(area)

function onTargetTile(creature, position)
    combat:execute(creature, Variant(position))
end

acombat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if player then
        local rand = math.random(1, 50)
        if rand == 1 then
            player:say("Come on! I got more for you!", TALKTYPE_MONSTER_SAY)
        elseif rand == 2 then
            player:say("Feel the power of darkness!", TALKTYPE_MONSTER_SAY)
        elseif rand == 3 then
            player:say("You can't run of your death!", TALKTYPE_MONSTER_SAY)
        elseif rand == 4 then
            player:say("FLAME OF HELL!!!", TALKTYPE_MONSTER_SAY)
        end
    end
    
    return acombat:execute(creature, variant)
end
