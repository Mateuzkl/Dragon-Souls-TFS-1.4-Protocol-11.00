function onStepIn(cid, item, position, fromPosition)
---- Config ----
local volta = {x=443, y=234, z=14, stackpos=1}
msg = "Voce errou o caminho."
----------------


doPlayerSendTextMessage(cid, 24, msg)
               doTeleportThing(cid,volta) 
               doSendMagicEffect(getPlayerPosition(cid),10) 
end