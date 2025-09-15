local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 34)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_NONE)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -7.3, -250, -10.0, -1000)

function onCastSpell(cid, var)
doSendAnimatedText(getPlayerPosition(cid), "Gravita!", TEXTCOLOR_LIGHTGREEN)
	return doCombat(cid, combat, var)
end


local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)
setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_NONE)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -9.9, -250, -10.0, -1200)


function onCastSpell(cid, var)
rand = math.random(97,100)
if rand == 99 then
doPlayerAddHealth(cid,-2500)
doSendAnimatedText(getPlayerPosition(cid), "Gravita!", TEXTCOLOR_LIGHTGREEN)
doPlayerSay(cid, "Ouch!",16)
doCombat(cid, combat2, var)
else
doCombat(cid, combat, var)
end
end