local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 0, 0, 0)

function onUse(cid, item, frompos, item2, topos)

queststatus = getPlayerStorageValue(cid,5200)
EXP = math.random(3000000,4000000)
PlayerLevel = getPlayerLevel(cid)

if PlayerLevel > 149 then
if queststatus == -1 then
doPlayerAddExp(cid,EXP)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP .. ' de experiência.')
doSendAnimatedText(getPlayerPosition(cid),EXP, 179)
setPlayerStorageValue(cid,5200,1)
else
doPlayerSendTextMessage(cid,22,"It is empty.")
end
else
doPlayerSendTextMessage(cid,20,'Desculpe, você não tem nível suficiente.')
end
end