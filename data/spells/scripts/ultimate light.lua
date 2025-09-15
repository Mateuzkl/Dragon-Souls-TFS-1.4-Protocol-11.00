function onCastSpell(cid, var)
	local pos = getPlayerPosition(cid)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"On Darkness, the light will show you the way!",16)
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
	return doSetCreatureLight(cid, 11, 215, (60*33+10)*1000)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Light, show me the way!",16)
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
	return doSetCreatureLight(cid, 11, 215, (60*33+10)*1000)
else
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
	return doSetCreatureLight(cid, 11, 215, (60*33+10)*1000)
end
end