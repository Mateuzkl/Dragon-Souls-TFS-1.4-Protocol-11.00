local drunk = createConditionObject(CONDITION_DRUNK)
setConditionParam(drunk, CONDITION_PARAM_TICKS, 60000)
local poison = createConditionObject(CONDITION_POISON)
addDamageCondition(poison, 2, 6000, -5)
addDamageCondition(poison, 3, 6000, -4)
addDamageCondition(poison, 5, 6000, -3)
addDamageCondition(poison, 10, 6000, -2)
addDamageCondition(poison, 20, 6000, -1)
local fluidType = {3, 4, 5, 7, 10, 11, 13, 15, 19, 23}
local fluidMessage = {"Aah...", "Urgh!", "Mmmh.", "Aaah.", "Aaaah...", "Urgh!", "Urgh!", "Aaaah.", "Urgh!", "Aaaaah."}
function onUse(cid, item, fromPosition, itemEx, toPosition)
	if itemEx.itemid == 1 then
		if item.type == 0 then
			doPlayerSendCancel(cid, "It is empty.")
			elseif itemEx.uid == cid then
			doChangeTypeItem(item.uid, 0)
			if item.type == 3 or item.type == 15 then
				doTargetCombatCondition(0, cid, drunk, CONST_ME_NONE)
			elseif item.type == 4 then
				doTargetCombatCondition(0, cid, poison, CONST_ME_NONE)
			elseif item.type == 7 then
				doPlayerAddMana(cid, math.random(100, 250))
				doSendMagicEffect(fromPosition, CONST_ME_MAGIC_BLUE)
			elseif item.type == 10 then
				doPlayerAddHealth(cid, 60)
				doSendMagicEffect(fromPosition, CONST_ME_MAGIC_BLUE)
			elseif item.type == 31 then
				doPlayerAddMana(cid, math.random(250, 350))
				doSendMagicEffect(fromPosition, CONST_ME_MAGIC_BLUE)
			elseif item.type == 39 then
				doPlayerAddMana(cid, math.random(350, 500))
				doSendMagicEffect(fromPosition, CONST_ME_MAGIC_BLUE)
			end
			for i = 0, table.maxn(fluidType) do
				if item.type == fluidType[i] then
					doSendAnimatedText(getPlayerPosition(cid),fluidMessage[i], TEXTCOLOR_ORANGE)
					return TRUE
				end
			end
                 doSendAnimatedText(getPlayerPosition(cid), "Aaaahh..",TEXTCOLOR_ORANGE)
		else
			local splash = doCreateItem(2025, item.type, toPosition)
			doChangeTypeItem(item.uid, 0)
			doDecayItem(splash)
		end
	elseif (itemEx.itemid >= 490 and itemEx.itemid <= 493) or (itemEx.itemid >= 4608 and itemEx.itemid <= 4625) or (itemEx.itemid >= 618 and itemEx.itemid <= 629) or itemEx.itemid == 1771 then
		doChangeTypeItem(item.uid, 9)
	elseif itemEx.itemid == 103 then
		doChangeTypeItem(item.uid, 19)
	elseif (itemEx.itemid >= 598 and itemEx.itemid < 712) or itemEx.itemid == 1509 then
		doChangeTypeItem(item.uid, 26)
	elseif (itemEx.itemid >= 351 and itemEx.itemid <= 355) then
		doChangeTypeItem(item.uid, 19)
	elseif (itemEx.itemid >= 602 and itemEx.itemid <= 605) then
		doChangeTypeItem(item.uid, 28)
	elseif itemEx.itemid == 1772 then
		doChangeTypeItem(item.uid, 3)
	elseif itemEx.itemid == 1773 then
		doChangeTypeItem(item.uid, 15)
	elseif itemEx.itemid == 5739 then
		doSendMagicEffect(toPosition,CONST_ME_MAGIC_BLUE)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
		doChangeTypeItem(item.uid, 1)
	elseif itemEx.itemid == 1504 then
		doRemoveItem(item.uid,item.type)
		doRemoveItem(itemEx.uid,1)
		doSendMagicEffect(toPosition,CONST_ME_MAGIC_BLUE)
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
		doCreateItem(1422, 1, toPosition)
		doCreateItem(5908, 1, toPosition)
	elseif item.type == 0 then
		doPlayerSendCancel(cid, "It is empty.")
	else
		if toPosition.x == CONTAINER_POSITION then
			toPosition = getCreaturePosition(cid)
		end
		splash = doCreateItem(2025, item.type, toPosition)
		doChangeTypeItem(item.uid, 0)
		doDecayItem(splash)
	end
	return TRUE
end