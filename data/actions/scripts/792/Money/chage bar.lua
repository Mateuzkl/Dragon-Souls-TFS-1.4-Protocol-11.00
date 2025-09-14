function onUse(cid, item, frompos, item2, topos)
   	if item.itemid == 13685 and item.type == 100 then
   		doRemoveItem(item.uid,item.type)
   		doPlayerAddItem(cid,14710,1)
                doSendAnimatedText(getPlayerPosition(cid), "$$$$", TEXTCOLOR_RED)
   		doPlayerSendTextMessage(cid,22,"You have changed 100 ruby coin to 1 Gold bar")
  	end
  end

