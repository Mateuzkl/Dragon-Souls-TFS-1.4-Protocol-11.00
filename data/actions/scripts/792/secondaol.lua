function onUse(cid, item, frompos, item2, topos)

if item.itemid == 13623 then
doPlayerAddAddon(cid, 128, 3)
doPlayerAddAddon(cid, 136, 3)
doPlayerAddItem(cid,13682,1)
doSendAnimatedText(getPlayerPosition(cid), "Amulet!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
end
end