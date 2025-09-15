function onCastSpell(cid, var)
	local pos = getPlayerPosition(cid)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
 	doPlayerSay(cid,"Light on!",16)
	return doSetCreatureLight(cid, 7, 215, (6*60+10)*1000)
else
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
	return doSetCreatureLight(cid, 7, 215, (6*60+10)*1000)
end
end