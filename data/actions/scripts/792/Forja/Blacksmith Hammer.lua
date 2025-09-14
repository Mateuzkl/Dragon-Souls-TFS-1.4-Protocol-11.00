function onUse(cid, item, frompos, item2, topos)

piecepos1 = {x=444, y=197, z=4, stackpos=2} or {x=444, y=201, z=4, stackpos=2}
piecepos2 = {x=443, y=197, z=4, stackpos=2} or {x=443, y=201, z=4, stackpos=2}
piecepos3 = {x=443, y=198, z=4, stackpos=2} or {x=443, y=202, z=4, stackpos=2}
piecepos4 = {x=443, y=199, z=4, stackpos=2} or {x=443, y=203, z=4, stackpos=2}
piecepos5 = {x=444, y=199, z=4, stackpos=2} or {x=444, y=203, z=4, stackpos=2}

getpiece1 = getThingfromPos(piecepos1)
getpiece2 = getThingfromPos(piecepos2)
getpiece3 = getThingfromPos(piecepos3)
getpiece4 = getThingfromPos(piecepos4)
getpiece5 = getThingfromPos(piecepos5)

if getpiece1.itemid == 2321 and getpiece3.itemid == 2149 and getpiece3.type == 10 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	if random_number<=skill_level then
	doTransformItem(item2.uid,13626)
	doDecayItem(item2.uid)
	doPlayerSendTextMessage(cid,19,"Voce refinou 10 small emeralds.")
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)
   
elseif getpiece1.itemid == 2321 and getpiece3.itemid == 2153 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	if random_number<=skill_level then
	doTransformItem(item2.uid,13632)
	doDecayItem(item2.uid)
	doPlayerSendTextMessage(cid,19,"Voce refinou um violet gem.")
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)
   
elseif getpiece1.itemid == 2321 and getpiece3.itemid == 2157 and getpiece3.type == 10 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	if random_number<=skill_level then
	doTransformItem(item2.uid,13633)
	doDecayItem(item2.uid)
	doPlayerSendTextMessage(cid,19,"Voce refinou 10 gold nuggets.")
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)
   
elseif getpiece1.itemid == 2321 and getpiece3.itemid == 13641 and getpiece3.type == 10 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	if random_number<=skill_level then
	doRemoveItem(item2.uid,item2.type)
	doPlayerAddItem(cid,13685,1)
	doPlayerSendTextMessage(cid,19,"Voce refinou 10 iron nuggets.")
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)
else 
return 0
end
return 1
end
