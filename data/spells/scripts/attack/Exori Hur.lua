local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setParameter(COMBAT_PARAM_EFFECT, 31)
combat:setParameter(COMBAT_PARAM_HITCOLOR, COLOR_YELLOW)
combat:setFormula(COMBAT_FORMULA_SKILL, 1.0, -60, 1.0, -80)

local condition = Condition(CONDITION_PARALYZE)
condition:setParameter(CONDITION_PARAM_TICKS, 5000)
condition:setParameter(CONDITION_PARAM_SPEED, -600)
condition:setFormula(-1, -1, -1, -1) -- Define a fórmula do efeito para não ser alterada
combat:addCondition(condition)

function onCastSpell(cid, var)
    local player = Player(cid)
    if player:getStorageValue(10569) == 1 then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Socorro!")
        player:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONAREA)
        player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    return combat:execute(player, var)
end
