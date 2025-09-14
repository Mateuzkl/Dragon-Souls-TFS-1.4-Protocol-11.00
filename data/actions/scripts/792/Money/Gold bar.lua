function onUse(cid, item, frompos, item2, topos)
  	if doRemoveItem(item.uid,1) then
                doSendAnimatedText(getPlayerPosition(cid), "$$$$$", TEXTCOLOR_TEAL)
  		doPlayerSendTextMessage(cid,22,"You have changed 1 Gold Bar to 100 Rubys Coins.")
  		doPlayerAddItem(cid,13685,100)
  	end
   end

