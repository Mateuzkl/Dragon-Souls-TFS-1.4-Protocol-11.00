local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 0, 0, 0)

function onUse(cid, item, frompos, item2, topos)

Voc = getPlayerVocation(cid)
PlayerLevel = getPlayerLevel(cid)

if PlayerLevel == 8 and Voc == 9 then
doPlayerSetVocation(cid, 13)
doShowTextDialog(cid,13520,"Vocation : Dark Wyzard.")
doPlayerSendTextMessage(cid,22,"The almighty god are with you now.")
doPlayerSendTextMessage(cid,24,"Now you are a God.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)

elseif PlayerLevel == 8 and Voc == 10 then
doPlayerSetVocation(cid, 14)
doShowTextDialog(cid,13520,"Vocation : Elemental Cleric.")
doPlayerSendTextMessage(cid,22,"The Strenght of all Clerics comes with you.")
doPlayerSendTextMessage(cid,24,"Now you are a God.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)

elseif PlayerLevel == 8 and Voc == 11 then
doPlayerSetVocation(cid, 15)
doShowTextDialog(cid,13532,"Vocation : Elven Ranger.")
doPlayerSendTextMessage(cid,22,"All the strongest bullets follows you mortal.")
doPlayerSendTextMessage(cid,24,"Now you are a God.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)

elseif PlayerLevel == 8 and Voc == 12 then
doPlayerSetVocation(cid, 16)
doShowTextDialog(cid,13608,"Vocation : Dragon Slayer.")
doPlayerSendTextMessage(cid,22,"For now you have the power of a blood hunter.")
doPlayerSendTextMessage(cid,24,"Now you are a God.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)
else
doPlayerSendTextMessage(cid,22,"Desculpe, você não tem vocação necessária ou nível suficiente.")
end
end