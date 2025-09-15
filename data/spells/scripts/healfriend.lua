local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0.6, -30, 1.2, 0)

function onCastSpell(creature, variant)
    local player = creature:getPlayer()
    if player then
        local rand = math.random(1, 50)
        if rand == 1 then
            player:say("Feel better now?", TALKTYPE_MONSTER_SAY)
        elseif rand == 2 then
            player:say("Never forget the hope!", TALKTYPE_MONSTER_SAY)
        end
    end
    
    return combat:execute(creature, variant)
end
