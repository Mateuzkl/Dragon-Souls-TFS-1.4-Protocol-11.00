function onUse(cid, item, frompos, item2, topos)
   	if item.itemid == 2148 and item.type == 100 then
   		doRemoveItem(item.uid,item.type)
   		doPlayerAddItem(cid,2152,1)
                doSendAnimatedText(getPlayerPosition(cid), "$$", TEXTCOLOR_PLATINUMBLUE)
   		doPlayerSendTextMessage(cid,22,"You have changed 100 gp to 1 platinum coin")
   	elseif item.itemid == 2148 and item.type < 100 then
   		doPlayerSendTextMessage(cid,22,"You have to got 100 gp's to change for platinum coin")
   	end
   end
