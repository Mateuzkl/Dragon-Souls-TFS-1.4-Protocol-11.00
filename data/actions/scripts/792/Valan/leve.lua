function onUse(cid, item, frompos, item2, topos)

if item.uid == 32233 then
	queststatus = getPlayerStorageValue(cid,32233)
	if queststatus == -1 then
	doPlayerSendTextMessage(cid,22,"Você encontrou uma chave atras do quadro.")
	doSendMagicEffect(topos,CONST_ME_MAGIC_BLUE)
	doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
	EXP = math.random(30300000,40000000)
	doPlayerAddItem(cid,6527,100)
		doPlayerAddItem(cid,6527,100)
			doPlayerAddItem(cid,6527,100)
				doPlayerAddItem(cid,6527,100)
					doPlayerAddItem(cid,6527,100)
						doPlayerAddItem(cid,6527,100)
							doPlayerAddItem(cid,13685,100)
							doPlayerAddItem(cid,13685,100)
							doPlayerAddItem(cid,13586,1)
							doPlayerAddItem(cid,13594,1)
							doPlayerAddItem(cid,13560,1)
							doPlayerAddItem(cid,13557,1)
							doPlayerAddItem(cid,13593,1)
							doPlayerAddItem(cid,13528,1)
	else
		doPlayerSendTextMessage(cid,22,"It is empty.")
	end
	else
		return 0
   	end

   	return 1
end


            