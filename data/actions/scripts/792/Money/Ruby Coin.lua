function onUse(cid, item, frompos, item2, topos)
  	if doRemoveItem(item.uid,1) then
                doSendAnimatedText(getPlayerPosition(cid), "$$$$", TEXTCOLOR_TEAL)
  		doPlayerSendTextMessage(cid,22,"You have changed 1 ruby coins to 100 Crystal Coins.")
  		doPlayerAddItem(cid,2160,100)
  	end
  end

