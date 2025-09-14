function onUse(cid, item, frompos, item2, topos)

if getPlayerVocation(cid) < 9 then
if getPlayerLevel(cid) > 199 then
pos = getPlayerPosition(cid)
if pos.x == topos.x then
if pos.y < topos.y then
pos.y = topos.y + 1
else
pos.y = topos.y - 1
end
elseif pos.y == topos.y then
if pos.x < topos.x then
pos.x = topos.x + 1
else
pos.x = topos.x - 1
end
else
doPlayerSendTextMessage(cid,22,'Fique em frente à porta.')
return 1
end
doTeleportThing(cid,pos)
doSendMagicEffect(topos,12)
else
doPlayerSendTextMessage(cid,22,"Voce nao é um mortal ou nao possui level 200.")
end
end
end