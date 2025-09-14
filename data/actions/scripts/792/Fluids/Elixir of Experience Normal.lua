local condition = createConditionObject(CONDITION_ENERGY)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 0, 0, 0)

function onUse(cid, item, frompos, item2, topos)
skill = getPlayerSkill(cid,0)
maglevel = getPlayerMagLevel(cid)
level = getPlayerLevel(cid)
x1 = (level*610)+(skill*115)+(140*maglevel)
x2 = (level*725)+(115*skill)+(140*maglevel)
x3 = (level*1320)+(115*skill)+(140*maglevel)
x4 = (level*2109)+(115*skill)+(140*maglevel)
x5 = (level*1320)+(115*skill)+(140*maglevel)
x6 = (level*2109)+(115*skill)+(140*maglevel)
x7 = (level*1320)+(115*skill)+(140*maglevel)
x8 = (level*2109)+(115*skill)+(140*maglevel)
x9 = (level*1320)+(115*skill)+(140*maglevel)
x10 = (level*2109)+(115*skill)+(140*maglevel)
x11 = (level*1320)+(115*skill)+(140*maglevel)
x12 = (level*2109)+(115*skill)+(140*maglevel)
x13 = ((level*1320)+(115*skill)+(140*maglevel)
x14 = (level*2109)+(115*skill)+(140*maglevel)
x15 = (level*1320)+(115*skill)+(140*maglevel)
x16 = (level*2109)+(115*skill)+(140*maglevel)
x17 = (level*1320)+(115*skill)+(140*maglevel)
x18 = (level*2109)+(115*skill)+(140*maglevel)
x19 = (level*1320)+(115*skill)+(140*maglevel)
x20 = (level*2109)+(115*skill)+(140*maglevel)
x21 = (level*1320)+(115*skill)+(140*maglevel)
x22 = (level*2109)+(115*skill)+(140*maglevel)


EXP0 = math.random(x1,x2)
EXP1 = math.random(x3,x4)
EXP2 = math.random(x5,x6)
EXP3 = math.random(x7,x8)
EXP4 = math.random(x9,x10)
EXP5 = math.random(x11,x12)
EXP6 = math.random(x13,x14)
EXP7 = math.random(x15,x16)
EXP8 = math.random(x17,x18)
EXP9 = math.random(x19,x20)
EXP10 = math.random(x21,x22)

if getPlayerLevel(cid) <= 149 then
doPlayerSendTextMessage(cid,20,'Desculpe, você não tem nível suficiente para usar este Elixir.')
elseif getPlayerSoul(cid) >= 250 then

PlayerLevel = getPlayerLevel(cid)

if PlayerLevel < 50 then
doPlayerAddExp(cid,EXP0)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP0 .. ' de experiência, Bônus 0.')
doSendAnimatedText(getPlayerPosition(cid),EXP0, 179)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 100 then
doPlayerAddExp(cid,EXP1)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP1 .. ' de experiência, Bônus 1.')
doSendAnimatedText(getPlayerPosition(cid),EXP1, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 150 then
doPlayerAddExp(cid,EXP2)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP2 .. ' de experiência, Bônus 2.')
doSendAnimatedText(getPlayerPosition(cid),EXP2, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 200 then
doPlayerAddExp(cid,EXP3)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP3 .. ' de experiência, Bônus 3.')
doSendAnimatedText(getPlayerPosition(cid),EXP3, 179)
doPlayerAddSoul(cid,-100)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 250 then
doPlayerAddExp(cid,EXP4)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP4 .. ' de experiência, Bônus 4.')
doSendAnimatedText(getPlayerPosition(cid),EXP4, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 300 then
doPlayerAddExp(cid,EXP5)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP5 .. ' de experiência, Bônus 5.')
doSendAnimatedText(getPlayerPosition(cid),EXP5, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 350 then
doPlayerAddExp(cid,EXP6)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP6 .. ' de experiência, Bônus 6.')
doSendAnimatedText(getPlayerPosition(cid),EXP6, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 400 then
doPlayerAddExp(cid,EXP7)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP7 .. ' de experiência, Bônus 7.')
doSendAnimatedText(getPlayerPosition(cid),EXP7, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 450 then
doPlayerAddExp(cid,EXP8)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP8 .. ' de experiência, Bônus 8.')
doSendAnimatedText(getPlayerPosition(cid),EXP8, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 500 then
doPlayerAddExp(cid,EXP9)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP9 .. ' de experiência, Bônus 9.')
doSendAnimatedText(getPlayerPosition(cid),EXP9, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)

elseif PlayerLevel < 510 then
doPlayerAddExp(cid,EXP10)
doTargetCombatCondition(0, cid, condition, CONST_ME_MAGIC_RED)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. EXP10 .. ' de experiência, Bônus 10.')
doSendAnimatedText(getPlayerPosition(cid),EXP10, 179)
doPlayerAddSoul(cid,-250)
doRemoveItem(item.uid,1)
end
else
doPlayerSendTextMessage(cid,20,'Desculpe, você não tem número suficiente de almas.')
end
end
