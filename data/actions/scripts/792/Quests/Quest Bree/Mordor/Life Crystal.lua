function onUse(cid, item, frompos, item2, topos)

local wall1 = {x=1055, y=1772, z=4, stackpos=2}
local wall2 = {x=1055, y=1773, z=4, stackpos=2}
local wall3 = {x=1052, y=1762, z=4, stackpos=1}
local wall4 = {x=1052, y=1762, z=4, stackpos=1}

local getwall1 = getThingfromPos(wall1)
local getwall2 = getThingfromPos(wall2)
local getwall3 = getThingfromPos(wall3)
local getwall4 = getThingfromPos(wall4)

if item2.actionid == 100 and item2.itemid == 3900 then

doRemoveItem(getwall1.uid,1)
doRemoveItem(getwall2.uid,1)
doCreateItem(2177,1,wall4)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
end
end