-- Exhausted Settings --
local exhausted_seconds = 1
local exhausted_storagevalue = 9867
local mana_fluid = 10085
-- Exhausted Settings END --

function onUse(cid, item, frompos, item2, topos)
skill = getPlayerSkill(cid,0)
maglevel = getPlayerMagLevel(cid)
level = getPlayerLevel(cid)
min = ((maglevel*6)+(skill*2)+(level*2)+400)
max = ((maglevel*8)+(skill*3)+(level*3)+401)
if (exhaust(cid, 1000, 1) > 0) then -------- storage = 9867
mana = math.random(min,max)
doPlayerAddMana(cid,mana)
doSendAnimatedText(getPlayerPosition(cid), "Aaaahh..",TEXTCOLOR_ORANGE)
doPlayerSendCancel(cid,' You have recieved ' .. mana .. ' of your manapoints.')
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
