local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 59)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

function onTargetCreature(cid, target)  
         if isPlayer(cid) and isPlayer(target) then
            local rand = math.random(1,5)
            if getCreatureMaxHealth(target) == getCreatureHealth(target) then
               if rand == 1 then
                  doSendAnimatedText(getThingPos(cid),"Gravita!",160)
                  doPlayerAddMana(cid,-5000)
                  doSendMagicEffect(getPlayerPosition(cid),59)
                  doSendMagicEffect(getPlayerPosition(target),3)
               else
                  doSendAnimatedText(getThingPos(target),"Gravita!",160)
                  doCreatureAddHealth(target,-getCreatureHealth(target)/2*1)
               end
            else
               doSendAnimatedText(getThingPos(target),"Gravita!",160)
               doSendAnimatedText(getThingPos(cid),"Gravita!",160)
               doCreatureAddHealth(target,getCreatureHealth(cid)/4*3)
               doCreatureAddHealth(cid,-5000)
            end
         end
         if isPlayer(cid) == false and isPlayer(target)then
            doSendAnimatedText(getThingPos(target),"Gravita!",160)
            doCreatureAddHealth(target,-getCreatureHealth(target)/1*1)
         end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Silence!", 129)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 
end
	return doCombat(cid, combat, var)
end
