-- Exhausted Settings --
local exhausted_seconds = 1
local exhausted_storagevalue = 9893
local large_mana_fluid = 11771
-- Exhausted Settings END --

function onUse(cid, item, frompos, item2, topos)
min = (5*getPlayerMaxMana(cid)/100 +250)
max = (5*getPlayerMaxMana(cid)/100 +305)
if (exhaust(cid, 1000, 1) > 0) then -------- storage = 9893
mana = math.random(min,max)
doPlayerAddMana(cid,mana)
doSendAnimatedText(getPlayerPosition(cid), "Aaaahh..",TEXTCOLOR_ORANGE)
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
