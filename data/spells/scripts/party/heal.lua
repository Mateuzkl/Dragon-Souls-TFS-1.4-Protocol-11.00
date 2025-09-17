local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_TICKS, 2 * 60 * 1000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 2)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 2000)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

function onCastSpell(creature, variant)
    local player = Player(creature)
    if not player then
        return false
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "voce recebeu +2 de regeneracao de vida por 2 minutos.")
    return creature:addPartyCondition(combat, variant, condition, 120)
end
