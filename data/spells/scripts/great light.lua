function onCastSpell(cid, var)
	local pos = getPlayerPosition(cid)
	rand = math.random(1,50)
	if rand == 1 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"Get out shadow!",16)
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
	return doSetCreatureLight(cid, 9, 215, (60*11+35)*1000)
	elseif rand == 2 and isPlayer(cid) == 1 then
 	doPlayerSay(cid,"The light!",16)
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
	return doSetCreatureLight(cid, 9, 215, (60*11+35)*1000)
else
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
	return doSetCreatureLight(cid, 9, 215, (60*11+35)*1000)
end
end