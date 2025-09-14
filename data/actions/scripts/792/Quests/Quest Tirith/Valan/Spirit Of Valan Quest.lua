function onUse(cid, item, frompos, item2, topos)

voc = getPlayerVocation(cid)
queststatus = getPlayerStorageValue(cid,2361)

if voc == 5 then
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"Você recebeu o Espirito de um Valan.")
local item1 = doPlayerAddItem(cid,2361,1)
doSetItemSpecialDescription(item1, "Esse item é uma recordação com a vocação Wyzard\'s." .. getPlayerName(cid) .. "  Obrigado pela Valan Quest.")
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTGREEN)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doShowTextDialog(cid,2180,"Parabéns ao ter chegado aqui, agora crie um novo jogador e esse spirit of valan no seu novo char level 8 ele ira ser seu novo valan.")
setPlayerStorageValue(cid,2361,1)
else
doPlayerSendTextMessage(cid,22,"Está vazio, você já completou essa missão.")
end
elseif voc == 6 then
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"Você recebeu o Espirito de um Valan.")
local item1 = doPlayerAddItem(cid,2361,1)
doSetItemSpecialDescription(item1, "Esse item é uma recordação com a vocação Cleric\'s." .. getPlayerName(cid) .. "  Obrigado pela Valan Quest.")
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTGREEN)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doShowTextDialog(cid,2180,"Parabéns ao ter chegado aqui, agora crie um novo jogador e esse spirit of valan no seu novo char level 8 ele ira ser seu novo valan.")
setPlayerStorageValue(cid,2361,1)
else
doPlayerSendTextMessage(cid,22,"Está vazio, você já completou essa missão.")
end
elseif voc == 7 then
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"Você recebeu o Espirito de um Valan.")
local item1 = doPlayerAddItem(cid,2361,1)
doSetItemSpecialDescription(item1, "Esse item é uma recordação com a vocação Ranger\'s." .. getPlayerName(cid) .. "  Obrigado pela Valan Quest.")
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTGREEN)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doShowTextDialog(cid,2180,"Parabéns ao ter chegado aqui, agora crie um novo jogador e esse spirit of valan no seu novo char level 8 ele ira ser seu novo valan.")
setPlayerStorageValue(cid,2361,1)
else
doPlayerSendTextMessage(cid,22,"Está vazio, você já completou essa missão.")
end
elseif voc == 8 then
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"Você recebeu o Espirito de um Valan.")
local item1 = doPlayerAddItem(cid,2361,1)
doSetItemSpecialDescription(item1, "Esse item é uma recordação com a vocação Slayer\'s." .. getPlayerName(cid) .. "  Obrigado pela Valan Quest.")
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTGREEN)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doShowTextDialog(cid,2180,"Parabéns ao ter chegado aqui, agora crie um novo jogador e esse spirit of valan no seu novo char level 8 ele ira ser seu novo valan.")
setPlayerStorageValue(cid,2361,1)
else
doPlayerSendTextMessage(cid,22,"Está vazio, você já completou essa missão.")
end
else
doPlayerSendTextMessage(cid,22,"Desculpe, mas você não tem vocação necessária.")
return 0
end
return 1
end
