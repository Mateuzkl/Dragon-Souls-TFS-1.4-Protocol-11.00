function onUse(cid, item, frompos, item2, topos)

voc = getPlayerVocation(cid)
queststatus = getPlayerStorageValue(cid,212121)

if voc == 5 then
if queststatus == -1 then
doTeleportThing(cid,{x=121, y=311, z=7})
doPlayerSendTextMessage(cid,22,"You receive The Spirit of Valan.")
local item1 = doPlayerAddItem(cid,13694,1)
doSetItemSpecialDescription(item1, "This iten recorded the name vocation of Wyzard\'s." .. getPlayerName(cid) .. "  Gratz for Valan Quest.")
doPlayerSendTextMessage(cid,21,"Quest Completada 'In The Conquest of Power of Anoriel.'.")
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
setPlayerStorageValue(cid,212121,1)
else
doPlayerSendTextMessage(cid,22,"Você Já Recebeu Seus Itens Iniciais.")
end
elseif voc == 6 then
if queststatus == -1 then
doTeleportThing(cid,{x=121, y=311, z=7})
doPlayerSendTextMessage(cid,22,"You receive The Spirit of Valan.")
local item1 = doPlayerAddItem(cid,13695,1)
doSetItemSpecialDescription(item1, "This iten recorded the name vocation of Cleric\'s." .. getPlayerName(cid) .. "  Gratz for Valan Quest.")
doPlayerSendTextMessage(cid,21,"Quest Completada 'In The Conquest of Power of Anoriel.'.")
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
setPlayerStorageValue(cid,212121,1)
else
doPlayerSendTextMessage(cid,22,"Você Já Recebeu Seus Itens Iniciais.")
end
elseif voc == 7 then
if queststatus == -1 then
doTeleportThing(cid,{x=121, y=311, z=7})
doPlayerSendTextMessage(cid,22,"You receive The Spirit of Valan.")
local item1 = doPlayerAddItem(cid,13696,1)
doSetItemSpecialDescription(item1, "This iten recorded the name vocation of Ranger\'s." .. getPlayerName(cid) .. "  Gratz for Valan Quest.")
doPlayerSendTextMessage(cid,21,"Quest Completada 'In The Conquest of Power of Anoriel.'.")
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
setPlayerStorageValue(cid,212121,1)
else
doPlayerSendTextMessage(cid,22,"Você Já Recebeu Seus Itens Iniciais..")
end
elseif voc == 8 then
if queststatus == -1 then
doTeleportThing(cid,{x=121, y=311, z=7})
doPlayerSendTextMessage(cid,22,"You receive The Spirit of Valan.")
local item1 = doPlayerAddItem(cid,13697,1)
doSetItemSpecialDescription(item1, "This iten recorded the name vocation of Slayer\'s." .. getPlayerName(cid) .. "  Gratz for Valan Quest.")
doPlayerSendTextMessage(cid,21,"Quest Completada 'In The Conquest of Power of Anoriel.'.")
doSendMagicEffect(topos,10)
doSendMagicEffect(getPlayerPosition(cid),10)
setPlayerStorageValue(cid,212121,1) else
doPlayerSendTextMessage(cid,22,"Você Já Recebeu Seus Itens Iniciais..")
end
else
return 0
end

return 1
end
