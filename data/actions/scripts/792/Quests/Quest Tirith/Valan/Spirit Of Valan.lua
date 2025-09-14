local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 0, 0, 0)

function onUse(cid, item, frompos, item2, topos)

Voc = getPlayerVocation(cid)
PlayerLevel = getPlayerLevel(cid)

if PlayerLevel == 8 and Voc == 1 then
doPlayerSetVocation(cid, 9)
doPlayerSendTextMessage(cid,22,"A força dos Semi-Deuses agora acompanham o nobre Wyzard.")
doPlayerSendTextMessage(cid,24,"Parabéns, agora você é um valan player")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)

elseif PlayerLevel == 8 and Voc == 2 then
doPlayerSetVocation(cid, 10)
doPlayerSendTextMessage(cid,22,"A força dos Semi-Deuses agora acompanham o nobre Cleric.")
doPlayerSendTextMessage(cid,24,"Parabéns, agora você é um valan player")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)

elseif PlayerLevel == 8 and Voc == 3 then
doPlayerSetVocation(cid, 11)
doPlayerSendTextMessage(cid,22,"A força dos Semi-Deuses agora acompanham o nobre Ranger.")
doPlayerSendTextMessage(cid,24,"Parabéns, agora você é um valan player")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)

elseif PlayerLevel == 8 and Voc == 4 then
doPlayerSetVocation(cid, 12)
doPlayerSendTextMessage(cid,22,"A força dos Semi-Deuses agora acompanham o nobre Slayer.")
doPlayerSendTextMessage(cid,24,"Parabéns, agora você é um valan player")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)
else
doPlayerSendTextMessage(cid,22,"Desculpe, você não tem vocação necessária ou nível suficiente.")
end
end