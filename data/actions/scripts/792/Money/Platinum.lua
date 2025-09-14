function onUse(cid, item, frompos, item2, topos)
   	if item.itemid == 2152 and item.type == 100 then
   		doRemoveItem(item.uid,item.type)
   		doPlayerAddItem(cid,2160,1)
                doSendAnimatedText(getPlayerPosition(cid), "$$$", TEXTCOLOR_TEAL)
   		doPlayerSendTextMessage(cid,22,"You have changed 100 platinum to 1 crystal coin")
   	elseif item.itemid == 2152 and item.type < 100 then
   		doRemoveItem(item.uid,1)
                doSendAnimatedText(getPlayerPosition(cid), "$", TEXTCOLOR_YELLOW)
   		doPlayerAddItem(cid,2148,100)
   		doPlayerSendTextMessage(cid,22,"You have changed 1 platinum to 100 gold coins")
   	end
   end
