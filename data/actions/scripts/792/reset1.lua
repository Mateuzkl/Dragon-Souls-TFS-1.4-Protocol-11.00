local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 0, 0, 0)

function onUse(cid, item, frompos, item2, topos)

Voc = getPlayerVocation(cid)
PlayerLevel = getPlayerLevel(cid)

if PlayerLevel == 510 and Voc == 13 then
doPlayerSetVocation(cid, 20)
doPlayerAddExperience(cid, -getPlayerExperience(cid)+4200)
setPlayerMaxHealth(cid, 185)
setPlayerMaxMana(cid, 35)
doPlayerSetMaxCapacity(cid, 435)
doPlayerAddHealth(cid, -getPlayerHealth(cid)+185)
doPlayerAddMana(cid, -getPlayerMana(cid)+35)
doPlayerSendTextMessage(cid,22,"A força dos Deuses te acompanham e você concluiu seu primeiro reset.")
doPlayerSendTextMessage(cid,24,"Reset Status: First Reset Completed.")
doSendAnimatedText(getPlayerPosition(cid), "Downgraded!", TEXTCOLOR_ORANGE)
doPlayerSendTextMessage(cid,24,"You were downgraded from level 510 to level 8.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)

elseif PlayerLevel == 510 and Voc == 14 then
doPlayerSetVocation(cid, 21)
doPlayerAddExperience(cid, -getPlayerExperience(cid)+4200)
setPlayerMaxHealth(cid, 185)
setPlayerMaxMana(cid, 35)
doPlayerSetMaxCapacity(cid, 435)
doPlayerAddHealth(cid, -getPlayerHealth(cid)+185)
doPlayerAddMana(cid, -getPlayerMana(cid)+35)
doPlayerSendTextMessage(cid,22,"A força dos Deuses te acompanham e você concluiu seu primeiro reset.")
doPlayerSendTextMessage(cid,24,"Reset Status: First Reset Completed.")
doSendAnimatedText(getPlayerPosition(cid), "Downgraded!", TEXTCOLOR_ORANGE)
doPlayerSendTextMessage(cid,24,"You were downgraded from level 510 to level 8.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)

elseif PlayerLevel == 510 and Voc == 15 then
doPlayerSetVocation(cid, 22)
doPlayerAddExperience(cid, -getPlayerExperience(cid)+4200)
setPlayerMaxHealth(cid, 185)
setPlayerMaxMana(cid, 35)
doPlayerSetMaxCapacity(cid, 435)
doPlayerAddHealth(cid, -getPlayerHealth(cid)+185)
doPlayerAddMana(cid, -getPlayerMana(cid)+35)
doPlayerSendTextMessage(cid,22,"A força dos Deuses te acompanham e você concluiu seu primeiro reset.")
doPlayerSendTextMessage(cid,24,"Reset Status: First Reset Completed.")
doSendAnimatedText(getPlayerPosition(cid), "Downgraded!", TEXTCOLOR_ORANGE)
doPlayerSendTextMessage(cid,24,"You were downgraded from level 510 to level 8.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)

elseif PlayerLevel == 510 and Voc == 16 then
doPlayerSetVocation(cid, 19)
doPlayerAddExperience(cid, -getPlayerExperience(cid)+4200)
setPlayerMaxHealth(cid, 185)
setPlayerMaxMana(cid, 35)
doPlayerSetMaxCapacity(cid, 435)
doPlayerAddHealth(cid, -getPlayerHealth(cid)+185)
doPlayerAddMana(cid, -getPlayerMana(cid)+35)
doPlayerSendTextMessage(cid,22,"A força dos Deuses te acompanham e você concluiu seu primeiro reset.")
doPlayerSendTextMessage(cid,24,"Reset Status: First Reset Completed.")
doSendAnimatedText(getPlayerPosition(cid), "Downgraded!", TEXTCOLOR_ORANGE)
doPlayerSendTextMessage(cid,24,"You were downgraded from level 510 to level 8.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
else
doPlayerSendTextMessage(cid,24,"Desculpe, você não tem vocação necessária ou nível suficiente.")
end
end