local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 0, 0, 0)

function onUse(cid, item, frompos, item2, topos)

Voc = getPlayerVocation(cid)
PlayerLevel = getPlayerLevel(cid)

if PlayerLevel == 8 then
if Voc == 3 then

if item.itemid == 13696 then
doPlayerSetVocation(cid, 11)
doPlayerSendTextMessage(cid,21,"Relogue seu personagem.")
doPlayerSendTextMessage(cid,22,"A força dos Semi-Deuses agora acompanham o nobre Ranger.")
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_BLUE)
doRemoveItem(item.uid,1)
end
else
doPlayerSendTextMessage(cid,22,"Desculpe, você não tem vocação necessaria.")
end
else
doPlayerSendTextMessage(cid,22,'Desculpe, você não tem nível suficiente.')
end
end