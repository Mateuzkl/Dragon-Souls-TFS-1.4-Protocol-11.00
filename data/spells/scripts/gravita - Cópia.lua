
local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 60)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)


function onTargetCreature(cid, target)
   
 if isPlayer(cid) == 1 and isPlayer(target) == 1 then
   rand = math.random(1,1)
   if getPlayerMaxMana(target) == getPlayerMaxMana(target) then
   if rand == 1 then
     doSendAnimatedText(getThingPos(cid),"Drain!",160)
     doPlayerAddMana(cid,getPlayerMana(cid)/4*3)
     doSendMagicEffect(getPlayerPosition(cid),59)
    
     doSendAnimatedText(getThingPos(target),"Drain!",160)
     doCreatureAddHealth(target,-getPlayerMana(target)/4*3)
   end
end  
end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end