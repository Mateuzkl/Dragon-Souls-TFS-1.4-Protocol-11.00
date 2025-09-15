local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -2.2, -30, -3.0, -30)

local area = createCombatArea({
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
})

combat:setArea(area)

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
    
    return combat:execute(creature, variant)
end
