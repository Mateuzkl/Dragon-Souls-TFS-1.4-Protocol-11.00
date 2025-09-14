function onUse(cid,item,frompos,item2,topos)
	number = math.random(1,100)
	chance = 8

	if chance > 100 or chance == 0 then
		chance = 100
	end

--minos--
	if item2.itemid == 2830 or item2.itemid == 2871 or item2.itemid == 2876 or item2.itemid == 2866 then
		if number <= chance then
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doPlayerAddItem(cid,5878,1)
			doTransformItem(item2.uid,item2.itemid+1)
		else
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doTransformItem(item2.uid,item2.itemid+1)
		end
		return 1
	end

--lizard--
	if item2.itemid == 4259 or item2.itemid == 4262 or item2.itemid == 4256 then
		if number <= chance then
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doPlayerAddItem(cid,5876,1)
			doTransformItem(item2.uid,item2.itemid+1)
		else
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doTransformItem(item2.uid,item2.itemid+1)
		end
		return 1
	end

--dragon
	if item2.itemid == 3104 or item2.itemid == 2844 then
		if number <= chance then
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doPlayerAddItem(cid,5877,1)
			doTransformItem(item2.uid,item2.itemid+1)
		else
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doTransformItem(item2.uid,item2.itemid+1)
		end
		return 1
	end
--dragon lord
	if item2.itemid == 2881 then
		if number <= chance then
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doPlayerAddItem(cid,5948,1)
			doTransformItem(item2.uid,item2.itemid+1)
		else
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doTransformItem(item2.uid,item2.itemid+1)
		end
		return 1
	end
	if item2.itemid == 3031 then
		if number <= chance then
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doPlayerAddItem(cid,5925,1)
			doTransformItem(item2.uid,item2.itemid+1)
		else
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doTransformItem(item2.uid,item2.itemid+1)
		end
		return 1
	end

--behemoth
	if item2.itemid == 2931 then
		if number <= chance then
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doPlayerAddItem(cid,5893,1)
			doTransformItem(item2.uid,item2.itemid+1)
		else
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doTransformItem(item2.uid,item2.itemid+1)
		end
		return 1
	end

--bone beast
	if item2.itemid == 3031 then
		if number <= chance then
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doPlayerAddItem(cid,5925,1)
			doTransformItem(item2.uid,item2.itemid+1)
		else
			doSendMagicEffect(topos,CONST_ME_HITAREA)
			doTransformItem(item2.uid,item2.itemid+1)
		end
		return 1
	end

--campfire
	if item2.itemid == 1422 then
		if number == 100 then
			doSendMagicEffect(topos,CONST_ME_HITBYFIRE)
			doCreateItem(1423, 1, topos)
			doRemoveItem(item.uid,1)
			doRemoveItem(item2.uid,1)
		else
			doSendMagicEffect(topos,CONST_ME_HITBYFIRE)
			doCreateItem(1423, 1, topos)
			doRemoveItem(item.uid,1)
			doRemoveItem(item2.uid,1)
		end
		return 1
	end
	return 0
end