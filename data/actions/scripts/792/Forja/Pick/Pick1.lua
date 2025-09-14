function onUse(cid, item, frompos, item2, topos)

Rubys = math.random(1,10)

if item2.itemid == 13685 then

	if Rubys == 7 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	doPlayerSendTextMessage(cid,22,"Voce achou um small stone.")
	if random_number<=skill_level then
	doTransformItem(item2.uid,356)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,1294,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

	elseif Rubys == 6 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	doPlayerSendTextMessage(cid,22,"Voce achou um small diamond.")
	if random_number<=skill_level then
	doTransformItem(item2.uid,356)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,2145,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

	elseif Rubys == 5 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	doPlayerSendTextMessage(cid,22,"Voce achou um small sapphire.")
	if random_number<=skill_level then
	doTransformItem(item2.uid,356)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,2146,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

	elseif Rubys == 4 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	doPlayerSendTextMessage(cid,22,"Voce achou um small ruby.")
	if random_number<=skill_level then
	doTransformItem(item2.uid,356)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,2147,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

	elseif Rubys == 3 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	doPlayerSendTextMessage(cid,22,"Voce achou um small emerald.")
	if random_number<=skill_level then
	doTransformItem(item2.uid,356)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,2149,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

	elseif Rubys == 2 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	doPlayerSendTextMessage(cid,22,"Voce achou um small amethyst.")
	if random_number<=skill_level then
	doTransformItem(item2.uid,356)
	doDecayItem(item2.uid)
	doPlayerAddItem(cid,2150,1)
	doPlayerAddHealth(cid, -25)
end
	doPlayerAddSkillTry(cid,6,1)
	doPlayerAddHealth(cid, -25)

	elseif Rubys == 1 then
	skill_level = getPlayerSkill(cid,6)
	random_number = math.random(1,(100+skill_level/10))
	doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
	doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
	doPlayerSendTextMessage(cid,22,"Voce achou um iron nugget.")
	if random_number<=skill_level then
	doTransformItem(item2.uid,356)
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
end
