function onUse(cid, item, frompos, item2, topos)
           Voc = getPlayerVocation(cid)
           local teleport1 = {x=438, y=237, z=15, stackpos=1}
           local teleport2 = {x=438, y=242, z=15, stackpos=1}
           local teleport3 = {x=444, y=242, z=15, stackpos=1}
           local teleport4 = {x=444, y=237, z=15, stackpos=1}

           if Voc == 5 then
           doSendMagicEffect(getPlayerPosition(cid),2)
           doTeleportThing(cid,teleport1) 
           doSendMagicEffect(getPlayerPosition(cid),10) 

           elseif Voc == 6 then
           doSendMagicEffect(getPlayerPosition(cid),2)
           doTeleportThing(cid,teleport2)
           doSendMagicEffect(getPlayerPosition(cid),10) 

           elseif Voc == 7 then
           doSendMagicEffect(getPlayerPosition(cid),2)
           doTeleportThing(cid,teleport3) 
           doSendMagicEffect(getPlayerPosition(cid),10)

           elseif Voc == 8 then
           doSendMagicEffect(getPlayerPosition(cid),2)
           doTeleportThing(cid,teleport4)
           doSendMagicEffect(getPlayerPosition(cid),10) 
           else
          doPlayerSendTextMessage(cid,22,"Desculpe, você não tem vocação necessária.")
end
end