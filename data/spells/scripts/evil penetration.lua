--Spell Method by Night Wolf


local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 39)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, true)


local config = {
tempo = 10, --- tempo que vai durar a spell
percent = 20 -- quanto % vai diminuir
}


local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, config.tempo*1000)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELDPERCENT, 100-config.percent)
setCombatCondition(combat, condition)




function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end