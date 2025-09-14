function onUse(cid, item, frompos, item2, topos)
   	if item.itemid == 2160 and item.type == 100 then
   		doRemoveItem(item.uid,item.type)
   		doPlayerAddItem(cid,13685,1)
                doSendAnimatedText(getPlayerPosition(cid), "$$$$", TEXTCOLOR_RED)
   		doPlayerSendTextMessage(cid,22,"You have changed 100 Crystal coin to 1 Ruby Coin.")
   	elseif item.itemid == 2160 and item.type < 100 then
   		doRemoveItem(item.uid,1)
                doSendAnimatedText(getPlayerPosition(cid), "$$", TEXTCOLOR_PLATINUMBLUE)
   		doPlayerAddItem(cid,2152,100)
   		doPlayerSendTextMessage(cid,22,"You have changed 1 crystal coin to 100 platinum coins")
   	end
   end

