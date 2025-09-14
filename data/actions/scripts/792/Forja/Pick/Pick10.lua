function onUse(cid, item, frompos, item2, topos)

if item2.itemid == 391 then
skill_level = getPlayerSkill(cid,6)
random_number = math.random(1,(100+skill_level/10))
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
if random_number<=skill_level then
doTransformItem(item2.uid,355)
doDecayItem(item2.uid)
doPlayerAddItem(cid,13641,1)
doPlayerAddHealth(cid, -25)
end
doPlayerAddSkillTry(cid,6,1)
doPlayerAddHealth(cid, -25)

Rubys = math.random(1,10)

if Rubys == 7 then
skill_level = getPlayerSkill(cid,6)
random_number = math.random(1,(100+skill_level/10))
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doPlayerSendTextMessage(cid,22,"Voce achou um small stone.")
elseif random_number<=skill_level then
doTransformItem(item2.uid,355)
doDecayItem(item2.uid)
doPlayerAddItem(cid,1294,1)
doPlayerAddHealth(cid, -25)

elseif Rubys == 6 then
skill_level = getPlayerSkill(cid,6)
random_number = math.random(1,(100+skill_level/10))
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doPlayerSendTextMessage(cid,22,"Voce achou um small diamond.")
elseif random_number<=skill_level then
doTransformItem(item2.uid,355)
doDecayItem(item2.uid)
doPlayerAddItem(cid,2145,1)
doPlayerAddHealth(cid, -25)

elseif Rubys == 5 then
skill_level = getPlayerSkill(cid,6)
random_number = math.random(1,(100+skill_level/10))
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doPlayerSendTextMessage(cid,22,"Voce achou um small sapphire.")
elseif random_number<=skill_level then
doTransformItem(item2.uid,355)
doDecayItem(item2.uid)
doPlayerAddItem(cid,2146,1)
doPlayerAddHealth(cid, -25)

elseif Rubys == 4 then
skill_level = getPlayerSkill(cid,6)
random_number = math.random(1,(100+skill_level/10))
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doPlayerSendTextMessage(cid,22,"Voce achou um small ruby.")
elseif random_number<=skill_level then
doTransformItem(item2.uid,355)
doDecayItem(item2.uid)
doPlayerAddItem(cid,2147,1)
doPlayerAddHealth(cid, -25)

elseif Rubys == 3 then
skill_level = getPlayerSkill(cid,6)
random_number = math.random(1,(100+skill_level/10))
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doPlayerSendTextMessage(cid,22,"Voce achou um small emerald.")
elseif random_number<=skill_level then
doTransformItem(item2.uid,355)
doDecayItem(item2.uid)
doPlayerAddItem(cid,2149,1)
doPlayerAddHealth(cid, -25)

elseif Rubys == 2 then
skill_level = getPlayerSkill(cid,6)
random_number = math.random(1,(100+skill_level/10))
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doPlayerSendTextMessage(cid,22,"Voce achou um small amethyst.")
elseif random_number<=skill_level then
doTransformItem(item2.uid,355)
doDecayItem(item2.uid)
doPlayerAddItem(cid,2150,1)
doPlayerAddHealth(cid, -25)

elseif Rubys == 1 then
skill_level = getPlayerSkill(cid,6)
random_number = math.random(1,(100+skill_level/10))
doSendAnimatedText(topos, "Cleck!", TEXTCOLOR_ORANGE)
doSendMagicEffect(topos,CONST_ME_BLOCKHIT)
doPlayerSendTextMessage(cid,22,"Voce achou um iron nugget.")
elseif random_number<=skill_level then
doTransformItem(item2.uid,355)
doDecayItem(item2.uid)
doPlayerAddItem(cid,13641,1)
doPlayerAddHealth(cid, -25)
else 
return 0
end
return 1
end
end
