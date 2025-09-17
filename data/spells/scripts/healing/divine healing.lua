local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 2 + maglevel * 4) * 1.5 / 2
    local max = (level * 3 + maglevel * 5) * 2.7 / 2

    local totalIncrease = math.random(min, max)
    local formattedText = string.format("+%d", totalIncrease)
    Game.sendAnimatedText(formattedText, getPlayerPosition(cid), 12) -- Alterado para o número 12 (cor desejada)

    return totalIncrease, totalIncrease -- Retorna o valor total para min e max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
 
    return combat:execute(cid, var)
end
