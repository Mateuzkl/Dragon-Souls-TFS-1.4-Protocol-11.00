function onUse(cid, item, frompos, item2, topos)
 
if item2.itemid == 13685 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,356)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)
   
elseif item2.itemid == 13687 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,360)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)
   
elseif item2.itemid == 13686 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,358)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)
   
elseif item2.itemid == 13640 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,367)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

elseif item2.itemid == 13638 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,364)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

elseif item2.itemid == 13639 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,365)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

elseif item2.itemid == 387 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,386)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

elseif item2.itemid == 386 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,390)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

elseif item2.itemid == 390 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,391)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

elseif item2.itemid == 391 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Trinck", 213)
	doSendMagicEffect(topos,CONST_ME_POFF)
	if random_number<=skill_level then
	doTransformItem(item2.uid,355)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,13641,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)
else 
return 0
end
return 1
end
