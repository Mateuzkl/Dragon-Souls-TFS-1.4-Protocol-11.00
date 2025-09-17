function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Silence!", 255)
doSendMagicEffect(getCreaturePosition(cid), 110)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 
end
	doSendAnimatedText(getCreaturePosition(cid), "Light!", TEXTCOLOR_LIGHTBLUE)
	doSendMagicEffect(getCreaturePosition(cid), 12)
	local pos = getPlayerPosition(cid)
	doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
	return doSetCreatureLight(cid, 1000, 1000, (1000*1000+1000)*1000)
end