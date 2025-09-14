function onUse(cid, item, frompos, item2, topos)

if item.actionid == 100 then
end

if (getPlayerFood(cid) + 10000 > 10000) then
doPlayerSendCancel(cid,"You dont need water now.")
else
doPlayerFeed(cid, 10000 * 4)
doSendMagicEffect(topos,1)
doPlayerAddHealth(cid,10000000)
doSendMagicEffect(getPlayerPosition(cid),12)
doPlayerSay(cid,"Ah... Fresh Water!!!", 16)
end
return 1
end