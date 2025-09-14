-- Exhausted Settings --
local exhausted_seconds = 1 -- How many seconds mana fluid will be unavailible to use. --
local exhausted_storagevalue = 9893 -- Storage Value to store exhaust. It MUST be unused! --
-- Exhausted Settings END --

function onUse(cid, item, frompos, item2, topos)
min = (5*getPlayerMaxMana(cid)/100 +250)
max = (5*getPlayerMaxMana(cid)/100 +305)
if(os.time() >= getPlayerStorageValue(cid, exhausted_storagevalue)) then
mana = math.random(min,max)
doPlayerAddMana(cid,mana)
doSendAnimatedText(getPlayerPosition(cid), "Aaaahh..",TEXTCOLOR_ORANGE)
setPlayerStorageValue(cid, exhausted_storagevalue, os.time() + exhausted_seconds)
doSendMagicEffect(getCreaturePosition(cid), 12)
if item.type > 1 then
doChangeTypeItem(item.uid,item.type-1)
else
 doRemoveItem(item.uid,1)
end
else
 doPlayerSendCancel(cid,"Você não pode usar este objeto.")
end
 return 1
   end
