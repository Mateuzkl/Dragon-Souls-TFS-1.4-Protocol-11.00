local function Crystal2(cid)
doCreateItem(1543,1,{x=466, y=239, z=13})
end

local function Crystal3(cid)
doCreateItem(1543,1,{x=478, y=239, z=13})
end

local function Crystal4(cid)
doCreateItem(1543,1,{x=493, y=239, z=13})
end

local function Crystal5(cid)
doCreateItem(1543,1,{x=511, y=239, z=13})
end

local function Crystal6(cid)
doCreateItem(1544,1,{x=514, y=247, z=13})
end

local function Crystal7(cid)
doCreateItem(1544,1,{x=514, y=257, z=13})
end

local function Crystal8(cid)
doCreateItem(1544,1,{x=514, y=271, z=13})
end

local function Crystal9(cid)
doCreateItem(1543,1,{x=501, y=274, z=13})
end

local function Crystal10(cid)
doCreateItem(1543,1,{x=485, y=274, z=13})
doCreateItem(1543,1,{x=471, y=274, z=13})
end

function onUse(cid, item, frompos, item2, topos)

if item2.actionid == 100 and item2.itemid == 3900 then

wall1 = {x=466, y=239, z=13, stackpos=1}
wall2 = {x=465, y=237, z=13, stackpos=1}
wall3 = {x=465, y=237, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)

-------------------------------------------------------------

elseif item2.actionid == 200 and item2.itemid == 3900 then

wall1 = {x=478, y=239, z=13, stackpos=1}
wall2 = {x=477, y=237, z=13, stackpos=1}
wall3 = {x=477, y=237, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal2, 120 * 1000, cid)

-------------------------------------------------------------

elseif item2.actionid == 300 and item2.itemid == 3900 then

wall1 = {x=493, y=239, z=13, stackpos=1}
wall2 = {x=492, y=237, z=13, stackpos=1}
wall3 = {x=492, y=237, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal3, 120 * 1000, cid)

-------------------------------------------------------------

elseif item2.actionid == 400 and item2.itemid == 3900 then

wall1 = {x=511, y=239, z=13, stackpos=1}
wall2 = {x=510, y=237, z=13, stackpos=1}
wall3 = {x=510, y=237, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal4, 120 * 1000, cid)

-------------------------------------------------------------

elseif item2.actionid == 500 and item2.itemid == 3900 then

wall1 = {x=514, y=247, z=13, stackpos=1}
wall2 = {x=512, y=246, z=13, stackpos=1}
wall3 = {x=512, y=246, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal5, 120 * 1000, cid)

-------------------------------------------------------------

elseif item2.actionid == 600 and item2.itemid == 3900 then

wall1 = {x=514, y=257, z=13, stackpos=1}
wall2 = {x=512, y=256, z=13, stackpos=1}
wall3 = {x=512, y=256, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal6, 120 * 1000, cid)

-------------------------------------------------------------

elseif item2.actionid == 700 and item2.itemid == 3900 then

wall1 = {x=514, y=271, z=13, stackpos=1}
wall2 = {x=512, y=270, z=13, stackpos=1}
wall3 = {x=512, y=270, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal7, 120 * 1000, cid)

-------------------------------------------------------------

elseif item2.actionid == 800 and item2.itemid == 3900 then

wall1 = {x=501, y=274, z=13, stackpos=1}
wall2 = {x=502, y=272, z=13, stackpos=1}
wall3 = {x=502, y=272, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal8, 120 * 1000, cid)

-------------------------------------------------------------

elseif item2.actionid == 900 and item2.itemid == 3900 then

wall1 = {x=485, y=274, z=13, stackpos=1}
wall2 = {x=486, y=272, z=13, stackpos=1}
wall3 = {x=486, y=272, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal9, 120 * 1000, cid)

-------------------------------------------------------------

elseif item2.actionid == 1000 and item2.itemid == 3900 then

wall1 = {x=471, y=274, z=13, stackpos=1}
wall2 = {x=472, y=272, z=13, stackpos=1}
wall3 = {x=472, y=272, z=13, stackpos=1}

getwall1 = getThingfromPos(wall1)
getwall2 = getThingfromPos(wall2)
getwall3 = getThingfromPos(wall3)

doRemoveItem(getwall1.uid,1)
doCreateItem(2177,1,wall2)
doCreateItem(5070,1,wall3)
doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_LIGHTBLUE)
doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
doPlayerSendTextMessage(cid,22,"get hear on something open.")
doRemoveItem(item.uid,1)
addEvent(Crystal10, 120 * 1000, cid)
end
end